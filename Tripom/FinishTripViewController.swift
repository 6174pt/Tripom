//
//  FinishTripViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/22.
//

import UIKit
import RealmSwift
import Lottie

class FinishTripViewController: UIViewController, CAAnimationDelegate {

    let profileView: UIView = UIView()
    let profileMessageLabel: UILabel = UILabel()
    let confettiView: UIView = UIView()
    var confettiLayer = CAEmitterLayer()
    let recordNowButton: UIButton = UIButton()
    let recordLaterButton: UIButton = UIButton()
    
    var animationView = LottieAnimationView()
    let realm = try! Realm()
    var rate: Float = 0
    
    var beforeTripPoints: Int = 0
    var afterTripPoints: Int = 0
    var beforeTripLevel: Int = 0
    var beforeRate: Float = 0
    var afterRate: Float = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userData = realm.objects(User.self)
        if let user = userData.first {
            beforeTripPoints = user.tripPoints
            print("beforeTripPoints", beforeTripPoints)
            beforeTripLevel = user.tripLevel
        } else {
            
        }
        
        let NowTripData = realm.objects(NowTripRequirements.self)
        if let nowTripData = NowTripData.first {
            afterTripPoints = beforeTripPoints + nowTripData.allTripPoint
            print("afterTripPoints", afterTripPoints)
        } else {
            
        }
        
//        ナビゲーションバーの非表示
        self.navigationItem.hidesBackButton = true
        
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
        
//        プロフィールメッセージ
        profileMessageLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.height / 2 + iconImageSize / 2, width: iconImageSize + 50 , height: iconImageSize)
        profileMessageLabel.numberOfLines = 2
        profileMessageLabel.textAlignment = NSTextAlignment.center
        profileMessageLabel.text = "お疲れ様です！\n旅は楽しめましたか？"
        profileView.addSubview(profileMessageLabel)
        
//        円ゲージ
        let ciclePath=UIBezierPath(arcCenter: view.center, radius: iconImageSize / 2 + 15, startAngle: -(.pi/2), endAngle: (.pi/2) * 3, clockwise: true)
        let shape=CAShapeLayer()
        shape.path=ciclePath.cgPath
        shape.lineWidth=8
        shape.strokeColor = UIColor(red: 242 / 255, green: 223 / 255, blue: 154 / 255, alpha: 1.0).cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd=0
        shape.lineCap = .round
        profileView.layer.addSublayer(shape)
        
        if afterTripPoints >= ((beforeTripLevel - 1) * 5 + 15) {
            print("Level Up")
//            レベルアップする場合
            beforeRate = Float(beforeTripPoints) / Float((beforeTripLevel - 1) * 5 + 15)
            
            let userData = realm.objects(User.self)
            if let user = userData.first {
                try! realm.write{
                    user.tripPoints = afterTripPoints
                }
                
                
                
//                tripPointsがMaxのポイントを上回り続ける限りループ(円ゲージが一周回り切る間)
                while user.tripPoints >= ((user.tripLevel - 1) * 5 + 15) {
                    print("while")
                    //            円ゲージアニメーション
                    
                    shape.speed = 1.0
                    let animation1=CABasicAnimation(keyPath: "strokeEnd")
                    animation1.fromValue = beforeRate
                    animation1.toValue = 1.0
                    animation1.duration = 3.0
                    animation1.isRemovedOnCompletion = true
                    animation1.fillMode = .forwards
                    animation1.delegate = self
                    shape.add(animation1,forKey: "animation1")
                    
                    profileMessageLabel.text = "Lv. \(user.tripLevel + 1)"
                    
                    //        アニメーション
                    animationView = LottieAnimationView(name: "Animation - 1717424783266")
                    animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
                    animationView.contentMode = .scaleAspectFit
                    animationView.loopMode = .playOnce
                    animationView.play()
                    view.addSubview(animationView)
                    
                    try! realm.write{
                        user.tripPoints = user.tripPoints - ((user.tripLevel - 1) * 5 + 15)
                        user.tripLevel = user.tripLevel + 1
                    }
                    
                    beforeRate = 0
                    
                }
                
//                tripPointsがMaxのポイントを初めて下回った時(円ゲージが回り切り終わったあと)
                print("Not Level Up But After Level Up")
                afterRate = Float(user.tripPoints) / Float((user.tripLevel - 1) * 5 + 15)
                //            円ゲージアニメーション
                shape.speed = 1.0
                let animation2=CABasicAnimation(keyPath: "strokeEnd")
                animation2.fromValue = beforeRate
                animation2.toValue = afterRate
                animation2.duration = 3.0
                animation2.isRemovedOnCompletion=false
                animation2.fillMode = .forwards
                shape.add(animation2,forKey: "animation2")
                
                
            } else {
                print("データモデルUserのデータがありません")
            }
                        
                } else {
//            レベルアップしない場合
                    
                    print("Not Level Up")
            beforeRate = Float(beforeTripPoints) / Float((beforeTripLevel - 1) * 5 + 15)
            afterRate = Float(afterTripPoints) / Float((beforeTripLevel - 1) * 5 + 15)
            
            let userData = realm.objects(User.self)
            if let user = userData.first {
                try! realm.write{
                    user.tripPoints = afterTripPoints
                }
            } else {
                print("データモデルUserのデータがありません")
            }
//            円ゲージアニメーション
            shape.speed = 1.0
            let animation3=CABasicAnimation(keyPath: "strokeEnd")
            animation3.fromValue = beforeRate
            animation3.toValue = afterRate
            animation3.duration = 3.0
            animation3.isRemovedOnCompletion=false
            animation3.fillMode = .forwards
            shape.add(animation3,forKey: "animation3")
        }
        
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
            tabBarController.selectedIndex = 1
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            print("No TabBarController found")
        }
    }

}


