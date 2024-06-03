//
//  TripLogViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/06/03.
//

import UIKit
import RealmSwift

class TripLogViewController: UIViewController {
    
    @IBOutlet var destinationRequirementLabel: UILabel!
    @IBOutlet var transportationRequirementLabel: UILabel!
    @IBOutlet var costRequirementLabel: UILabel!
    @IBOutlet var curfewRequirementLabel: UILabel!
    @IBOutlet var tripCommentLabel: UILabel!
    @IBOutlet var tripPhoto: UIImageView!
    
    var index: Int = 0
    let realm = try! Realm()
    var tripLogs: Results<TripLog>!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        let tripLog: TripLog = tripLogs[index]
        destinationRequirementLabel.text = tripLog.destinationRequirement
        transportationRequirementLabel.text = tripLog.transportationRequirement
        costRequirementLabel.text = String(tripLog.costRequirement)
        curfewRequirementLabel.text = tripLog.curfewRequirement
        tripCommentLabel.text = tripLog.tripComment
        
        if let fileURL = URL(string: tripLog.photoURL) {
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
                    tripPhoto.image = image
                } else {
                    print("ファイルは存在しますが、UIImageに変換できません")
                    tripPhoto.image = UIImage(named: "defaultImage")
                }
            } else {
                print("ファイルが存在しません")
                tripPhoto.image = UIImage(named: "defaultImage")
            }
        } else {
            print("無効なURLです")
            tripPhoto.image = UIImage(named: "defaultImage")
        }

        // Do any additional setup after loading the view.
    }

}
