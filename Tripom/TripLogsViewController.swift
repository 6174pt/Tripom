//
//  TripLogsViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/28.
//

import UIKit
import RealmSwift

class TripLogsViewController: UIViewController, UICollectionViewDataSource {
    
    let realm = try! Realm()
    var tripLogs: [TripLog] = []
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TripLogsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TripLogsCollectionViewCell")
        tripLogs = readTripLogs()
    }
    
    func readTripLogs() -> [TripLog]{
        return Array(realm.objects(TripLog.self))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tripLogs.count
//        return 旅記録の個数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripLogsCollectionViewCell", for: indexPath) as! TripLogsCollectionViewCell
        let tripLog: TripLog = tripLogs[indexPath.row]
        cell.setupCell(tripDate: "", tripSpot: "", imageName: "")
        return cell
    }

}
