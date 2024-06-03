//
//  OnATripViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/22.
//

import UIKit
import RealmSwift

class OnATripViewController: UIViewController {
    
    @IBOutlet var finishButton: UIButton!
    @IBOutlet var retireButton: UIButton!
    @IBOutlet var destinationRequirementLabel: UILabel!
    @IBOutlet var transportationRequirementLabel: UILabel!
    @IBOutlet var costRequirementLabel: UILabel!
    @IBOutlet var curfewRequirementLabel: UILabel!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        '今の旅の旅条件'をラベルに出力
        let nowTripRequirements = realm.objects(NowTripRequirements.self)
        if let nowTripRequirement = nowTripRequirements.first {
            destinationRequirementLabel.text = nowTripRequirement.nowDestinationRequirement
            transportationRequirementLabel.text = nowTripRequirement.nowTransportationRequirement
            costRequirementLabel.text = String(nowTripRequirement.nowCostRequirement)
            curfewRequirementLabel.text = nowTripRequirement.nowCurfewRequirement
        } else {
            
        }
        
        self.navigationItem.hidesBackButton = true

        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        
        finishButton.backgroundColor = UIColor.black
        finishButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight * 2 - 150 / 2, width: buttonWidth, height: buttonHeight)
        finishButton.layer.cornerRadius = buttonHeight / 4
        finishButton.setTitle("旅を完了する", for: .normal)
        finishButton.setTitleColor(UIColor.white, for: .normal)
        finishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 100)
        
        retireButton.backgroundColor = UIColor.gray
        retireButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight - 50, width: buttonWidth, height: buttonHeight)
        retireButton.layer.cornerRadius = buttonHeight / 4
        retireButton.setTitle("リタイアする", for: .normal)
        retireButton.setTitleColor(UIColor.white, for: .normal)
        retireButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 100)
    }

    @IBAction func tappedFinishButton(){
        let alert: UIAlertController = UIAlertController(title: "旅を完了しますか？", message: "旅を完了すると元の画面に戻れません。", preferredStyle: .alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "完了", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FinishTripViewController") as! FinishTripViewController
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tappedRetireButton() {
        
        
    }


}
