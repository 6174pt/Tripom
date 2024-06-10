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
    let recordNowButton: UIButton = UIButton()
    let recordLaterButton: UIButton = UIButton()
    let iconImageView: UIImageView = UIImageView()
    
    var animationView = LottieAnimationView()
    
    //    "今の旅の旅条件"を入れておく変数
    var nowDestinationRequirement: String = ""
    var nowTransportationRequirement: String = ""
    var nowCostRequirement: Int = 0
    var nowCurfewRequirement: String = ""
    let realm = try! Realm()
    
    var beforeTripPoints: Int = 0
    var nowTripPoints: Int = 0
    var tripLevel: Int = 0
    var beforeRate: Float = 0
    var afterRate: Float = 0
    
    var shape = CAShapeLayer()
    var user: User? = nil // 保存するためのUserインスタンス
    var isLevelUp = false // レベルアップのフラグ
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userData = realm.objects(User.self)
        if let user = userData.first {
            beforeTripPoints = user.tripPoints
            print("加算前のポイント", beforeTripPoints)
            tripLevel = user.tripLevel
            print("加算前のレベル(データモデル内)", user.tripLevel)
            
            if let fileURL = URL(string: user.userIconImageURL) {
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
                        iconImageView.image = image
                    } else {
                        print("ファイルは存在しますが、UIImageに変換できません")
                        iconImageView.image = UIImage(named: "defaultImage")
                    }
                } else {
                    print("ファイルが存在しません")
                    iconImageView.image = UIImage(named: "defaultImage")
                }
            } else {
                print("無効なURLです")
                iconImageView.image = UIImage(named: "defaultImage")
            }
            
        } else {
            print("データモデルUserのデータがありません")
        }
        
        let NowTripData = realm.objects(NowTripRequirements.self)
        if let nowTripData = NowTripData.first {
            nowTripPoints = beforeTripPoints + nowTripData.allTripPoint
            print("加算後のポイント", nowTripPoints)
            //        あとで旅記録に追加するため'今の旅の旅条件(目的地)'を取得しておく
            nowDestinationRequirement = nowTripData.nowDestinationRequirement
            //        あとで旅記録に追加するため'今の旅の旅条件(交通手段)'を取得しておく
            nowTransportationRequirement = nowTripData.nowTransportationRequirement
            //        あとで旅記録に追加するため'今の旅の旅条件(費用)'を取得しておく
            nowCostRequirement = nowTripData.nowCostRequirement
            //        あとで旅記録に追加するため'今の旅の旅条件(帰宅時間)'を取得しておく
            nowCurfewRequirement = nowTripData.nowCurfewRequirement
        } else {
            print("データモデルUserのデータがありません")
        }
        
        if let user = userData.first {
            try! realm.write{
                user.tripPoints = nowTripPoints
                print("加算後のポイント(データモデル内)", user.tripPoints)
            }
        } else {
            print("データモデルUserのデータがありません")
        }
        
//        ナビゲーションバーの非表示
        self.navigationItem.hidesBackButton = true
        
//        プロフィール表示ビュー
        profileView.frame=CGRect(x: 0, y: -50, width: view.frame.size.width, height: view.frame.size.width)
        view.addSubview(profileView)
        
//        ユーザーアイコン
        let iconImageSize: CGFloat = view.frame.size.width * 1 / 3
        iconImageView.frame = CGRect(x: view.frame.size.width / 2 - iconImageSize / 2, y: view.frame.size.height / 2 - iconImageSize / 2, width: iconImageSize, height: iconImageSize)
        iconImageView.layer.cornerRadius = iconImageSize / 2
        iconImageView.layer.masksToBounds = true
        profileView.addSubview(iconImageView)
        
//        プロフィールメッセージ
        profileMessageLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.height / 2 + iconImageSize / 2, width: iconImageSize + 50 , height: iconImageSize * 2 / 3)
        profileMessageLabel.numberOfLines = 2
        profileMessageLabel.textAlignment = NSTextAlignment.center
        profileMessageLabel.text = "お疲れ様です！\n旅は楽しめましたか？"
        profileView.addSubview(profileMessageLabel)
        
//        円ゲージ
        let ciclePath=UIBezierPath(arcCenter: view.center, radius: iconImageSize / 2 + 15, startAngle: -(.pi/2), endAngle: (.pi/2) * 3, clockwise: true)
//        let shape = CAShapeLayer()
        shape.path = ciclePath.cgPath
        shape.lineWidth = 5
        shape.strokeColor = UIColor(red: 242 / 255, green: 223 / 255, blue: 154 / 255, alpha: 1.0).cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd=0
        shape.lineCap = .round
        profileView.layer.addSublayer(shape)
        
//        ボタンのサイズ
        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        let buttonMargin: CGFloat = self.view.frame.size.height * 0.05
        
