//
//  TripLogViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/06/03.
//

import UIKit
import RealmSwift

class TripLogViewController: UIViewController, UICollectionViewDataSource {
    
//    @IBOutlet var destinationRequirementLabel: UILabel!
//    @IBOutlet var transportationRequirementLabel: UILabel!
//    @IBOutlet var costRequirementLabel: UILabel!
//    @IBOutlet var curfewRequirementLabel: UILabel!
//    @IBOutlet var tripCommentTextView: UITextView!
    
    let scrollView: UIScrollView = UIScrollView()
    let stackView: UIStackView = UIStackView()
    let requirementsView: UIView = UIView()
    
    let requirementsCommentView: UIView = UIView()
    let requirementsCommentLabel: UILabel = UILabel()
    
    let destinationRequirementsView: UIView = UIView()
    let destinationImageView: UIImageView = UIImageView()
    let destinationLabel: UILabel = UILabel()
    var destinationRequirementLabel: UILabel = UILabel()
    
    let transportationRequirementsView: UIView = UIView()
    let transportationImageView: UIImageView = UIImageView()
    let transportationLabel: UILabel = UILabel()
    var transportationRequirementLabel: UILabel = UILabel()
    
    let costRequirementsView: UIView = UIView()
    let costImageView: UIImageView = UIImageView()
    let costLabel: UILabel = UILabel()
    var costRequirementLabel: UILabel = UILabel()
    
    let curfewRequirementsView: UIView = UIView()
    let curfewImageView: UIImageView = UIImageView()
    let curfewLabel: UILabel = UILabel()
    var curfewRequirementLabel: UILabel = UILabel()
    
    let commentView: UIView = UIView()
    
    let tripCommentTitleView: UIView = UIView()
    let tripCommentTitleLabel: UILabel = UILabel()
    
    let tripCommentView: UIView = UIView()
    let tripCommentTextView: UITextView = UITextView()
    
    let photosView: UIView = UIView()
    
    let tripPhotoTitleView: UIView = UIView()
    let tripPhotoTitleLabel: UILabel = UILabel()
    let tripPhotoView: UIView = UIView()
//    let tripPhotoCollectionView: UICollectionView = UICollectionView()
    
    var index: Int = 0
    let realm = try! Realm()
    var tripLogs: Results<TripLog>!
    var tripLog: TripLog!
    
//    @IBOutlet var tripPhotoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        self.tabBarController?.tabBar.isHidden = true
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width:screenWidth, height:screenHeight)
        view.addSubview(scrollView)
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        // requirementsView1の設定
//        requirementsView.backgroundColor = .red
        requirementsView.heightAnchor.constraint(equalToConstant: screenHeight / 3).isActive = true
        stackView.addArrangedSubview(requirementsView)
        
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
        
        let requirementsViewBottomBorder = CALayer()
        requirementsViewBottomBorder.frame = CGRect(x: 5, y: requirementsViewHeight, width: view.frame.size.width - 10, height:1.0)
        requirementsViewBottomBorder.backgroundColor = UIColor.systemGray4.cgColor
        requirementsView.layer.addSublayer(requirementsViewBottomBorder)
        
        //        コメントセクション
        requirementsCommentView.frame=CGRect(x: 10, y: sectionTopBottomMargin, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(requirementsCommentView)
        
        //        コメントセクション-コメント
        requirementsCommentLabel.frame=CGRect(x: 0, y: 0, width: sectionWidth, height: sectionHeight)
        requirementsCommentLabel.text = "旅条件"
        requirementsCommentLabel.textAlignment = .left
        requirementsCommentLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        requirementsCommentLabel.adjustsFontSizeToFitWidth = true
        requirementsCommentView.addSubview(requirementsCommentLabel)
        
//        目的地セクション
        destinationRequirementsView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 2 + sectionHeight, width: sectionWidth, height: sectionHeight)
//        destinationRequirementsView.backgroundColor = UIColor.systemGray
        requirementsView.addSubview(destinationRequirementsView)
        
//        目的地セクション-アイコン
        destinationImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        destinationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        destinationImageView.tintColor = UIColor.black
        destinationRequirementsView.addSubview(destinationImageView)
        
//        目的地セクション-目的地
        destinationLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        destinationLabel.text = "目的地"
        destinationLabel.textColor = UIColor.systemGray2
        destinationLabel.textAlignment = .center
        destinationLabel.adjustsFontSizeToFitWidth = true
        destinationRequirementsView.addSubview(destinationLabel)
        
