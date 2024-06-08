//
//  TripLogViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/06/03.
//

import UIKit
import RealmSwift

class TripLogViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet var destinationRequirementLabel: UILabel!
    @IBOutlet var transportationRequirementLabel: UILabel!
    @IBOutlet var costRequirementLabel: UILabel!
    @IBOutlet var curfewRequirementLabel: UILabel!
    @IBOutlet var tripCommentTextView: UITextView!
    
    var index: Int = 0
    let realm = try! Realm()
    var tripLogs: Results<TripLog>!
    var tripLog: TripLog!
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        self.tabBarController?.tabBar.isHidden = true
        
        tripCommentTextView.isEditable = false
        
        //        Indexは遷移前の画面から渡される値
        tripLogs = realm.objects(TripLog.self)
        if index < tripLogs.count {
            tripLog = tripLogs[index]
            destinationRequirementLabel.text = tripLog.destinationRequirement
            transportationRequirementLabel.text = tripLog.transportationRequirement
            costRequirementLabel.text = String(tripLog.costRequirement)
            curfewRequirementLabel.text = tripLog.curfewRequirement
            tripCommentTextView.text = tripLog.tripComment
        }
        
//        collectionView.backgroundColor = UIColor.gray
//        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TripLogPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TripLogPhotosCollectionViewCell")
        
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
        
        // Do any additional setup after loading the view.
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
