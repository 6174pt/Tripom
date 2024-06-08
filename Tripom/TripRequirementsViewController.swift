//
//  TripRequirementsViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/19.
//

import UIKit
import RealmSwift

class TripRequirementsViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var destinationRequirementLabel: UILabel!
    @IBOutlet var transportationRequirementLabel: UILabel!
    @IBOutlet var costRequirementLabel: UILabel!
    @IBOutlet var curfewRequirementLabel: UILabel!
    
    var nowDestinationRequirement: String = ""
    var nowTransportationRequirement: String = ""
    var nowCostRequirement: Int = 0
    var nowCurfewRequirement: String = ""
    var nowDestinationRequirementTripPoint: Int = 5
    var nowTransportationRequirementTripPoint: Int = 5
    var nowCostRequirementTripPoint: Int = 5
    var nowCurfewRequirementTripPoint: Int = 5
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        randomizeTripRequirements()
        
        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        
        startButton.backgroundColor = UIColor.black
        startButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight * 2 - 150 / 2, width: buttonWidth, height: buttonHeight)
        startButton.layer.cornerRadius = buttonHeight / 4
        startButton.setTitle("この旅条件で旅を始める", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 100)
        
        resetButton.backgroundColor = UIColor.gray
        resetButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight * 2, width: buttonWidth, height: buttonHeight)
        resetButton.layer.cornerRadius = buttonHeight / 4
        resetButton.setTitle("旅条件をリセットする", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 100)

    }
    
    @objc func randomizeTripRequirements(){
//        isPresented = trueの旅条件だけフィルタリング
        let tripDestinationRequirement = realm.objects(DestinationRequirements.self).filter("isPresented = true")
        let tripTransportationRequirement = realm.objects(TransportationRequirements.self).filter("isPresented = true")
        let tripCostRequirement = realm.objects(CostRequirements.self).filter("isPresented = true")
        let tripCurfewRequirement = realm.objects(CurfewRequirements.self).filter("isPresented = true")
        
//        ランダムな旅条件を出力
//        目的地
        if let randomDestinationRequirements = tripDestinationRequirement.randomElement() {
//            print("destination: \(randomDestinationRequirements.destinationRequirement), tripPoint: \(randomDestinationRequirements.tripPoint)")
            destinationRequirementLabel.text = randomDestinationRequirements.destinationRequirement
            nowDestinationRequirement = randomDestinationRequirements.destinationRequirement
            nowDestinationRequirementTripPoint = randomDestinationRequirements.tripPoint
        } else {
            print("No persons found in the database.")
        }
        
//        交通手段
        if let randomTransportationRequirements = tripTransportationRequirement.randomElement() {
//            print("destination: \(randomTransportationRequirements.transportationRequirement), tripPoint: \(randomTransportationRequirements.tripPoint)")
            transportationRequirementLabel.text = randomTransportationRequirements.transportationRequirement
            nowTransportationRequirement = randomTransportationRequirements.transportationRequirement
            nowTransportationRequirementTripPoint = randomTransportationRequirements.tripPoint
        } else {
            print("No persons found in the database.")
        }
        
//        費用
        if let randomCostRequirements = tripCostRequirement.randomElement() {
//            print("destination: \(randomCostRequirements.costRequirement), tripPoint: \(randomCostRequirements.tripPoint)")
            costRequirementLabel.text = String(randomCostRequirements.costRequirement)
            nowCostRequirement = randomCostRequirements.costRequirement
            nowCostRequirementTripPoint = randomCostRequirements.tripPoint
        } else {
            print("No persons found in the database.")
        }
        
//        帰宅時間
        if let randomCurfewRequirements = tripCurfewRequirement.randomElement() {
//            print("destination: \(randomCurfewRequirements.curfewRequirement), tripPoint: \(randomCurfewRequirements.tripPoint)")
            curfewRequirementLabel.text = randomCurfewRequirements.curfewRequirement
            nowCurfewRequirement = randomCurfewRequirements.curfewRequirement
            nowCurfewRequirementTripPoint = randomCurfewRequirements.tripPoint
        } else {
            print("No persons found in the database.")
        }
    }
    
    @IBAction func tappedStartButton(){
//        '提案された旅条件'を'今の旅の旅条件'に代入する
        let existingNowTripRequirementsData = realm.objects(NowTripRequirements.self)
//        '今の旅の旅条件'が空の時はそのまま'提案された旅条件'を'今の旅の旅条件'に代入する
        if existingNowTripRequirementsData.isEmpty {
            try! realm.write {
                let nowTripRequirement = NowTripRequirements()
                nowTripRequirement.nowDestinationRequirement = nowDestinationRequirement
                nowTripRequirement.nowTransportationRequirement = nowTransportationRequirement
                nowTripRequirement.nowCostRequirement = nowCostRequirement
                nowTripRequirement.nowCurfewRequirement = nowCurfewRequirement
                //            リセット時の旅ポイント減算未実装(05/28時点)
                nowTripRequirement.allTripPoint = nowDestinationRequirementTripPoint + nowTransportationRequirementTripPoint + nowTransportationRequirementTripPoint + nowCurfewRequirementTripPoint
                realm.add(nowTripRequirement)
            }
            //        '今の旅の旅条件'が空ではない時は'今の旅の旅条件'を空にして'提案された旅条件'を'今の旅の旅条件'に代入する
        } else {
            try! realm.write {
                let objectToDelete = realm.objects(NowTripRequirements.self)
                realm.delete(objectToDelete)
                let nowTripRequirement = NowTripRequirements()
                nowTripRequirement.nowDestinationRequirement = nowDestinationRequirement
                nowTripRequirement.nowTransportationRequirement = nowTransportationRequirement
                nowTripRequirement.nowCostRequirement = nowCostRequirement
                nowTripRequirement.nowCurfewRequirement = nowCurfewRequirement
                //            リセット時の旅ポイント減算未実装(05/28時点)
                nowTripRequirement.allTripPoint = nowDestinationRequirementTripPoint + nowTransportationRequirementTripPoint + nowTransportationRequirementTripPoint + nowCurfewRequirementTripPoint
                realm.add(nowTripRequirement)
                    }
        }
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnATripViewController") as! OnATripViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    ’旅条件をリセットする’ボタンを押した時
    @IBAction func tappedResetButton() {
        let alert: UIAlertController = UIAlertController(title: "旅条件をリセットしますか？", message: "旅条件をリセットすると、旅完了後に加算される旅ポイントが減少します", preferredStyle: .alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "リセット", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            self.randomizeTripRequirements()
            
//            多分ここでスタート画面に戻る意味ない
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartTripViewController") as! StartTripViewController
//            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }

}