//        ”旅を記録する”ボタン
        recordNowButton.backgroundColor = UIColor.black
        recordNowButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight * 2 - buttonMargin * 1.5, width: buttonWidth, height: buttonHeight)
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
        recordLaterButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight - buttonMargin, width: buttonWidth, height: buttonHeight)
        recordLaterButton.layer.cornerRadius = buttonHeight / 4
        recordLaterButton.setTitle("後で記録する", for: .normal)
        recordLaterButton.setTitleColor(UIColor.white, for: .normal)
        recordLaterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        recordLaterButton.addAction(UIAction(handler: { _ in
            self.tappedRecordLaterButton()
        }), for: .touchUpInside)
        view.addSubview(recordLaterButton)
        
        pointUp()
        
//        画面遷移後の流れ
//        ”お疲れ様です！\n旅は楽しめましたか？”
//        "旅ポイント + \(addedTripPoint)pt"ふわっと表示させたい
//        もし旅レベルが上がったらアニメーション付きで"Lv. ~"みたいな
        
    }
    
    func pointUp(){
        print("PointUp")
        if nowTripPoints >= ((tripLevel - 1) * 5 + 15) {
            //            レベルアップする場合
            print("Level Up")
            beforeRate = Float(beforeTripPoints) / Float((tripLevel - 1) * 5 + 15)
            shape.speed = 1.0
            let animation1=CABasicAnimation(keyPath: "strokeEnd")
            animation1.fromValue = beforeRate
            animation1.toValue = 1.0
            animation1.duration = CFTimeInterval(6.0 * (1.0 - beforeRate))
            animation1.isRemovedOnCompletion = false
            animation1.fillMode = .forwards
            animation1.delegate = self
            shape.add(animation1,forKey: "animation1")
            
        } else {
            //            レベルアップしない場合
            print("Not Level Up")
            
            beforeRate = Float(beforeTripPoints) / Float((tripLevel - 1) * 5 + 15)
            afterRate = Float(nowTripPoints) / Float((tripLevel - 1) * 5 + 15)
            
            shape.speed = 1.0
            let animation2=CABasicAnimation(keyPath: "strokeEnd")
            animation2.fromValue = beforeRate
            animation2.toValue = afterRate
            animation2.duration = CFTimeInterval(6.0 * (afterRate - beforeRate))
            animation2.isRemovedOnCompletion=false
            animation2.fillMode = .forwards
            shape.add(animation2,forKey: "animation2")
            
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationdidstop")
        if anim == shape.animation(forKey: "animation1") {
            print("animation1didstop")
            //        レベルアップ後のレベルの表示
            profileMessageLabel.text = "Lv. \(tripLevel + 1)"
            profileMessageLabel.textAlignment = NSTextAlignment.center
            profileMessageLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
            
            //        アニメーション
            animationView = LottieAnimationView(name: "Animation - 1717424783266")
            //        ボタンのサイズ
            let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
            let buttonHeight: CGFloat = buttonWidth * 1 / 5
            animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - buttonHeight * 2 - 150 / 2)
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .playOnce
            animationView.play()
            view.addSubview(animationView)
            
            nowTripPoints = nowTripPoints - ((tripLevel - 1) * 5 + 15)
            tripLevel = tripLevel + 1
            beforeTripPoints = 0
            
            let userData = realm.objects(User.self)
            if let user = userData.first {
                try! realm.write{
                    user.tripPoints = user.tripPoints - ((user.tripLevel - 1) * 5 + 15)
                    print("加算後のポイント(データモデル内)", user.tripPoints)
                    user.tripLevel = user.tripLevel + 1
                    print("加算後のレベル(データモデル内)", user.tripLevel)
                }
            } else {
                print("データモデルUserのデータがありません")
            }
            
            //        再帰
            pointUp()
        }
        
    }
    
    func tappedRecordNowButton(){
//        旅記録編集画面に遷移
        print("tappedRecordNowButton")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecordTripLogViewController") as! RecordTripLogViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tappedRecordLaterButton() {
        //        '旅を始める'画面に遷移
        print("tappedRecordLaterButton")
        
        print("add")
        let existingTripLogsData = realm.objects(TripLog.self)
        try! realm.write {
            //            旅記録のデータモデルに"今の旅の旅条件"を代入
            let tripLog = TripLog()
            tripLog.destinationRequirement = nowDestinationRequirement
            tripLog.transportationRequirement = nowTransportationRequirement
            tripLog.costRequirement = nowCostRequirement
            tripLog.curfewRequirement = nowCurfewRequirement
            //            旅のコメント
            //            tripLog.tripComment = commentTextField.text!
            //            写真のURL
            //            tripLog.photoURL = photoURL
            realm.add(tripLog)
            
            let nowAddTripLogs = realm.objects(TripLog.self)
            if let nowAddTripLog = nowAddTripLogs.last {
                print("追加したやつ")
                print(nowAddTripLog.destinationRequirement)
                print(nowAddTripLog.transportationRequirement)
                print(nowAddTripLog.costRequirement)
                print(nowAddTripLog.curfewRequirement)
                print(nowAddTripLog.tripComment)
                print(nowAddTripLog.photoURLs)
            } else {
                
            }
            
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 1
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print("No TabBarController found")
            }
        }
    }

}


