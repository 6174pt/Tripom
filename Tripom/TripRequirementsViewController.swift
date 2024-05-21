//
//  TripRequirementsViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/19.
//

import UIKit

class TripRequirementsViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        
        startButton.backgroundColor = UIColor.black
        startButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight * 2 - 150 / 2, width: buttonWidth, height: buttonHeight)
        startButton.layer.cornerRadius = buttonHeight / 4
        startButton.setTitle("この旅条件で旅を始める", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 100)
        
        resetButton.backgroundColor = UIColor.gray
        resetButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight - 50, width: buttonWidth, height: buttonHeight)
        resetButton.layer.cornerRadius = buttonHeight / 4
        resetButton.setTitle("旅条件をリセットする", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 100)

    }
    
    @IBAction func tappedResetButton() {
        let alert: UIAlertController = UIAlertController(title: "旅条件をリセットしますか？", message: "旅条件をリセットすると、旅完了後に加算される旅ポイントが減少します", preferredStyle: .alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            print("キャンセル")
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "リセット", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            print("リセット")
        })
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }

}
