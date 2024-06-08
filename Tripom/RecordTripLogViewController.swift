//
//  RecordTripLogViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/28.
//

import UIKit
import RealmSwift
import PhotosUI

//Realm：データの取得(NowTripRequirements,),データの追加(TripLog,TripPhotos)
//旅の記録を編集する画面
class RecordTripLogViewController: UIViewController, PHPickerViewControllerDelegate, UICollectionViewDataSource {
    
    @IBOutlet var destinationRequirementLabel: UILabel!
    @IBOutlet var transportationRequirementLabel: UILabel!
    @IBOutlet var costRequirementLabel: UILabel!
    @IBOutlet var curfewRequirementLabel: UILabel!
    @IBOutlet var commentTextField: UITextField!
    
    var tripLogs: Results<TripLog>!
    var photoArray: [UIImage] = []
    var photoURLArray: List<String> = List<String>()
    
    let saveTripLogButton: UIButton = UIButton()
    var photoURL: String = ""
    
    //    "今の旅の旅条件"を入れておく変数
    var nowDestinationRequirement: String = ""
    var nowTransportationRequirement: String = ""
    var nowCostRequirement: Int = 0
    var nowCurfewRequirement: String = ""
    
    let realm = try! Realm()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        //        '今の旅の旅条件'をラベルに出力
        let nowTripRequirements = realm.objects(NowTripRequirements.self)
        if let nowTripRequirement = nowTripRequirements.first {
            //        '今の旅の旅条件(目的地)'をラベルに出力
            destinationRequirementLabel.text = nowTripRequirement.nowDestinationRequirement
            //        あとで旅記録に追加するため'今の旅の旅条件(目的地)'を取得しておく
            nowDestinationRequirement = nowTripRequirement.nowDestinationRequirement
            
            //        '今の旅の旅条件(交通手段)'をラベルに出力
            transportationRequirementLabel.text = nowTripRequirement.nowTransportationRequirement
            //        あとで旅記録に追加するため'今の旅の旅条件(交通手段)'を取得しておく
            nowTransportationRequirement = nowTripRequirement.nowTransportationRequirement
            
            //        '今の旅の旅条件(費用)'をラベルに出力
            costRequirementLabel.text = String(nowTripRequirement.nowCostRequirement)
            //        あとで旅記録に追加するため'今の旅の旅条件(費用)'を取得しておく
            nowCostRequirement = nowTripRequirement.nowCostRequirement
            
            //        '今の旅の旅条件(帰宅時間)'をラベルに出力
            curfewRequirementLabel.text = nowTripRequirement.nowCurfewRequirement
            //        あとで旅記録に追加するため'今の旅の旅条件(帰宅時間)'を取得しておく
            nowCurfewRequirement = nowTripRequirement.nowCurfewRequirement
        } else {
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        ナビゲーションバーの非表示
        self.navigationItem.hidesBackButton = true
        
        //                選択した写真を表示するCollectionView
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TripLogsPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TripLogsPhotosCollectionViewCell")
        collectionView.register(UINib(nibName: "AddPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPhotoCollectionViewCell")
        collectionView.backgroundColor = UIColor.gray
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero // 自動サイズ調整を無効にする
        }
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (self.view.frame.width - 30) / 3, height:(self.view.frame.width - 30 ) * 1.5 / 3 )
        layout.sectionInset = UIEdgeInsets(top: 20,left: 10,bottom: 0,right: 10)
        collectionView.collectionViewLayout = layout
        
        
        //                tripLogs = Array(realm.objects(TripLog.self))
                collectionView.reloadData()
        
        //        コメント用のTextFieldの最初に透けて見えるメッセージ
        commentTextField.placeholder = "旅で感じたことを記しておきましょう！"
        
        //        ボタンのサイズ
        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        
        //        ”旅記録を保存する”ボタン
        saveTripLogButton.backgroundColor = UIColor.black
        saveTripLogButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight - 50, width: buttonWidth, height: buttonHeight)
        saveTripLogButton.layer.cornerRadius = buttonHeight / 4
        saveTripLogButton.setTitle("旅記録を保存する", for: .normal)
        saveTripLogButton.setTitleColor(UIColor.white, for: .normal)
        saveTripLogButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        saveTripLogButton.addAction(UIAction(handler: { _ in self.tappedSaveButton()}), for: .touchUpInside)
        view.addSubview(saveTripLogButton)
        
    }
    
    //    旅記録を保存するAction
    func tappedSaveButton(){
        print("add")
        let existingTripLogsData = realm.objects(TripLog.self)
        try! realm.write {
            //            旅記録のデータモデルに"今の旅の旅条件"を代入
            let tripLog = TripLog()
            tripLog.destinationRequirement = nowDestinationRequirement
            tripLog.transportationRequirement = nowTransportationRequirement
            tripLog.costRequirement = nowCostRequirement
            tripLog.curfewRequirement = nowCurfewRequirement
            //            旅のコメント
            tripLog.tripComment = commentTextField.text!
            //            写真のURL
            tripLog.photoURLs = photoURLArray
            realm.add(tripLog)
            
//            let nowAddTripLogs = realm.objects(TripLog.self)
//            if let nowAddTripLog = nowAddTripLogs.last {
//                print("追加したやつ")
//                print(nowAddTripLog.destinationRequirement)
//                print(nowAddTripLog.transportationRequirement)
//                print(nowAddTripLog.costRequirement)
//                print(nowAddTripLog.curfewRequirement)
//                print(nowAddTripLog.tripComment)
//                print(nowAddTripLog.photoURLs)
//            } else {
//                
//            }
            
        }
        
        if let tabBarController = self.tabBarController {
            // 選択するタブのインデックスを設定
            tabBarController.selectedIndex = 1
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            print("No TabBarController found")
        }
        
    }
    
    //    旅記録内の写真をCollectionViewで表示
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return photoArray.count + 1  // プラス1は「写真を追加」ボタンのため
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCollectionViewCell", for: indexPath) as! AddPhotoCollectionViewCell
                cell.addPhotoButton.addTarget(self, action: #selector(tappedAddPhotoButton), for: .touchUpInside)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripLogsPhotosCollectionViewCell", for: indexPath) as! TripLogsPhotosCollectionViewCell
                cell.tripPhotosImageView.image = photoArray[indexPath.item - 1]
                return cell
            }
        }
    
    @objc func tappedAddPhotoButton() {
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
                        self.photoArray.append(image)
                        self.collectionView.reloadData()
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
                        photoURL = fileURL.absoluteString
                        self.photoURLArray.append(photoURL)
                    }
                }
            }
        }
        
    }
    
}
