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
    let userNameTextField: UITextField = UITextField()
    let userIDLabel: UILabel = UILabel()
    let userNameTitleLabel: UILabel = UILabel()
    let iconImageView: UIImageView = UIImageView()
    let iconImageButton: UIButton = UIButton()
    
    let realm = try! Realm()
    var photoURL: String = ""
    var selectedPhotoURL: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        userのプロフィールを取得
        let userData = realm.objects(User.self)
        if let user = userData.first {
            tripLevelLabel.text = "Lv. \(user.tripLevel)"
            userNameLabel.text = user.userName
            userNameTextField.text = user.userName
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
        
//        まだID必要ないので隠しておく
        userIDLabel.isHidden = true
        
        self.tabBarController?.tabBar.isHidden = true
        
        let saveButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveButtonTapped))
                navigationItem.rightBarButtonItem = saveButton

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
        
        if let overlayImage = createOverlayImage() {
            let overlayImageView = UIImageView(image: overlayImage)
            overlayImageView.frame = iconImageButton.bounds
            overlayImageView.contentMode = .scaleAspectFit
            iconImageButton.addSubview(overlayImageView)
                }
        
//        "ユーザー名"タイトルラベル
        userNameTitleLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.width * 2 / 3 - iconImageSize / 4, width: iconImageSize + 50 , height: iconImageSize / 4)
        userNameTitleLabel.textAlignment = NSTextAlignment.center
        userNameTitleLabel.text = "ユーザー名"
        profileView.addSubview(userNameTitleLabel)
        
        userNameTextField.frame = CGRect(x: 10, y: view.frame.size.width * 2 / 3, width: view.frame.size.width - 20 , height: iconImageSize / 4)
        userNameTextField.textAlignment = NSTextAlignment.center
        userNameTextField.font = UIFont.boldSystemFont(ofSize: 25.0)
        profileView.addSubview(userNameTextField)
        
        //        ユーザーID
        userIDLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.width * 3 / 4, width: iconImageSize + 50 , height: iconImageSize / 4)
        userIDLabel.textAlignment = NSTextAlignment.center
        //        userIDLabel.text = "\(userID)"
        userIDLabel.textColor = UIColor.gray
        profileView.addSubview(userIDLabel)
    }
    
    @objc func saveButtonTapped() {
        print("Save button tapped")
        guard let newUsername = userNameTextField.text else { return }
        do {
                let existingUserData = realm.objects(User.self).first
                guard let userData = existingUserData else {
                    print("No user data found")
                    return
                }
                
                try realm.write {
                    // ユーザーネームを更新
                    userData.userName = newUsername
                    
                    // 画像URLが存在する場合、iconURLを更新
                    if let imageURL = selectedPhotoURL {
                        userData.userIconImageURL = imageURL
                    }
                }
            
            showAlert(title: "完了", message: "プロフィールが変更されました")
            
            } catch {
                print("Error updating username or iconURL in Realm: \(error)")
            }
    }
    
    func showAlert(title: String, message: String) {
        print("aleart")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
                            self.selectedPhotoURL = self.photoURL
//                            let existingUserData = self.realm.objects(User.self).first
//                            try! self.realm.write{
//                                existingUserData?.userIconImageURL = self.photoURL
//                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func createOverlayImage() -> UIImage? {
        let size = CGSize(width: 100, height: 100)
        
        // 開始する画像のコンテキストを作成
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // 透明度50%の灰色の背景を描画
        context.setFillColor(UIColor.white.withAlphaComponent(0.5).cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        
        // SF Symbolsの"photo"アイコンを描画
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        if let symbolImage = UIImage(systemName: "photo", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal) {
            let symbolPoint = CGPoint(x: (size.width - symbolImage.size.width) / 2, y: (size.height - symbolImage.size.height) / 2)
            symbolImage.draw(at: symbolPoint)
        }
        
        // 描画した画像を取得
        let overlayImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return overlayImage
    }

}
