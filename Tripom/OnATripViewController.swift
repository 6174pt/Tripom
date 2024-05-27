//
//  OnATripViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/22.
//

import UIKit

class OnATripViewController: UIViewController {
    
    @IBOutlet var finishButton: UIButton!
    @IBOutlet var retireButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    @IBAction func tappedfinishButton(){
        let alert: UIAlertController = UIAlertController(title: "旅を完了しますか？", message: "旅を完了すると元の画面に戻れません。", preferredStyle: .alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "完了", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FinishTripViewController") as! FinishTripViewController
            self.navigationController?.pushViewController(vc, animated: true)
            print("bbb")
        })
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tappedRetireButton() {
        
        
    }


}