//        目的地セクション-目的地条件
        destinationRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        destinationRequirementLabel.adjustsFontSizeToFitWidth = true
        destinationRequirementLabel.font = UIFont.systemFont(ofSize: 18.0)
        destinationRequirementLabel.textAlignment = .left
        destinationRequirementsView.addSubview(destinationRequirementLabel)
        
//        交通手段セクション
        transportationRequirementsView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 3 + sectionHeight * 2, width: sectionWidth, height: sectionHeight)
//        transportationRequirementsView.backgroundColor = UIColor.systemGray2
        requirementsView.addSubview(transportationRequirementsView)
        
//        交通手段セクション-アイコン
        transportationImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        transportationImageView.image = UIImage(systemName: "tram")
        transportationImageView.tintColor = UIColor.black
        transportationRequirementsView.addSubview(transportationImageView)
        
//        交通手段セクション-交通手段
        transportationLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        transportationLabel.text = "交通手段"
        transportationLabel.textColor = UIColor.systemGray2
        transportationLabel.textAlignment = .center
        transportationLabel.adjustsFontSizeToFitWidth = true
        transportationRequirementsView.addSubview(transportationLabel)
        
//        交通手段セクション-交通手段条件
        transportationRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        transportationRequirementLabel.adjustsFontSizeToFitWidth = true
        transportationRequirementLabel.font = UIFont.systemFont(ofSize: 18.0)
        transportationRequirementLabel.textAlignment = .left
        transportationRequirementsView.addSubview(transportationRequirementLabel)
        
//        費用セクション
        costRequirementsView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 4 + sectionHeight * 3, width: sectionWidth, height: sectionHeight)
//        costRequirementsView.backgroundColor = UIColor.systemGray3
        requirementsView.addSubview(costRequirementsView)
        
//        費用セクション-アイコン
        costImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        costImageView.image = UIImage(systemName: "yensign")
        costImageView.tintColor = UIColor.black
        costRequirementsView.addSubview(costImageView)
        
//        費用セクション-費用
        costLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        costLabel.text = "費用"
        costLabel.textColor = UIColor.systemGray2
        costLabel.textAlignment = .center
        costLabel.adjustsFontSizeToFitWidth = true
        costRequirementsView.addSubview(costLabel)
        
//        費用セクション-費用条件
        costRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        costRequirementLabel.adjustsFontSizeToFitWidth = true
        costRequirementLabel.font = UIFont.systemFont(ofSize: 18.0)
        costRequirementLabel.textAlignment = .left
        costRequirementsView.addSubview(costRequirementLabel)
        
//        帰宅時間セクション
        curfewRequirementsView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 5 + sectionHeight * 4, width: sectionWidth, height: sectionHeight)
//        curfewRequirementsView.backgroundColor = UIColor.systemGray4
        requirementsView.addSubview(curfewRequirementsView)
        
//        帰宅時間セクション-アイコン
        curfewImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        curfewImageView.image = UIImage(systemName: "clock")
        curfewImageView.tintColor = UIColor.black
        curfewRequirementsView.addSubview(curfewImageView)
        
//        帰宅時間セクション-帰宅時間
        curfewLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        curfewLabel.text = "帰宅時間"
        curfewLabel.textColor = UIColor.systemGray2
        curfewLabel.textAlignment = .center
        curfewLabel.adjustsFontSizeToFitWidth = true
        curfewRequirementsView.addSubview(curfewLabel)
        
//        帰宅時間セクション-帰宅時間条件
        curfewRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        curfewRequirementLabel.adjustsFontSizeToFitWidth = true
        curfewRequirementLabel.font = UIFont.systemFont(ofSize: 18.0)
        curfewRequirementLabel.textAlignment = .left
        curfewRequirementsView.addSubview(curfewRequirementLabel)
        
        // commentViewの設定
//        commentView.backgroundColor = .blue
        commentView.heightAnchor.constraint(equalToConstant: screenHeight / 3).isActive = true
        stackView.addArrangedSubview(commentView)
        
        let commentViewBottomBorder = CALayer()
        commentViewBottomBorder.frame = CGRect(x: 5, y: requirementsViewHeight, width: view.frame.size.width - 10, height:1.0)
        commentViewBottomBorder.backgroundColor = UIColor.systemGray4.cgColor
        commentView.layer.addSublayer(commentViewBottomBorder)
        
        //        コメント題名セクション
        tripCommentTitleView.frame=CGRect(x: 10, y: sectionTopBottomMargin, width: sectionWidth, height: sectionHeight)
