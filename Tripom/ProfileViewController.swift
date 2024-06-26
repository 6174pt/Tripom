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
    let settingButton: UIButton = UIButton()
    let iconImageView = UIImageView()
    
    let realm = try! Realm()
    var rate: Float = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        プロフィール設定画面からの画面遷移に備えてTabBarを表示しておく
        self.tabBarController?.tabBar.isHidden = false
        
//        userのプロフィールを取得
        let userData = realm.objects(User.self)
        if let user = userData.first {
            tripLevelLabel.text = "Lv. \(user.tripLevel)"
            userNameLabel.text = user.userName
            userIDLabel.text = user.userID
            
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
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:  "戻る", style:  .plain, target: nil, action: nil)
        
//        まだID必要ないので隠しておく
        userIDLabel.isHidden = true
        
//        プロフィール表示ビュー
        profileView.frame=CGRect(x: 0, y: view.frame.size.height / 2 - view.frame.size.width / 2, width: view.frame.size.width, height: view.frame.size.width)
        profileView.backgroundColor = UIColor.white
        view.addSubview(profileView)
        
//        ユーザーアイコン
        let iconImageSize: CGFloat = view.frame.size.width * 1 / 3
        iconImageView.image = UIImage(named: "icon")
        iconImageView.frame = CGRect(x: view.frame.size.width / 2 - iconImageSize / 2, y: view.frame.size.width / 6, width: iconImageSize, height: iconImageSize)
        iconImageView.layer.cornerRadius = iconImageSize / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.contentMode = .scaleAspectFill
        profileView.addSubview(iconImageView)
        

        

        
//        旅レベル
        tripLevelLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.width / 2 + 15, width: iconImageSize + 50 , height: iconImageSize / 2)
        tripLevelLabel.textAlignment = NSTextAlignment.center
        tripLevelLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        profileView.addSubview(tripLevelLabel)
        
//        ユーザー名
        userNameLabel.frame = CGRect(x: view.frame.size.width / 2 - (iconImageSize + 50) / 2, y: view.frame.size.width * 2 / 3 + 15, width: iconImageSize + 50 , height: iconImageSize / 4)
        userNameLabel.textAlignment = NSTextAlignment.center
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        userNameLabel.adjustsFontSizeToFitWidth = true
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
        
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        //        ”設定”ボタン
//        settingButton.frame = CGRect(x: self.view.frame.size.width - 50, y: (navBarHeight ?? 50) + 20, width: 30, height: 30)
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingButton.tintColor = UIColor.lightGray
        settingButton.backgroundColor = UIColor.white
        settingButton.imageView?.contentMode = .scaleAspectFill
        settingButton.contentHorizontalAlignment = .fill
        settingButton.contentVerticalAlignment = .fill
        settingButton.addAction(UIAction(handler: { _ in
            self.tappedSettingButton()
        }), for: .touchUpInside)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        // Auto Layout 制約の追加
        NSLayoutConstraint.activate([
            settingButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: -20),
            settingButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            settingButton.widthAnchor.constraint(equalToConstant: 40),
            settingButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    func tappedShareProfileButton() {
        let image = profileView.image(withRate: rate, iconImage: UIImage(named: "icon")!, appName: "Tripom")
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func tappedSettingButton() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

extension UIView {
    func image(withRate rate: Float, iconImage: UIImage, appName: String) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
                return renderer.image { ctx in
                    // 既存の描画内容をキャプチャ
                    layer.render(in: ctx.cgContext)
                    // ここに円ゲージを描画
                    let iconImageSize: CGFloat = bounds.size.width * 1 / 3
                    let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.width / 3), radius: iconImageSize / 2 + 10, startAngle: -(.pi/2), endAngle: CGFloat(rate) * 2 * .pi - (.pi/2), clockwise: true)
                    
                    ctx.cgContext.setLineWidth(5)
                    ctx.cgContext.setStrokeColor(UIColor(red: 242 / 255, green: 223 / 255, blue: 154 / 255, alpha: 1.0).cgColor)
                    ctx.cgContext.setLineCap(.round)
                    ctx.cgContext.addPath(circlePath.cgPath)
                    ctx.cgContext.strokePath()
                    
                    // 画像の右下にアイコン画像を描画
                    let iconSize: CGFloat = 40
                    let iconX: CGFloat = bounds.size.width - iconSize - 10
                    let iconY: CGFloat = bounds.size.height - iconSize - 30
                    let iconRect = CGRect(x: iconX, y: iconY, width: iconSize, height: iconSize)
                    iconImage.draw(in: iconRect)
                    
                    // アイコン画像の下にアプリ名を描画
                    let textFont = UIFont.systemFont(ofSize: 12)
                    let textColor = UIColor.black
                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: textFont,
                        .foregroundColor: textColor
                    ]
                    let textSize = appName.size(withAttributes: attributes)
                    let textX = bounds.size.width - textSize.width - 10
                    let textY = iconY + iconSize + 5
                    let textRect = CGRect(x: textX, y: textY, width: textSize.width, height: textSize.height)
                    appName.draw(in: textRect, withAttributes: attributes)
                    
                }
    }
}
