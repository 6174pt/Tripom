//
//  TripRequirementsViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/19.
//

import UIKit
import RealmSwift

class TripRequirementsViewController: UIViewController {
    
    let startButton: UIButton = UIButton()
    let resetButton: UIButton = UIButton()
    
    let requirementsView: UIView = UIView()
    
    let requirementsCommentView: UIView = UIView()
    let requirementsCommentLabel: UILabel = UILabel()
    
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
    
    var nowDestinationRequirement: String = ""
    var nowTransportationRequirement: String = ""
    var nowCostRequirement: Int = 0
    var nowCurfewRequirement: String = ""
    var nowDestinationRequirementTripPoint: Int = 5
    var nowTransportationRequirementTripPoint: Int = 5
    var nowCostRequirementTripPoint: Int = 5
    var nowCurfewRequirementTripPoint: Int = 5
    
    var resetRequirementsCount: Int = 0
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetRequirementsCount = 0
        
        self.navigationItem.hidesBackButton = true
        
        randomizeTripRequirements()
        
        let buttonWidth: CGFloat = self.view.frame.size.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth * 1 / 5
        let buttonMargin: CGFloat = self.view.frame.size.height * 0.05
        
        startButton.backgroundColor = UIColor.black
        startButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight * 2 - buttonMargin * 1.5, width: buttonWidth, height: buttonHeight)
        startButton.layer.cornerRadius = buttonHeight / 4
        startButton.setTitle("この旅条件で旅を始める", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        startButton.addAction(UIAction(handler: { _ in
            self.tappedStartButton()
        }), for: .touchUpInside)
        view.addSubview(startButton)
        
        resetButton.backgroundColor = UIColor.gray
        resetButton.frame = CGRect(x: (self.view.frame.size.width / 2) - buttonWidth / 2, y: self.view.frame.size.height - buttonHeight - buttonMargin, width: buttonWidth, height: buttonHeight)
        resetButton.layer.cornerRadius = buttonHeight / 4
        resetButton.setTitle("旅条件をリセットする", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        resetButton.addAction(UIAction(handler: { _ in
            self.tappedResetButton()
        }), for: .touchUpInside)
        view.addSubview(resetButton)
        
        //        旅条件表示ビュー
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        let requirementsViewMargin = (buttonHeight * 2) + (buttonMargin * 1.5) + (navBarHeight ?? 50)
        let requirementsViewHeight = view.frame.size.height - requirementsViewMargin
        
        requirementsView.frame=CGRect(x: 0, y: (navBarHeight ?? 50), width: view.frame.size.width, height: requirementsViewHeight)
        view.addSubview(requirementsView)
        
        let sectionWidthRation = 1.0 / 2.0
        let sectionHeightRation = 1.0 / 8.0
        let sectionWidth = view.frame.size.width * sectionWidthRation
        let sectionHeight = requirementsViewHeight * sectionHeightRation
        let sectionLeftRightMargin = (view.frame.size.width * (1.0 - sectionWidthRation)) / 2 + 20
        let sectionTopBottomMargin = 30.0
        print(sectionTopBottomMargin)
        
//        コメントセクション
        requirementsCommentView.frame=CGRect(x: sectionLeftRightMargin - 20, y: sectionHeight / 2, width: sectionWidth, height: sectionHeight)
        requirementsView.addSubview(requirementsCommentView)
        
//        コメントセクション-コメント
        requirementsCommentLabel.frame=CGRect(x: 0, y: 0, width: sectionWidth, height: sectionHeight)
        requirementsCommentLabel.text = "今回の旅の条件はこれ！"
        requirementsCommentLabel.textAlignment = .center
        requirementsCommentLabel.adjustsFontSizeToFitWidth = true
        requirementsCommentView.addSubview(requirementsCommentLabel)
        
//        目的地セクション
        destinationRequirementsView.frame=CGRect(x: sectionLeftRightMargin, y: sectionTopBottomMargin * 2 + sectionHeight, width: sectionWidth, height: sectionHeight)
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
        destinationRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        destinationRequirementLabel.adjustsFontSizeToFitWidth = true
        destinationRequirementLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        destinationRequirementLabel.textAlignment = .center
        destinationRequirementsView.addSubview(destinationRequirementLabel)
        
//        交通手段セクション
        transportationRequirementsView.frame=CGRect(x: sectionLeftRightMargin, y: sectionTopBottomMargin * 3 + sectionHeight * 2, width: sectionWidth, height: sectionHeight)
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
        transportationRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        transportationRequirementLabel.adjustsFontSizeToFitWidth = true
        transportationRequirementLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        transportationRequirementLabel.textAlignment = .center
        transportationRequirementsView.addSubview(transportationRequirementLabel)
        
//        費用セクション
        costRequirementsView.frame=CGRect(x: sectionLeftRightMargin, y: sectionTopBottomMargin * 4 + sectionHeight * 3, width: sectionWidth, height: sectionHeight)
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
        costRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        costRequirementLabel.adjustsFontSizeToFitWidth = true
        costRequirementLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        costRequirementLabel.textAlignment = .center
        costRequirementsView.addSubview(costRequirementLabel)
        
//        帰宅時間セクション
        curfewRequirementsView.frame=CGRect(x: sectionLeftRightMargin, y: sectionTopBottomMargin * 5 + sectionHeight * 4, width: sectionWidth, height: sectionHeight)
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
        curfewRequirementLabel.frame=CGRect(x: requirementsViewHeight / 12, y: 0, width: sectionWidth - sectionHeight, height: sectionHeight)
        curfewRequirementLabel.adjustsFontSizeToFitWidth = true
        curfewRequirementLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        curfewRequirementLabel.textAlignment = .center
        curfewRequirementsView.addSubview(curfewRequirementLabel)

    }
    
    @objc func randomizeTripRequirements(){
//        isPresented = trueの旅条件だけフィルタリング
        let tripDestinationRequirement = realm.objects(DestinationRequirements.self).filter("isPresented = true")
        let tripTransportationRequirement = realm.objects(TransportationRequirements.self).filter("isPresented = true")
        let tripCostRequirement = realm.objects(CostRequirements.self).filter("isPresented = true")
        let tripCurfewRequirement = realm.objects(CurfewRequirements.self).filter("isPresented = true")
        
//        ランダムな旅条件を出力
//        目的地
        if let randomDestinationRequirements = tripDestinationRequirement.randomElement() {
//            print("destination: \(randomDestinationRequirements.destinationRequirement), tripPoint: \(randomDestinationRequirements.tripPoint)")
            destinationRequirementLabel.text = randomDestinationRequirements.destinationRequirement
            nowDestinationRequirement = randomDestinationRequirements.destinationRequirement
            nowDestinationRequirementTripPoint = randomDestinationRequirements.tripPoint
        } else {
            print("No persons found in the database.")
        }
        
//        交通手段
        if let randomTransportationRequirements = tripTransportationRequirement.randomElement() {
//            print("destination: \(randomTransportationRequirements.transportationRequirement), tripPoint: \(randomTransportationRequirements.tripPoint)")
            transportationRequirementLabel.text = randomTransportationRequirements.transportationRequirement
            nowTransportationRequirement = randomTransportationRequirements.transportationRequirement
            nowTransportationRequirementTripPoint = randomTransportationRequirements.tripPoint
        } else {
            print("No persons found in the database.")
        }
        
//        費用
        if let randomCostRequirements = tripCostRequirement.randomElement() {
//            print("destination: \(randomCostRequirements.costRequirement), tripPoint: \(randomCostRequirements.tripPoint)")
            costRequirementLabel.text = "¥" + String(randomCostRequirements.costRequirement) + "-"
            nowCostRequirement = randomCostRequirements.costRequirement
            nowCostRequirementTripPoint = randomCostRequirements.tripPoint
        } else {
            print("No persons found in the database.")
        }
        
//        帰宅時間
        if let randomCurfewRequirements = tripCurfewRequirement.randomElement() {
//            print("destination: \(randomCurfewRequirements.curfewRequirement), tripPoint: \(randomCurfewRequirements.tripPoint)")
            curfewRequirementLabel.text = randomCurfewRequirements.curfewRequirement
            nowCurfewRequirement = randomCurfewRequirements.curfewRequirement
            nowCurfewRequirementTripPoint = randomCurfewRequirements.tripPoint
        } else {
            print("No persons found in the database.")
        }
    }
    
    func tappedStartButton(){
//        '提案された旅条件'を'今の旅の旅条件'に代入する
        let existingNowTripRequirementsData = realm.objects(NowTripRequirements.self)
//        '今の旅の旅条件'が空の時はそのまま'提案された旅条件'を'今の旅の旅条件'に代入する
        if existingNowTripRequirementsData.isEmpty {
            try! realm.write {
                let nowTripRequirement = NowTripRequirements()
                nowTripRequirement.nowDestinationRequirement = nowDestinationRequirement
                nowTripRequirement.nowTransportationRequirement = nowTransportationRequirement
                nowTripRequirement.nowCostRequirement = nowCostRequirement
                nowTripRequirement.nowCurfewRequirement = nowCurfewRequirement
                nowTripRequirement.allTripPoint = nowDestinationRequirementTripPoint + nowTransportationRequirementTripPoint + nowTransportationRequirementTripPoint + nowCurfewRequirementTripPoint - resetRequirementsCount * 3
                realm.add(nowTripRequirement)
            }
            //        '今の旅の旅条件'が空ではない時は'今の旅の旅条件'を空にして'提案された旅条件'を'今の旅の旅条件'に代入する
        } else {
            try! realm.write {
                let objectToDelete = realm.objects(NowTripRequirements.self)
                realm.delete(objectToDelete)
                let nowTripRequirement = NowTripRequirements()
                nowTripRequirement.nowDestinationRequirement = nowDestinationRequirement
                nowTripRequirement.nowTransportationRequirement = nowTransportationRequirement
                nowTripRequirement.nowCostRequirement = nowCostRequirement
                nowTripRequirement.nowCurfewRequirement = nowCurfewRequirement
                nowTripRequirement.allTripPoint = nowDestinationRequirementTripPoint + nowTransportationRequirementTripPoint + nowTransportationRequirementTripPoint + nowCurfewRequirementTripPoint - resetRequirementsCount * 3
                realm.add(nowTripRequirement)
                    }
        }
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnATripViewController") as! OnATripViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    ’旅条件をリセットする’ボタンを押した時
    func tappedResetButton() {
        let alert: UIAlertController = UIAlertController(title: "旅条件をリセットしますか？", message: "旅条件をリセットすると、旅完了後に加算される旅ポイントが減少します", preferredStyle: .alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "リセット", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            self.resetRequirementsCount += 1
            print(self.resetRequirementsCount)
            self.randomizeTripRequirements()
            
//            多分ここでスタート画面に戻る意味ない
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartTripViewController") as! StartTripViewController
//            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }

}
