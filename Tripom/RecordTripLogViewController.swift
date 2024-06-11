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
class RecordTripLogViewController: UIViewController, PHPickerViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, CustomCollectionViewCellDelegate {
    
    
//    @IBOutlet var destinationRequirementLabel: UILabel!
//    @IBOutlet var transportationRequirementLabel: UILabel!
//    @IBOutlet var costRequirementLabel: UILabel!
//    @IBOutlet var curfewRequirementLabel: UILabel!
//    @IBOutlet var tripCommentTextView: UITextView!
    
    //    ScrollView
    let scrollView: UIScrollView = UIScrollView()
    let stackView: UIStackView = UIStackView()
    
    //    旅条件
    let requirementsView: UIView = UIView()
    //    旅条件-タイトルセクション
    let requirementsTitleView: UIView = UIView()
    let requirementsTitleLabel: UILabel = UILabel()
    //    旅条件-目的地セクション
    let destinationRequirementsView: UIView = UIView()
    let destinationImageView: UIImageView = UIImageView()
    let destinationLabel: UILabel = UILabel()
    var destinationRequirementLabel: UILabel = UILabel()
    //    旅条件-交通手段セクション
    let transportationRequirementsView: UIView = UIView()
    let transportationImageView: UIImageView = UIImageView()
    let transportationLabel: UILabel = UILabel()
    var transportationRequirementLabel: UILabel = UILabel()
    //    旅条件-費用セクション
    let costRequirementsView: UIView = UIView()
    let costImageView: UIImageView = UIImageView()
    let costLabel: UILabel = UILabel()
    var costRequirementLabel: UILabel = UILabel()
    //    旅条件-帰宅時間セクション
    let curfewRequirementsView: UIView = UIView()
    let curfewImageView: UIImageView = UIImageView()
    let curfewLabel: UILabel = UILabel()
    var curfewRequirementLabel: UILabel = UILabel()
    
    //    コメント
    let commentView: UIView = UIView()
    //    コメント-タイトルセクション
    let tripCommentTitleView: UIView = UIView()
    let tripCommentTitleLabel: UILabel = UILabel()
    //    コメント-コメント本文セクション
    let tripCommentView: UIView = UIView()
    let tripCommentTextView: UITextView = UITextView()
    
    //    写真
    let photosView: UIView = UIView()
    //    写真-タイトルセクション
    let tripPhotoTitleView: UIView = UIView()
    let tripPhotoTitleLabel: UILabel = UILabel()
    //    写真-写真
    let tripPhotoView: UIView = UIView()
    
    //    ボタン
    let saveButtonView: UIView = UIView()
    
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
    
    var tripPhotoCollectionView: UICollectionView!
    
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
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
//        scrollViewの設置
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width:screenWidth, height:screenHeight)
        view.addSubview(scrollView)
