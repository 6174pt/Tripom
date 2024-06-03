//
//  FinishTripViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/22.
//

import UIKit
import RealmSwift
import Lottie

class FinishTripViewController: UIViewController {

    let profileView: UIView = UIView()
    let profileMessageLabel: UILabel = UILabel()
    let confettiView: UIView = UIView()
    var confettiLayer = CAEmitterLayer()
    let recordNowButton: UIButton = UIButton()
    let recordLaterButton: UIButton = UIButton()
    
    var animationView = LottieAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()

//        ナビゲーションバーの非表示
        self.navigationItem.hidesBackButton = true
        
//        紙吹雪ビュー
//        confettiView.frame=CGRect(x: 0, y: -50, width: view.frame.size.width, height: view.frame.size.width)
//        confettiView.frame = view.bounds
//        confettiView.isUserInteractionEnabled = false
//        view.addSubview(confettiView)
                
//        プロフィール表示ビュー
        profileView.frame=CGRect(x: 0, y: -50, width: view.frame.size.width, height: view.frame.size.width)
        view.addSubview(profileView)
        
//        ユーザーアイコン
        let iconImageSize: CGFloat = view.frame.size.width * 1 / 3
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "icon")
        iconImageView.frame = CGRect(x: view.frame.size.width / 2 - iconImageSize / 2, y: view.frame.size.height / 2 - iconImageSize / 2, width: iconImageSize, height: iconImageSize)
        iconImageView.layer.cornerRadius = iconImageSize / 2
        iconImageView.layer.masksToBounds = true
        profileView.addSubview(iconImageView)
        
//        円ゲージ
        let ciclePath=UIBezierPath(arcCenter: view.center, radius: iconImageSize / 2 + 15, startAngle: -(.pi/2), endAngle: .pi/2*3, clockwise: true)
        let shape=CAShapeLayer()
        shape.path=ciclePath.cgPath
        shape.lineWidth=8
        shape.strokeColor = UIColor(red: 242 / 255, green: 223 / 255, blue: 154 / 255, alpha: 1.0).cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd=0
        shape.lineCap = .round
        profileView.layer.addSublayer(shape)
        
//        円ゲージアニメーション
        shape.speed = 1.0
        let animation=CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.5
        animation.toValue = 0.8
        animation.duration = 3.0
        animation.isRemovedOnCompletion=false
        animation.fillMode = .forwards
        shape.add(animation,forKey: "animation")
        
//        プロフィールメッセージ
        profileMessageLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.height / 2 + iconImageSize / 2, width: iconImageSize + 50 , height: iconImageSize)
        profileMessageLabel.numberOfLines = 2
        profileMessageLabel.textAlignment = NSTextAlignment.center
        profileMessageLabel.text = "お疲れ様です！\n旅は楽しめましたか？"
        profileView.addSubview(profileMessageLabel)
        
        //アニメーション
        animationView = LottieAnimationView(name: "Animation - 1717424783266")
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
//        ボタンのサイズ
        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        
//        ”旅を記録する”ボタン
        recordNowButton.backgroundColor = UIColor.black
        recordNowButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight * 2 - 150 / 2, width: buttonWidth, height: buttonHeight)
        recordNowButton.layer.cornerRadius = buttonHeight / 4
        recordNowButton.setTitle("旅を記録する", for: .normal)
        recordNowButton.setTitleColor(UIColor.white, for: .normal)
        recordNowButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        recordNowButton.addAction(UIAction(handler: { _ in
            self.tappedRecordNowButton()
        }), for: .touchUpInside)
        view.addSubview(recordNowButton)
        
//        ”後で記録する”ボタン
        recordLaterButton.backgroundColor = UIColor.gray
        recordLaterButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight - 50, width: buttonWidth, height: buttonHeight)
        recordLaterButton.layer.cornerRadius = buttonHeight / 4
        recordLaterButton.setTitle("後で記録する", for: .normal)
        recordLaterButton.setTitleColor(UIColor.white, for: .normal)
        recordLaterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        recordLaterButton.addAction(UIAction(handler: { _ in
            self.tappedRecordLaterButton()
        }), for: .touchUpInside)
        view.addSubview(recordLaterButton)
        
//        画面遷移後の流れ
//        ”お疲れ様です！\n旅は楽しめましたか？”
//        "旅ポイント + \(addedTripPoint)pt"ふわっと表示させたい
//        もし旅レベルが上がったらアニメーション付きで"Lv. ~"みたいな
        
    }
    
    func tappedRecordNowButton(){
//        旅記録編集画面に遷移
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecordTripLogViewController") as! RecordTripLogViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tappedRecordLaterButton() {
//        '旅を始める'画面に遷移
        if let tabBarController = self.tabBarController {
            // 選択するタブのインデックスを設定
            tabBarController.selectedIndex = 1
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            print("No TabBarController found")
        }
    }

}
