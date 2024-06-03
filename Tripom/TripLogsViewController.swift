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
class TripLogsViewController: UIViewController, UICollectionViewDataSource{
    
    let realm = try! Realm()
    var tripLogs: Results<TripLog>!
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TripLogsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TripLogsCollectionViewCell")
        tripLogs = realm.objects(TripLog.self)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero // 自動サイズ調整を無効にする
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width:self.view.frame.width / 2 - 10, height:(self.view.frame.width / 2 - 10) * 1.5)
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
        print(tripLog.photoURL)
        
//        取得したデータを元にcellを編集する
        cell.setupCell(tripDate: "2024/05/09", tripSpot: tripLog.destinationRequirement, imageName: tripLog.photoURL)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            // 例: セルの幅を画面の幅の90%、高さを200に設定
//            let width = collectionView.bounds.width
//            let height: CGFloat = 200
//            return CGSize(width: width, height: height)
//        }


}
