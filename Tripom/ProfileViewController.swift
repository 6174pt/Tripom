//
//  ProfileViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/28.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    
    let profileView: UIView = UIView()
    let tripLevelLabel: UILabel = UILabel()
    let userNameLabel: UILabel = UILabel()
    let userIDLabel: UILabel = UILabel()
    let shareProfileButton: UIButton = UIButton()
    
    let realm = try! Realm()
    var rate: Float = 0
    
    override func viewWillAppear(_ animated: Bool) {
//        userのプロフィールを取得
        let userData = realm.objects(User.self)
        if let user = userData.first {
            tripLevelLabel.text = "Lv. \(user.tripLevel)"
            userNameLabel.text = user.userName
            userIDLabel.text = user.userID
            
//            現在の旅ポイントが今の旅レベルのMaxポイントを上回っていたら
            if user.tripPoints >= ((user.tripLevel - 1) * 5 + 15) {
                try! realm.write{
                    user.tripPoints = user.tripPoints - ((user.tripLevel - 1) * 5 + 15)
                    user.tripLevel = user.tripLevel + 1
                }
            }
            
//            円ゲージの割合
            rate = Float(user.tripPoints) / Float((user.tripLevel - 1) * 5 + 15)
        } else {
            
        }
        
        let iconImageSize: CGFloat = view.frame.size.width * 1 / 3
        let iconImageView = UIImageView()
        
//        円ゲージ
        let ciclePath=UIBezierPath(arcCenter: CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 3), radius: iconImageSize / 2 + 10, startAngle: -(.pi/2), endAngle: CGFloat(rate) * 2 * .pi - (.pi/2), clockwise: true)
        let shape = CAShapeLayer()
        shape.path=ciclePath.cgPath
        shape.lineWidth=5
        shape.strokeColor = UIColor(red: 242 / 255, green: 223 / 255, blue: 154 / 255, alpha: 1.0).cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd=0
        shape.lineCap = .round
        profileView.layer.addSublayer(shape)
        
//        円ゲージアニメーション
        shape.speed = 1.0
        let animation=CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1.0
        animation.toValue = 1.0
        animation.duration = 3.0
        animation.isRemovedOnCompletion=false
        animation.fillMode = .forwards
        shape.add(animation,forKey: "animation")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        プロフィール表示ビュー
        profileView.frame=CGRect(x: 0, y: view.frame.size.height / 2 - view.frame.size.width / 2, width: view.frame.size.width, height: view.frame.size.width)
        profileView.backgroundColor = UIColor.white
        view.addSubview(profileView)
        
//        ユーザーアイコン
        let iconImageSize: CGFloat = view.frame.size.width * 1 / 3
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "icon")
        iconImageView.frame = CGRect(x: view.frame.size.width / 2 - iconImageSize / 2, y: view.frame.size.width / 6, width: iconImageSize, height: iconImageSize)
        iconImageView.layer.cornerRadius = iconImageSize / 2
        iconImageView.layer.masksToBounds = true
        profileView.addSubview(iconImageView)
        

        

        
//        旅レベル
        tripLevelLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.width / 2, width: iconImageSize + 50 , height: iconImageSize / 2)
        tripLevelLabel.textAlignment = NSTextAlignment.center
//        tripLevelLabel.text = "Lv. \(nowTripLevel)"
        tripLevelLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        profileView.addSubview(tripLevelLabel)
        
//        ユーザー名
        userNameLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.width * 2 / 3, width: iconImageSize + 50 , height: iconImageSize / 4)
        userNameLabel.textAlignment = NSTextAlignment.center
//        userNameLabel.text = "\(userName)"
        profileView.addSubview(userNameLabel)
        
//        ユーザーID
        userIDLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.width * 3 / 4, width: iconImageSize + 50 , height: iconImageSize / 4)
        userIDLabel.textAlignment = NSTextAlignment.center
//        userIDLabel.text = "\(userID)"
        userIDLabel.textColor = UIColor.gray
        profileView.addSubview(userIDLabel)
        
//        ボタンのサイズ
        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        print(self.view.frame.size.width)
        print(self.view.frame.size.height)
        
//        ”共有”ボタン
        shareProfileButton.backgroundColor = UIColor.black
        shareProfileButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight * 2 - 150 / 2, width: buttonWidth, height: buttonHeight)
        shareProfileButton.layer.cornerRadius = buttonHeight / 4
        shareProfileButton.setTitle("共有", for: .normal)
        shareProfileButton.setTitleColor(UIColor.white, for: .normal)
        shareProfileButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        shareProfileButton.addAction(UIAction(handler: { _ in
            self.tappedShareProfileButton()
        }), for: .touchUpInside)
        view.addSubview(shareProfileButton)
        
    }
    
    func tappedShareProfileButton() {
        print("tappedShareProfileButton")
        let image = profileView.image(withRate: rate)
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }

}

extension UIView {
    func image(withRate rate: Float) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
                return renderer.image { ctx in
                    // 既存の描画内容をキャプチャ
                    layer.render(in: ctx.cgContext)
                    print(rate)
                    // ここに円ゲージを描画
                    let iconImageSize: CGFloat = bounds.size.width * 1 / 3
                    let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.width / 3), radius: iconImageSize / 2 + 10, startAngle: -(.pi/2), endAngle: CGFloat(rate) * 2 * .pi - (.pi/2), clockwise: true)
                    
                    ctx.cgContext.setLineWidth(5)
                    ctx.cgContext.setStrokeColor(UIColor(red: 242 / 255, green: 223 / 255, blue: 154 / 255, alpha: 1.0).cgColor)
                    ctx.cgContext.setLineCap(.round)
                    ctx.cgContext.addPath(circlePath.cgPath)
                    ctx.cgContext.strokePath()
                }
    }
}
