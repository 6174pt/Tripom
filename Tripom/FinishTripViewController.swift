//
//  FinishTripViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/22.
//

import UIKit
import RealmSwift
//import QuartzCore

class FinishTripViewController: UIViewController {
    
//    public enum ConfettiType {
//            case confetti
//            case triangle
//            case star
//            case diamond
//            case image(UIImage)
//        }

    let profileView: UIView = UIView()
    let profileMessageLabel: UILabel = UILabel()
    let confettiView: UIView = UIView()
    var confettiLayer = CAEmitterLayer()
    let recordNowButton: UIButton = UIButton()
    let recordLaterButton: UIButton = UIButton()
    let actionButton: UIButton = UIButton()
        
//    var colors: [UIColor]!
//    var type: ConfettiType!
//    var confettiType: ConfettiType = .confetti

    override func viewDidLoad() {
        super.viewDidLoad()

//        ナビゲーションバーの非表示
        self.navigationItem.hidesBackButton = true
        
//        紙吹雪ビュー
        confettiView.frame=CGRect(x: 0, y: -50, width: view.frame.size.width, height: view.frame.size.width)
        confettiView.frame = view.bounds
        confettiView.isUserInteractionEnabled = false
        view.addSubview(confettiView)
        
//        colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
//                      UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
//                      UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
//                      UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
//                      UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
//        type = .confetti
        
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
        
        actionButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - buttonHeight * 2 - 150 / 2)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        view.addSubview(actionButton)
        
        setupConfettiLayer()
        
//        画面遷移後の流れ
//        ”お疲れ様です！\n旅は楽しめましたか？”
//        "旅ポイント + \(addedTripPoint)pt"ふわっと表示させたい
//        もし旅レベルが上がったらアニメーション付きで"Lv. ~"みたいな
        
//        紙吹雪のアニメーションを止める
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.stopConfetti()
        }
        
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

    
    @objc func actionButtonTapped(){
//        profileMessageLabel.text = "旅ポイント + \(addedTripPoint)pt"
//        もし旅レベルが上がったら旅レベルが上がったことを明示、confettiをさらに表示する
    }
    
    func stopConfetti() {
            confettiLayer.birthRate = 0
    }
    
//    多分png画像の色を変える？
//    func imageForType(type: ConfettiType) -> UIImage? {
//
//        var fileName: String!
//
//        switch type {
//        case .confetti:
//            fileName = "confetti"
//        case .triangle:
//            fileName = "triangle"
//        case .star:
//            fileName = "star"
//        case .diamond:
//            fileName = "diamond"
//        case let .image(customImage):
//            return customImage
//        }
//
//        if let image = UIImage(named: fileName) {
//            return image
//        } else {
//            return nil
//        }
//
//    }
    
//    public func startConfetti() {
//        
//        confettiLayer = CAEmitterLayer()
//        confettiLayer.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: view.bounds.height / 2.0 - 50)
//        confettiLayer.emitterSize = CGSize(width: 10, height: 10)
//        confettiLayer.emitterShape = .line
//        confettiLayer.emitterMode = .outline
//        confettiLayer.renderMode = .additive
//        
//        var cells = [CAEmitterCell]()
//        for color in colors {
//            cells.append(setupConfettiLayer(color: color))
//        }
//        
//        confettiLayer.emitterCells = cells
//        confettiView.layer.addSublayer(confettiLayer)
//    }
    
//    confettiLayerのセットアップ
    func setupConfettiLayer() {
        confettiLayer = CAEmitterLayer()
        confettiLayer.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: view.bounds.height / 2.0 - 50)
        confettiLayer.emitterSize = CGSize(width: 10, height: 10)
        confettiLayer.emitterShape = .line
        confettiLayer.emitterMode = .outline
        confettiLayer.renderMode = .additive
        
        let confettiCell1 = CAEmitterCell()
        
        confettiCell1.contents = generateConfettiImage1()?.cgImage
        confettiCell1.birthRate = 20
        confettiCell1.lifetime = 2.0
        confettiCell1.lifetimeRange = 3.0
        confettiCell1.velocity = 400
        confettiCell1.velocityRange = 0
        confettiCell1.emissionLongitude = 0
        confettiCell1.emissionRange = .pi / 2
        confettiCell1.spin = 4
        confettiCell1.spinRange = 8
        confettiCell1.scale = 0.05
        confettiCell1.scaleRange = 0.1
        confettiCell1.yAcceleration = 350
        
        let confettiCell2 = CAEmitterCell()
        confettiCell2.contents = generateConfettiImage2()?.cgImage
        confettiCell2.birthRate = 20
        confettiCell2.lifetime = 2.0
        confettiCell2.lifetimeRange = 3.0
        confettiCell2.velocity = 400
        confettiCell2.velocityRange = 0
        confettiCell2.emissionLongitude = 0
        confettiCell2.emissionRange = .pi / 2
        confettiCell2.spin = 4
        confettiCell2.spinRange = 8
        confettiCell2.scale = 0.05
        confettiCell2.scaleRange = 0.1
        confettiCell2.yAcceleration = 350
        
        confettiLayer.emitterCells = [confettiCell1, confettiCell2]
        confettiView.layer.addSublayer(confettiLayer)
        
//        return confettiCell1
    }
    
    func generateConfettiImage1() -> UIImage? {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(UIColor.red.cgColor)
        context?.fillEllipse(in: CGRect(origin: .zero, size: size))
        
        let image1 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image1
    }
    
    func generateConfettiImage2() -> UIImage? {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(UIColor.green.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        
        let image2 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image2
    }
    
}