//        stackViewの設置
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        let requirementsViewHeight = screenHeight / 3
        let photosViewHeight = screenHeight / 2
        let sectionWidthRation = 1.0 / 2.0
        let sectionHeightRation = 1.0 / 6.0
        let commentSectionWidth = view.frame.size.width - 40
        let photosSectionWidth = view.frame.size.width
        let sectionWidth = view.frame.size.width * sectionWidthRation
        let sectionHeight = requirementsViewHeight * sectionHeightRation
        let sectionLeftRightMargin = (view.frame.size.width * (1.0 - sectionWidthRation)) / 2 + 20
        let sectionTopBottomMargin = sectionHeight / 6
        
        //    旅条件Viewの設置
        requirementsView.heightAnchor.constraint(equalToConstant: screenHeight / 3).isActive = true
        stackView.addArrangedSubview(requirementsView)
        
        //        旅条件View下線
        let requirementsViewBottomBorder = CALayer()
        requirementsViewBottomBorder.frame = CGRect(x: 5, y: requirementsViewHeight, width: view.frame.size.width - 10, height:1.0)
        requirementsViewBottomBorder.backgroundColor = UIColor.systemGray4.cgColor
        requirementsView.layer.addSublayer(requirementsViewBottomBorder)
        
        //        旅条件-タイトルセクション
        requirementsTitleView.frame=CGRect(x: 10, y: sectionTopBottomMargin, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(requirementsTitleView)
        
        //        旅条件-タイトルセクション-タイトル
        requirementsTitleLabel.frame=CGRect(x: 0, y: 0, width: sectionWidth, height: sectionHeight)
        requirementsTitleLabel.text = "旅条件"
        requirementsTitleLabel.textAlignment = .left
        requirementsTitleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        requirementsTitleLabel.adjustsFontSizeToFitWidth = true
        requirementsTitleView.addSubview(requirementsTitleLabel)
        
        //        旅条件-目的地セクション
        destinationRequirementsView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 2 + sectionHeight, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(destinationRequirementsView)
        
        //        旅条件-目的地セクション-アイコン
        destinationImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        destinationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        destinationImageView.tintColor = UIColor.black
        destinationRequirementsView.addSubview(destinationImageView)
        
//        旅条件-目的地セクション-目的地
        destinationLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        destinationLabel.text = "目的地"
        destinationLabel.textColor = UIColor.systemGray2
        destinationLabel.textAlignment = .center
        destinationLabel.adjustsFontSizeToFitWidth = true
        destinationRequirementsView.addSubview(destinationLabel)
        
//        旅条件-目的地セクション-目的地条件
        destinationRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        destinationRequirementLabel.adjustsFontSizeToFitWidth = true
        destinationRequirementLabel.font = UIFont.systemFont(ofSize: 18.0)
        destinationRequirementLabel.textAlignment = .left
        destinationRequirementsView.addSubview(destinationRequirementLabel)
        
//        旅条件-交通手段セクション
        transportationRequirementsView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 3 + sectionHeight * 2, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(transportationRequirementsView)
        
//        旅条件-交通手段セクション-アイコン
        transportationImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        transportationImageView.image = UIImage(systemName: "tram")
        transportationImageView.tintColor = UIColor.black
        transportationRequirementsView.addSubview(transportationImageView)
        
//        旅条件-交通手段セクション-交通手段
        transportationLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        transportationLabel.text = "交通手段"
        transportationLabel.textColor = UIColor.systemGray2
        transportationLabel.textAlignment = .center
        transportationLabel.adjustsFontSizeToFitWidth = true
        transportationRequirementsView.addSubview(transportationLabel)
        
//        旅条件-交通手段セクション-交通手段条件
        transportationRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        transportationRequirementLabel.adjustsFontSizeToFitWidth = true
        transportationRequirementLabel.font = UIFont.systemFont(ofSize: 18.0)
        transportationRequirementLabel.textAlignment = .left
        transportationRequirementsView.addSubview(transportationRequirementLabel)
        
//        旅条件-費用セクション
        costRequirementsView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 4 + sectionHeight * 3, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(costRequirementsView)
        
//        旅条件-費用セクション-アイコン
        costImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        costImageView.image = UIImage(systemName: "yensign")
        costImageView.tintColor = UIColor.black
        costRequirementsView.addSubview(costImageView)
        
//        旅条件-費用セクション-費用
        costLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        costLabel.text = "費用"
        costLabel.textColor = UIColor.systemGray2
        costLabel.textAlignment = .center
        costLabel.adjustsFontSizeToFitWidth = true
        costRequirementsView.addSubview(costLabel)
        
//        旅条件-費用セクション-費用条件
        costRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        costRequirementLabel.adjustsFontSizeToFitWidth = true
        costRequirementLabel.font = UIFont.systemFont(ofSize: 18.0)
        costRequirementLabel.textAlignment = .left
        costRequirementsView.addSubview(costRequirementLabel)
        
//        旅条件-帰宅時間セクション
        curfewRequirementsView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 5 + sectionHeight * 4, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(curfewRequirementsView)
        
//        旅条件-帰宅時間セクション-アイコン
        curfewImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        curfewImageView.image = UIImage(systemName: "clock")
        curfewImageView.tintColor = UIColor.black
        curfewRequirementsView.addSubview(curfewImageView)
        
//        旅条件-帰宅時間セクション-帰宅時間
        curfewLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        curfewLabel.text = "帰宅時間"
        curfewLabel.textColor = UIColor.systemGray2
        curfewLabel.textAlignment = .center
        curfewLabel.adjustsFontSizeToFitWidth = true
        curfewRequirementsView.addSubview(curfewLabel)
        
//        旅条件-帰宅時間セクション-帰宅時間条件
        curfewRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        curfewRequirementLabel.adjustsFontSizeToFitWidth = true
        curfewRequirementLabel.font = UIFont.systemFont(ofSize: 18.0)
        curfewRequirementLabel.textAlignment = .left
        curfewRequirementsView.addSubview(curfewRequirementLabel)
        
        // コメントViewの設置
        commentView.heightAnchor.constraint(equalToConstant: screenHeight / 3).isActive = true
        stackView.addArrangedSubview(commentView)
        
//        コメントView下線
        let commentViewBottomBorder = CALayer()
        commentViewBottomBorder.frame = CGRect(x: 5, y: requirementsViewHeight, width: view.frame.size.width - 10, height:1.0)
        commentViewBottomBorder.backgroundColor = UIColor.systemGray4.cgColor
        commentView.layer.addSublayer(commentViewBottomBorder)
        
        //        コメント-タイトルセクション
        tripCommentTitleView.frame=CGRect(x: 10, y: sectionTopBottomMargin, width: sectionWidth, height: sectionHeight)
        commentView.addSubview(tripCommentTitleView)
        
        //        コメント-タイトルセクション-タイトル
        tripCommentTitleLabel.frame=CGRect(x: 0, y: 0, width: sectionWidth, height: sectionHeight)
        tripCommentTitleLabel.text = "コメント"
        tripCommentTitleLabel.textAlignment = .left
        tripCommentTitleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        tripCommentTitleLabel.adjustsFontSizeToFitWidth = true
        tripCommentTitleView.addSubview(tripCommentTitleLabel)
        
        //        コメント-コメントセクション
        tripCommentView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 2 + sectionHeight, width: commentSectionWidth, height: requirementsViewHeight - sectionHeight - sectionTopBottomMargin * 3)
        tripCommentView.backgroundColor = UIColor.systemGray
        commentView.addSubview(tripCommentView)
        
        //        コメント-コメントセクション-コメント
        tripCommentTextView.frame=CGRect(x: 0, y: 0, width: commentSectionWidth, height: requirementsViewHeight - sectionHeight - sectionTopBottomMargin * 3)
        tripCommentView.addSubview(tripCommentTextView)
        
        //        写真Viewの設置
        photosView.heightAnchor.constraint(equalToConstant: screenHeight / 2).isActive = true
        stackView.addArrangedSubview(photosView)
        
        //        写真-写真タイトルセクション
        tripPhotoTitleView.frame=CGRect(x: 10, y: sectionTopBottomMargin, width: sectionWidth, height: sectionHeight)
        photosView.addSubview(tripPhotoTitleView)
        
        //        写真-写真タイトルセクション-タイトル
        tripPhotoTitleLabel.frame=CGRect(x: 0, y: 0, width: sectionWidth, height: sectionHeight)
        tripPhotoTitleLabel.text = "写真"
        tripPhotoTitleLabel.textAlignment = .left
        tripPhotoTitleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        tripPhotoTitleLabel.adjustsFontSizeToFitWidth = true
        tripPhotoTitleView.addSubview(tripPhotoTitleLabel)
        
        //        写真-写真セクション
        tripPhotoView.frame=CGRect(x: 0, y: sectionTopBottomMargin * 2 + sectionHeight, width: photosSectionWidth, height: photosViewHeight - sectionHeight - sectionTopBottomMargin * 3)
        photosView.addSubview(tripPhotoView)
        
        //        写真-写真セクション-写真
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (self.view.frame.width - 30) / 2, height:(self.view.frame.width - 30 ) * 1.5 / 2 )
        layout.sectionInset = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10)
        tripPhotoCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: photosSectionWidth, height: photosViewHeight - sectionHeight - sectionTopBottomMargin * 3), collectionViewLayout: layout)
        tripPhotoCollectionView.dataSource = self
        tripPhotoCollectionView.register(UINib(nibName: "TripLogsPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TripLogsPhotosCollectionViewCell")
        tripPhotoCollectionView.register(UINib(nibName: "AddPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPhotoCollectionViewCell")
        tripPhotoView.addSubview(tripPhotoCollectionView)
        
        // コメントViewの設置
        //        ボタンのサイズ
        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        saveButtonView.heightAnchor.constraint(equalToConstant: buttonHeight + sectionTopBottomMargin).isActive = true
        stackView.addArrangedSubview(saveButtonView)
        
        //        ”旅記録を保存する”ボタン
        saveTripLogButton.backgroundColor = UIColor.black
        saveTripLogButton.frame = CGRect(x: self.view.frame.size.width / 2 - buttonWidth / 2, y: 0, width: buttonWidth, height: buttonHeight)
        saveTripLogButton.layer.cornerRadius = buttonHeight / 4
        saveTripLogButton.setTitle("旅記録を保存する", for: .normal)
        saveTripLogButton.setTitleColor(UIColor.white, for: .normal)
        saveTripLogButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        saveTripLogButton.addAction(UIAction(handler: { _ in self.tappedSaveButton()}), for: .touchUpInside)
        saveButtonView.addSubview(saveTripLogButton)

        tripPhotoCollectionView.reloadData()
        
        // stackViewの制約
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
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
            tripLog.tripComment = tripCommentTextView.text!
            //            写真のURL
            tripLog.photoURLs = photoURLArray
            realm.add(tripLog)
            
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
                cell.layer.cornerRadius = 10
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripLogsPhotosCollectionViewCell", for: indexPath) as! TripLogsPhotosCollectionViewCell
                cell.tripPhotosImageView.image = photoArray[indexPath.item - 1]
                cell.layer.cornerRadius = 10
                cell.delegate = self
                return cell
            }
        }
    
    func didTapDeleteButton(in cell: TripLogsPhotosCollectionViewCell) {
        print("didtapdelete")
        if let indexPath = tripPhotoCollectionView.indexPath(for: cell) {
            print("delete")
            print(photoArray.count)
            photoArray.remove(at: indexPath.item - 1)
            photoURLArray.remove(at: indexPath.item - 1)
            tripPhotoCollectionView.deleteItems(at: [indexPath])
            print(photoArray.count)
        }
    }
    
    @objc func tappedAddPhotoButton() {
        //            PHPickerの表示
        var configuration = PHPickerConfiguration()
        //            PHPickerで取得できるメディアの種類を画像に限定
        let filter = PHPickerFilter.images
        configuration.filter = filter
        //            PHPickerで取得できる画像の数を(とりあえず)一枚に限定
        configuration.selectionLimit = 0
        
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
                        self.tripPhotoCollectionView.reloadData()
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
