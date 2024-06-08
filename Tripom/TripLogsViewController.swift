//
//  TripLogsViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/28.
//

import UIKit
import RealmSwift

//Realm：データの取得だけ
//旅の記録を表示する画面
class TripLogsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let realm = try! Realm()
    var tripLogs: Results<TripLog>!
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        旅記録からの画面遷移(戻る)に備えてTabBarを表示しておく
        self.tabBarController?.tabBar.alpha = 1
        self.tabBarController?.tabBar.isHidden = false
        
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "TripLogsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TripLogsCollectionViewCell")
        tripLogs = realm.objects(TripLog.self)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero // 自動サイズ調整を無効にする
        }
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (self.view.frame.width - 30) / 2, height:(self.view.frame.width - 30 ) * 1.5 / 2 )
        layout.sectionInset = UIEdgeInsets(top: 20,left: 10,bottom: 0,right: 10)
        collectionView.collectionViewLayout = layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        cellの個数として旅記録の個数を返す
        print("tripLogs.count",tripLogs.count)
        return tripLogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        cellはクラスTripLogsCollectionViewCellにより定義する
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripLogsCollectionViewCell", for: indexPath) as! TripLogsCollectionViewCell
//        cellのデータとして、データモデルTripLogsのindexPath.row番目のデータを取得する
        let tripLog: TripLog = tripLogs[indexPath.row]
        print(tripLog.destinationRequirement)
        cell.layer.cornerRadius = 10
        cell.backgroundColor = UIColor.systemGray6
        print("tripLog.photoURL")
//        print(tripLog.photoURL)
        
//        取得したデータを元にcellを編集する
        cell.setupCell(tripDate: "2024/05/09", tripSpot: tripLog.destinationRequirement, imageName: tripLog.photoURLs.first ?? "")
        return cell
    }
    
    // セルがタップされたとき
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tappedcell")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TripLogViewController") as! TripLogViewController
        vc.index = indexPath.row
        vc.tripLogs = tripLogs 
        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)
    }


}