//        tripCommentTitleView.backgroundColor = UIColor.gray
        commentView.addSubview(tripCommentTitleView)
        
        //        コメント題名セクション-コメント
        tripCommentTitleLabel.frame=CGRect(x: 0, y: 0, width: sectionWidth, height: sectionHeight)
        tripCommentTitleLabel.text = "コメント"
        tripCommentTitleLabel.textAlignment = .left
        tripCommentTitleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        tripCommentTitleLabel.adjustsFontSizeToFitWidth = true
        tripCommentTitleView.addSubview(tripCommentTitleLabel)
        
        //        コメント本文セクション
        tripCommentView.frame=CGRect(x: 20, y: sectionTopBottomMargin * 2 + sectionHeight, width: commentSectionWidth, height: requirementsViewHeight - sectionHeight - sectionTopBottomMargin * 3)
        tripCommentView.backgroundColor = UIColor.systemGray
        commentView.addSubview(tripCommentView)
        
        //        コメント本文セクション-コメント本文
        tripCommentTextView.frame=CGRect(x: 0, y: 0, width: commentSectionWidth, height: requirementsViewHeight - sectionHeight - sectionTopBottomMargin * 3)
        tripCommentView.addSubview(tripCommentTextView)
        
        // photosViewの設定
//        photosView.backgroundColor = .green
        photosView.heightAnchor.constraint(equalToConstant: screenHeight / 2).isActive = true
        stackView.addArrangedSubview(photosView)
        
        //        写真タイトルセクション
        tripPhotoTitleView.frame=CGRect(x: 10, y: sectionTopBottomMargin, width: sectionWidth, height: sectionHeight)
//        tripPhotoTitleView.backgroundColor = UIColor.gray
        photosView.addSubview(tripPhotoTitleView)
        
        //        写真タイトルセクション-写真タイトル
        tripPhotoTitleLabel.frame=CGRect(x: 0, y: 0, width: sectionWidth, height: sectionHeight)
        tripPhotoTitleLabel.text = "写真"
        tripPhotoTitleLabel.textAlignment = .left
        tripPhotoTitleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        tripPhotoTitleLabel.adjustsFontSizeToFitWidth = true
        tripPhotoTitleView.addSubview(tripPhotoTitleLabel)
        
        //        写真セクション
        tripPhotoView.frame=CGRect(x: 0, y: sectionTopBottomMargin * 2 + sectionHeight, width: photosSectionWidth, height: photosViewHeight - sectionHeight - sectionTopBottomMargin * 3)
//        tripPhotoView.backgroundColor = UIColor.systemGray
        photosView.addSubview(tripPhotoView)
        
        //        写真セクション-写真
        
//        if let layout = tripPhotoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.estimatedItemSize = .zero // 自動サイズ調整を無効にする
//        }
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (self.view.frame.width - 30) / 2, height:(self.view.frame.width - 30 ) * 1.5 / 2 )
        layout.sectionInset = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10)
//        tripPhotoCollectionView.collectionViewLayout = layout
        
        let tripPhotoCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: photosSectionWidth, height: photosViewHeight - sectionHeight - sectionTopBottomMargin * 3), collectionViewLayout: layout)
//        tripPhotoCollectionView.backgroundColor = UIColor.blue
        tripPhotoCollectionView.dataSource = self
        tripPhotoCollectionView.register(UINib(nibName: "TripLogPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TripLogPhotosCollectionViewCell")
//        tripPhotoCollectionView.frame=CGRect(x: 0, y: 0, width: commentSectionWidth, height: requirementsViewHeight - sectionHeight - sectionTopBottomMargin * 3)
        tripPhotoView.addSubview(tripPhotoCollectionView)
        
        
        
        // stackViewの制約を設定
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
        }
        
        tripPhotoCollectionView.reloadData()
        
    }
    
    //    旅記録内の写真をCollectionViewで表示
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("tripLog.photoURLs.count",tripLog.photoURLs.count)
        return tripLog?.photoURLs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripLogPhotosCollectionViewCell", for: indexPath) as! TripLogPhotosCollectionViewCell
        cell.layer.cornerRadius = 10
        
        //            cellの画像を設定
        if let photoURLString = tripLog.photoURLs[indexPath.item] as String?,
           let fileURL = URL(string: photoURLString) {
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
                    cell.tripPhotosImageView.image = image
                    print("set image")
                } else {
                    print("ファイルは存在しますが、UIImageに変換できません")
                    cell.tripPhotosImageView.image = UIImage(named: "defaultImage")
                }
            } else {
                print("ファイルが存在しません")
                cell.tripPhotosImageView.image = UIImage(named: "defaultImage")
            }
        } else {
            print("無効なURLです")
            cell.tripPhotosImageView.image = UIImage(named: "defaultImage")
        }
        
        return cell
    }
    
}
