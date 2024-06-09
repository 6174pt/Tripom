//
//  SettingViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/06/09.
//

import UIKit
import RealmSwift
import PhotosUI

class SettingViewController: UIViewController, PHPickerViewControllerDelegate {
    
    let profileView: UIView = UIView()
    let tripLevelLabel: UILabel = UILabel()
    let userNameLabel: UILabel = UILabel()
    let userIDLabel: UILabel = UILabel()
    
    let iconImageView: UIImageView = UIImageView()
    let iconImageButton: UIButton = UIButton()
    
    let realm = try! Realm()
    var photoURL: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        userのプロフィールを取得
        let userData = realm.objects(User.self)
        if let user = userData.first {
            tripLevelLabel.text = "Lv. \(user.tripLevel)"
            userNameLabel.text = user.userName
            userIDLabel.text = user.userID
            
            if let fileURL = URL(string: user.userIconImageURL) {
                // ファイルパスを取得
                let filePath = fileURL.path
                print("filePath", filePath)
                
                // FileManagerを使用してファイルの存在を確認
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: filePath) {
                    print("ファイルは存在します")
                    // ファイルが存在する場合、UIImageを設定
                    if let data = try? Data(contentsOf: fileURL),
                       let image = UIImage(data: data) {
                        iconImageButton.setImage(image, for: .normal)
//                        iconImageView.image = image
                    } else {
                        print("ファイルは存在しますが、UIImageに変換できません")
                        iconImageButton.setImage(UIImage(named: "defaultImage"), for: .normal)
//                        iconImageView.image = UIImage(named: "defaultImage")
                    }
                } else {
                    print("ファイルが存在しません")
                    iconImageButton.setImage(UIImage(named: "defaultImage"), for: .normal)
//                    iconImageView.image = UIImage(named: "defaultImage")
                }
            } else {
                print("無効なURLです")
                iconImageButton.setImage(UIImage(named: "defaultImage"), for: .normal)
//                iconImageView.image = UIImage(named: "defaultImage")
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //        プロフィール表示ビュー
        profileView.frame=CGRect(x: 0, y: view.frame.size.height / 2 - view.frame.size.width / 2, width: view.frame.size.width, height: view.frame.size.width)
        profileView.backgroundColor = UIColor.white
        view.addSubview(profileView)
        
        //        ユーザーアイコンボタン
        let iconImageSize: CGFloat = view.frame.size.width * 1 / 3
//        let iconImageView = UIImageView()
//        iconImageView.image = UIImage(named: "icon")
        iconImageButton.frame = CGRect(x: view.frame.size.width / 2 - iconImageSize / 2, y: view.frame.size.width / 6, width: iconImageSize, height: iconImageSize)
        iconImageButton.layer.cornerRadius = iconImageSize / 2
        iconImageButton.layer.masksToBounds = true
        iconImageButton.addAction(UIAction(handler: { _ in
            self.tappediconImageButton()
        }), for: .touchUpInside)
        profileView.addSubview(iconImageButton)
        
        //        ユーザー名
        userNameLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.width * 2 / 3, width: iconImageSize + 50 , height: iconImageSize / 4)
        userNameLabel.textAlignment = NSTextAlignment.center
        //        userNameLabel.text = "\(userName)"
        profileView.addSubview(userNameLabel)
        
        //        ユーザーID
        userIDLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.width * 3 / 4, width: iconImageSize + 50 , height: iconImageSize / 4)
        userIDLabel.textAlignment = NSTextAlignment.center
        //        userIDLabel.text = "\(userID)"
        userIDLabel.textColor = UIColor.gray
        profileView.addSubview(userIDLabel)
    }
    
    @objc func tappediconImageButton() {
        //            PHPickerの表示
        var configuration = PHPickerConfiguration()
        //            PHPickerで取得できるメディアの種類を画像に限定
        let filter = PHPickerFilter.images
        configuration.filter = filter
        //            PHPickerで取得できる画像の数を(とりあえず)一枚に限定
//        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        //        PHPickerを閉じる
        picker.dismiss(animated: true, completion: nil)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                guard let self = self else { return } // selfがnilでないことを確認
                if let image = object as? UIImage {
                    
                    DispatchQueue.main.async {
                        self.iconImageButton.setImage(image, for: .normal)
//                        self.photoArray.append(image)
//                        self.tripPhotoCollectionView.reloadData()
                    }
                    let imageName = UUID().uuidString + ".jpeg"// ユニークな画像名を生成
                    
                    //        画像をJPEGデータに変換
                    if let data = image.jpegData(compressionQuality: 1.0) {
                        //            アプリ内のドキュメントディレクトリの場所（住所）を取得する
                        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        print("documentsDirectory", documentsDirectory)
                        //            ドキュメントディレクトリに画像データの保存場所（ファイル）を作成（画像データの名称と同じにする）
                        let fileURL = documentsDirectory.appendingPathComponent(imageName)
                        do {
                            try data.write(to: fileURL)
                            print("fileURL", fileURL)
                            self.photoURL = fileURL.absoluteString
                        } catch {
                            print("Error writing file: \(error)")
                        }
                        print("fileURL", fileURL)
                        DispatchQueue.main.async {
                            self.photoURL = fileURL.absoluteString
                            let existingUserData = self.realm.objects(User.self).first
                            try! self.realm.write{
                                existingUserData?.userIconImageURL = self.photoURL
                            }
                        }
                    }
                }
            }
        }
        
    }

}
