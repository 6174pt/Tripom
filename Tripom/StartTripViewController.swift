//
//  StartTripViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/19.
//

import UIKit

class StartTripViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var rouletteView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startButtonSize: CGFloat = self.view.frame.size.width * 2 / 3
        startButton.backgroundColor = UIColor(red: 1, green: 217 / 255, blue: 0, alpha: 1)
        startButton.frame = CGRect(x: (self.view.frame.size.width / 2) - startButtonSize / 2, y: (self.view.frame.size.height / 2) - startButtonSize / 2, width: startButtonSize, height: startButtonSize)
        startButton.layer.cornerRadius = startButtonSize / 2
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 100)
        
        rouletteView.backgroundColor = UIColor.white
        rouletteView.frame = CGRect(x: (self.view.frame.size.width / 2) - startButtonSize / 2, y: (self.view.frame.size.height / 2) - startButtonSize / 2, width: startButtonSize, height: startButtonSize)
        rouletteView.layer.cornerRadius = startButtonSize / 2
        rouletteView.isHidden = true

    }
    
    @IBAction func tappedStartButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tabBarController?.tabBar.isHidden = true
            self.rouletteView.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RouletteViewController") as! RouletteViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        UIView.animate(withDuration: 1.0, // アニメーションの時間を2秒に設定
                       delay: 0,
                       options: [.curveEaseInOut], // Ease-In Ease-Outアニメーション
                       animations: {
            let tappedStartButtonSize: CGFloat = self.view.frame.size.height + 50
            self.startButton.frame = CGRect(x: (self.view.frame.size.width / 2) - tappedStartButtonSize / 2, y: (self.view.frame.size.height / 2) - tappedStartButtonSize / 2, width: tappedStartButtonSize, height: tappedStartButtonSize)
            self.startButton.layer.cornerRadius = tappedStartButtonSize / 2
            self.startButton.setTitle("", for: .normal)
            self.startButton.layoutIfNeeded() // レイアウトの更新
        }, completion: nil)
        
        
        
        
    }
    
}
