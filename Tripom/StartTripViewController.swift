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
    let numberOfSections = 8
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        旅の完了画面からの画面遷移に備えてTabBarを表示しておく
        self.tabBarController?.tabBar.alpha = 1
        self.tabBarController?.tabBar.isHidden = false
        
        //        スタートボタン
        startButton.configuration = nil
        let startButtonSize: CGFloat = self.view.frame.size.width * 2 / 3
        startButton.backgroundColor = UIColor(red: 236 / 255, green: 207 / 255, blue: 101 / 255, alpha: 1)
        startButton.frame = CGRect(x: (self.view.frame.size.width / 2) - startButtonSize / 2, y: (self.view.frame.size.height / 2) - startButtonSize / 2, width: startButtonSize, height: startButtonSize)
        startButton.layer.cornerRadius = startButtonSize / 2
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        
        //        roulletView(ルーレットを表示するView)
        rouletteView.backgroundColor = UIColor.white
        rouletteView.frame = CGRect(x: (self.view.frame.size.width / 2) - startButtonSize / 2, y: (self.view.frame.size.height / 2) - startButtonSize / 2, width: startButtonSize, height: startButtonSize)
        rouletteView.layer.cornerRadius = startButtonSize / 2
        setupOuterCircle()
        setupRoulette()
        setupCenterCircle()
        rouletteView.isHidden = true
    }
    
//    rouletteViewのセットアップ
    func setupRoulette() {
        
        let angleStep = 2 * CGFloat.pi / CGFloat(numberOfSections)
        let innerRadius: CGFloat = rouletteView.bounds.width / 2 * 0.8 // セクションビューのサイズ調整
        
        for index in 0..<numberOfSections {
            let sectionView = UIView()
            sectionView.translatesAutoresizingMaskIntoConstraints = false
            // セクションごとに色を設定
            sectionView.backgroundColor = index % 2 == 0 ? UIColor(red: 242 / 255, green: 223 / 255, blue: 154 / 255, alpha: 1.0) : .white
            
            rouletteView.addSubview(sectionView)
            
            // セクションビューの位置とサイズの設定
            NSLayoutConstraint.activate([
                sectionView.widthAnchor.constraint(equalTo: rouletteView.widthAnchor),
                sectionView.heightAnchor.constraint(equalTo: rouletteView.heightAnchor),
                sectionView.centerXAnchor.constraint(equalTo: rouletteView.centerXAnchor),
                sectionView.centerYAnchor.constraint(equalTo: rouletteView.centerYAnchor)
            ])
            
            // 扇形のマスクを設定
            let startAngle = angleStep * CGFloat(index)
            let endAngle = startAngle + angleStep
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rouletteView.bounds.width / 2, y: rouletteView.bounds.height / 2))
            path.addArc(withCenter: CGPoint(x: rouletteView.bounds.width / 2, y: rouletteView.bounds.height / 2),
                        radius: innerRadius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: true)
            path.close()
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            sectionView.layer.mask = mask
        }
    }
    
    func setupCenterCircle() {
        let centerCircleSize: CGFloat = rouletteView.bounds.width * 0.2
        let centerCircle = UIView()
        centerCircle.translatesAutoresizingMaskIntoConstraints = false
        centerCircle.backgroundColor = UIColor(red: 236 / 255, green: 207 / 255, blue: 101 / 255, alpha: 1)
        centerCircle.layer.cornerRadius = centerCircleSize / 2
        
        rouletteView.addSubview(centerCircle)
        
        NSLayoutConstraint.activate([
            centerCircle.widthAnchor.constraint(equalToConstant: centerCircleSize),
            centerCircle.heightAnchor.constraint(equalToConstant: centerCircleSize),
            centerCircle.centerXAnchor.constraint(equalTo: rouletteView.centerXAnchor),
            centerCircle.centerYAnchor.constraint(equalTo: rouletteView.centerYAnchor)
        ])
    }
    
    func setupOuterCircle() {
        let centerCircleSize: CGFloat = rouletteView.bounds.width * 0.85
        let centerCircle = UIView()
        centerCircle.translatesAutoresizingMaskIntoConstraints = false
        centerCircle.backgroundColor = UIColor(red: 236 / 255, green: 207 / 255, blue: 101 / 255, alpha: 1)
        centerCircle.layer.cornerRadius = centerCircleSize / 2
        
        rouletteView.addSubview(centerCircle)
        
        NSLayoutConstraint.activate([
            centerCircle.widthAnchor.constraint(equalToConstant: centerCircleSize),
            centerCircle.heightAnchor.constraint(equalToConstant: centerCircleSize),
            centerCircle.centerXAnchor.constraint(equalTo: rouletteView.centerXAnchor),
            centerCircle.centerYAnchor.constraint(equalTo: rouletteView.centerYAnchor)
        ])
    }
    
    @IBAction func tappedStartButton() {
        
        //        スタートボタンが押されたらタブバーを消してrouletteViewを表示する
        UIView.animate(withDuration: 1, animations: {
            self.tabBarController?.tabBar.alpha = 0
            self.rouletteView.alpha = 1
        }, completion:  { _ in
            self.tabBarController?.tabBar.isHidden = true
            self.rouletteView.isHidden = false
        })
        
        //        スタートボタンが押されたらスタートボタンが拡大して背景になる
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
            let tappedStartButtonSize: CGFloat = self.view.frame.size.height + 100
            self.startButton.frame = CGRect(x: (self.view.frame.size.width / 2) - tappedStartButtonSize / 2, y: (self.view.frame.size.height / 2) - tappedStartButtonSize / 2, width: tappedStartButtonSize, height: tappedStartButtonSize)
            self.startButton.layer.cornerRadius = tappedStartButtonSize / 2
            self.startButton.setTitle("", for: .normal)
            self.startButton.layoutIfNeeded()
        }, completion: { (_) in
            self.rotateRoulette()
        })
        
        
        
        
    }
    
    func rotateRoulette() {
        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveLinear], animations: {
            // ルーレットを1回転させる
            self.rouletteView.transform = self.rouletteView.transform.rotated(by: CGFloat.pi)
        }, completion: { (_) in
            // アニメーションが終了したら次の画面に遷移する
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TripRequirementsViewController") as! TripRequirementsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
}
