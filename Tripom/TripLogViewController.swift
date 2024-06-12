//
//  TripLogViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/06/03.
//

import UIKit
import RealmSwift
import PhotosUI

class TripLogViewController: UIViewController, UICollectionViewDataSource, PHPickerViewControllerDelegate {
    
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
    var tripPhotoCollectionView: UICollectionView!
    
    var index: Int = 0
    let realm = try! Realm()
    var tripLogs: Results<TripLog>!
    var tripLog: TripLog!
    var photoURLArray: List<String> = List<String>()
    var photoURL: String = ""
    
    let editButton = UIButton(type: .system)
    var isEditingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButton.setTitle("編集", for: .normal)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        
        self.tabBarController?.tabBar.isHidden = true
        
        
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
        tripPhotoCollectionView.register(UINib(nibName: "TripLogPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TripLogPhotosCollectionViewCell")
        tripPhotoCollectionView.register(UINib(nibName: "AddPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPhotoCollectionViewCell")
        tripPhotoView.addSubview(tripPhotoCollectionView)
        
        // stackViewの制約
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        tripCommentTextView.isEditable = false
        
        //        Indexは遷移前の画面から渡される値
        tripLogs = realm.objects(TripLog.self)
        if index < tripLogs.count {
            tripLog = tripLogs[index]
            destinationRequirementLabel.text = tripLog.destinationRequirement
            transportationRequirementLabel.text = tripLog.transportationRequirement
            costRequirementLabel.text = "¥" + String(tripLog.costRequirement) + "-"
            curfewRequirementLabel.text = tripLog.curfewRequirement
            tripCommentTextView.text = tripLog.tripComment
            photoURLArray = tripLog.photoURLs
        }
        
        print("viewdidload")
        tripPhotoCollectionView.reloadData()
        
    }
    
    @objc func editButtonTapped() {
        isEditingMode.toggle()
        
        if isEditingMode {
            editButton.setTitle("保存", for: .normal)
            enableEditingMode()
            tripPhotoCollectionView.reloadData()
        } else {
            editButton.setTitle("編集", for: .normal)
            saveChanges()
            disableEditingMode()
            tripPhotoCollectionView.reloadData()
        }
    }
    
    func enableEditingMode() {
        // テキストフィールドやテキストビューを編集可能にする
        tripCommentTextView.isEditable = true
        // 他の編集用UI要素も同様に設定
    }
    
    func disableEditingMode() {
        tripCommentTextView.isEditable = false
        // 他の編集用UI要素も同様に設定
    }
    
    func saveChanges() {
        //             編集内容を保存する処理を実装
        try! realm.write {
            tripLog.tripComment = tripCommentTextView.text
            tripLog.photoURLs = photoURLArray
            // 他のフィールドも同様に保存
        }
        showAlert(title: "完了", message: "変更が保存されました")
    }
    
    func showAlert(title: String, message: String) {
        print("aleart")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //    旅記録内の写真をCollectionViewで表示
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let extraCell = isEditingMode ? 1 : 0
        return (photoURLArray.count) + extraCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isEditingMode && indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCollectionViewCell", for: indexPath) as! AddPhotoCollectionViewCell
            cell.addPhotoButton.addTarget(self, action: #selector(tappedAddPhotoButton), for: .touchUpInside)
            cell.layer.cornerRadius = 10
            return cell
        } else {
            let index = isEditingMode ? indexPath.item - 1 : indexPath.item
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripLogPhotosCollectionViewCell", for: indexPath) as! TripLogPhotosCollectionViewCell
            cell.layer.cornerRadius = 10
            
            if let photoURLString = photoURLArray[index] as String?,
               let fileURL = URL(string: photoURLString) {
                let filePath = fileURL.path
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: filePath) {
                    if let data = try? Data(contentsOf: fileURL),
                       let image = UIImage(data: data) {
                        cell.tripPhotosImageView.image = image
                    } else {
                        cell.tripPhotosImageView.image = UIImage(named: "defaultImage")
                    }
                } else {
                    cell.tripPhotosImageView.image = UIImage(named: "defaultImage")
                }
            } else {
                cell.tripPhotosImageView.image = UIImage(named: "defaultImage")
            }
            
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
                            
                            DispatchQueue.main.async {
                                if let realm = try? Realm(), let tripLog = self.tripLog {
                                    try? realm.write {
                                        self.photoURLArray.append(self.photoURL)
                                    }
                                }
                                self.tripPhotoCollectionView.reloadData()
                            }
                            
                        } catch {
                            print("Error writing file: \(error)")
                        }
                        print("fileURL", fileURL)
//                        photoURL = fileURL.absoluteString
////                        self.photoURLArray.append(photoURL)
//                        DispatchQueue.main.async {
//                            print("dispatch")
//                            self.photoURLArray.append(self.photoURL)
//                            print("dispatch2")
//                            self.tripPhotoCollectionView.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
    
    

