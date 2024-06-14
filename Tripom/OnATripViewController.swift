//
//  OnATripViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/22.
//

import UIKit
import RealmSwift
import Lottie

class OnATripViewController: UIViewController {
    
//    @IBOutlet var destinationRequirementLabel: UILabel!
//    @IBOutlet var transportationRequirementLabel: UILabel!
//    @IBOutlet var costRequirementLabel: UILabel!
//    @IBOutlet var curfewRequirementLabel: UILabel!
    
    let finishButton: UIButton = UIButton()
    let retireButton: UIButton = UIButton()
    
    var animationView = LottieAnimationView()
    
    let requirementsView: UIView = UIView()
    
    let destinationRequirementsView: UIView = UIView()
    let destinationImageView: UIImageView = UIImageView()
    let destinationLabel: UILabel = UILabel()
    var destinationRequirementLabel: UILabel = UILabel()
    
    let transportationRequirementsView: UIView = UIView()
    let transportationImageView: UIImageView = UIImageView()
    let transportationLabel: UILabel = UILabel()
    var transportationRequirementLabel: UILabel = UILabel()
    
    let costRequirementsView: UIView = UIView()
    let costImageView: UIImageView = UIImageView()
    let costLabel: UILabel = UILabel()
    var costRequirementLabel: UILabel = UILabel()
    
    let curfewRequirementsView: UIView = UIView()
    let curfewImageView: UIImageView = UIImageView()
    let curfewLabel: UILabel = UILabel()
    var curfewRequirementLabel: UILabel = UILabel()
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        let buttonMargin: CGFloat = self.view.frame.size.height * 0.05
        
        finishButton.backgroundColor = UIColor.black
        finishButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight * 2 - buttonMargin * 1.5, width: buttonWidth, height: buttonHeight)
        finishButton.layer.cornerRadius = buttonHeight / 4
        finishButton.setTitle("旅を完了する", for: .normal)
        finishButton.setTitleColor(UIColor.white, for: .normal)
        finishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        finishButton.addAction(UIAction(handler: { _ in
            self.tappedFinishButton()
        }), for: .touchUpInside)
        view.addSubview(finishButton)
        
        retireButton.backgroundColor = UIColor.gray
        retireButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight - buttonMargin, width: buttonWidth, height: buttonHeight)
        retireButton.layer.cornerRadius = buttonHeight / 4
        retireButton.setTitle("リタイアする", for: .normal)
        retireButton.setTitleColor(UIColor.white, for: .normal)
        retireButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        retireButton.addAction(UIAction(handler: { _ in
            self.tappedRetireButton()
        }), for: .touchUpInside)
        view.addSubview(retireButton)
        
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        //アニメーション
        let animationHeight = view.frame.size.height / 5
        animationView = LottieAnimationView(name: "Animation - 1717423675691")
        animationView.frame = CGRect(x: view.frame.size.width / 2 - animationHeight / 2, y: (navBarHeight ?? 50) + view.frame.size.height * 0.05, width: animationHeight, height: animationHeight)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
        //        旅条件表示ビュー
        let requirementsViewMargin = (buttonHeight * 2) + (buttonMargin * 1.5) + (navBarHeight ?? 50) + view.frame.size.height * 0.05 + animationHeight
        let requirementsViewHeight = view.frame.size.height - requirementsViewMargin
        requirementsView.frame=CGRect(x: 0, y: (navBarHeight ?? 50) + view.frame.size.height * 0.05 + animationHeight, width: view.frame.size.width, height: requirementsViewHeight)
        view.addSubview(requirementsView)
        
        let sectionWidthRation = 1.0 / 2.0
        let sectionHeightRation = 1.0 / 5.0
        let sectionWidth = view.frame.size.width * sectionWidthRation
        let sectionHeight = requirementsViewHeight * sectionHeightRation
        let sectionLeftRightMargin = (view.frame.size.width * (1.0 - sectionWidthRation)) / 2 + 20
        let sectionTopBottomMargin = view.frame.size.height / 50
        
        //        目的地セクション
        destinationRequirementsView.frame=CGRect(x: sectionLeftRightMargin, y: sectionTopBottomMargin, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(destinationRequirementsView)
        
        //        目的地セクション-アイコン
        destinationImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        destinationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        destinationImageView.tintColor = UIColor.black
        destinationRequirementsView.addSubview(destinationImageView)
        
        //        目的地セクション-目的地
        destinationLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        destinationLabel.text = "目的地"
        destinationLabel.textColor = UIColor.systemGray2
        destinationLabel.textAlignment = .center
        destinationLabel.adjustsFontSizeToFitWidth = true
        destinationRequirementsView.addSubview(destinationLabel)
        
        //        目的地セクション-目的地条件
        destinationRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        destinationRequirementLabel.adjustsFontSizeToFitWidth = true
        destinationRequirementLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        destinationRequirementLabel.textAlignment = .center
        destinationRequirementsView.addSubview(destinationRequirementLabel)
        
        //        交通手段セクション
        transportationRequirementsView.frame=CGRect(x: sectionLeftRightMargin, y: sectionTopBottomMargin * 2 + sectionHeight * 1, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(transportationRequirementsView)
        
        //        交通手段セクション-アイコン
        transportationImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        transportationImageView.image = UIImage(systemName: "tram")
        transportationImageView.tintColor = UIColor.black
        transportationRequirementsView.addSubview(transportationImageView)
        
        //        交通手段セクション-交通手段
        transportationLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        transportationLabel.text = "交通手段"
        transportationLabel.textColor = UIColor.systemGray2
        transportationLabel.textAlignment = .center
        transportationLabel.adjustsFontSizeToFitWidth = true
        transportationRequirementsView.addSubview(transportationLabel)
        
        //        交通手段セクション-交通手段条件
        transportationRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        transportationRequirementLabel.adjustsFontSizeToFitWidth = true
        transportationRequirementLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        transportationRequirementLabel.textAlignment = .center
        transportationRequirementsView.addSubview(transportationRequirementLabel)
        
        //        費用セクション
        costRequirementsView.frame=CGRect(x: sectionLeftRightMargin, y: sectionTopBottomMargin * 3 + sectionHeight * 2, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(costRequirementsView)
        
        //        費用セクション-アイコン
        costImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        costImageView.image = UIImage(systemName: "yensign")
        costImageView.tintColor = UIColor.black
        costRequirementsView.addSubview(costImageView)
        
        //        費用セクション-費用
        costLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        costLabel.text = "費用"
        costLabel.textColor = UIColor.systemGray2
        costLabel.textAlignment = .center
        costLabel.adjustsFontSizeToFitWidth = true
        costRequirementsView.addSubview(costLabel)
        
        //        費用セクション-費用条件
        costRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        costRequirementLabel.adjustsFontSizeToFitWidth = true
        costRequirementLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        costRequirementLabel.textAlignment = .center
        costRequirementsView.addSubview(costRequirementLabel)
        
        //        帰宅時間セクション
        curfewRequirementsView.frame=CGRect(x: sectionLeftRightMargin, y: sectionTopBottomMargin * 4 + sectionHeight * 3, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(curfewRequirementsView)
        
        //        帰宅時間セクション-アイコン
        curfewImageView.frame=CGRect(x: 0, y: 0, width: sectionHeight * 2 / 3, height: sectionHeight * 2 / 3)
        curfewImageView.image = UIImage(systemName: "clock")
        curfewImageView.tintColor = UIColor.black
        curfewRequirementsView.addSubview(curfewImageView)
        
        //        帰宅時間セクション-帰宅時間
        curfewLabel.frame=CGRect(x: 0, y: sectionHeight * 2 / 3, width: sectionHeight * 2 / 3, height: sectionHeight / 3)
        curfewLabel.text = "帰宅時間"
        curfewLabel.textColor = UIColor.systemGray2
        curfewLabel.textAlignment = .center
        curfewLabel.adjustsFontSizeToFitWidth = true
        curfewRequirementsView.addSubview(curfewLabel)
        
        //        帰宅時間セクション-帰宅時間条件
        curfewRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12 + 20, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        curfewRequirementLabel.adjustsFontSizeToFitWidth = true
        curfewRequirementLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        curfewRequirementLabel.textAlignment = .center
        curfewRequirementsView.addSubview(curfewRequirementLabel)

        
        //        '今の旅の旅条件'をラベルに出力
        let nowTripRequirements = realm.objects(NowTripRequirements.self)
        if let nowTripRequirement = nowTripRequirements.first {
            destinationRequirementLabel.text = nowTripRequirement.nowDestinationRequirement
            transportationRequirementLabel.text = nowTripRequirement.nowTransportationRequirement
            costRequirementLabel.text = "¥" +  String(nowTripRequirement.nowCostRequirement) + "-"
            curfewRequirementLabel.text = nowTripRequirement.nowCurfewRequirement
        } else {
            
        }
        
    }
    
    func tappedFinishButton(){
        let alert: UIAlertController = UIAlertController(title: "旅を完了しますか？", message: "旅を完了すると元の画面に戻れません。", preferredStyle: .alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "完了", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FinishTripViewController") as! FinishTripViewController
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func tappedRetireButton() {
        let alert: UIAlertController = UIAlertController(title: "旅をリタイアしますか？", message: "旅をリタイアすると元の画面に戻れません。", preferredStyle: .alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "リタイア", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 1
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print("No TabBarController found")
            }
        })
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }


}
