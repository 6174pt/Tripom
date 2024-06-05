//
//  AppDelegate.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/19.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(schemaVersion: 8)
        Realm.Configuration.defaultConfiguration = config
        
        setupInitialData()
        
        return true
    }
    
    func setupInitialData() {
        let realm = try! Realm()

//        目的地
//        すでにデータが存在するか確認
        let existingDestinationRequirementsData = realm.objects(DestinationRequirements.self)
        if existingDestinationRequirementsData.isEmpty {
            try! realm.write {
                let destinationTripRequirement1 = DestinationRequirements()
                destinationTripRequirement1.destinationRequirement = "東京駅"
                destinationTripRequirement1.tripPoint = 5
                realm.add(destinationTripRequirement1)
                
                let destinationTripRequirement2 = DestinationRequirements()
                destinationTripRequirement2.destinationRequirement = "高尾山"
                destinationTripRequirement2.tripPoint = 5
                realm.add(destinationTripRequirement2)
                
                let destinationTripRequirement3 = DestinationRequirements()
                destinationTripRequirement3.destinationRequirement = "江ノ島"
                destinationTripRequirement3.tripPoint = 5
                realm.add(destinationTripRequirement3)
                
                let destinationTripRequirement4 = DestinationRequirements()
                destinationTripRequirement4.destinationRequirement = "山下公園"
                destinationTripRequirement4.tripPoint = 5
                realm.add(destinationTripRequirement4)
            }
            print("Initial data has been added to Realm.")
        } else {
            print("Initial data already exists in Realm.")
        }
           
//        交通手段
//        すでにデータが存在するか確認
        let existingTransportationRequirementsData = realm.objects(TransportationRequirements.self)
        if existingTransportationRequirementsData.isEmpty {
            try! realm.write {
                let transportationRequirement1 = TransportationRequirements()
                transportationRequirement1.transportationRequirement = "自転車"
                transportationRequirement1.tripPoint = 5
                realm.add(transportationRequirement1)
                
                let transportationRequirement2 = TransportationRequirements()
                transportationRequirement2.transportationRequirement = "電車"
                transportationRequirement2.tripPoint = 5
                realm.add(transportationRequirement2)
                
                let transportationRequirement3 = TransportationRequirements()
                transportationRequirement3.transportationRequirement = "バス"
                transportationRequirement3.tripPoint = 5
                realm.add(transportationRequirement3)
                
                let transportationRequirement4 = TransportationRequirements()
                transportationRequirement4.transportationRequirement = "徒歩"
                transportationRequirement4.tripPoint = 5
                realm.add(transportationRequirement4)
            }
            print("Initial data has been added to Realm.")
        } else {
            print("Initial data already exists in Realm.")
        }
        
//        費用
//        すでにデータが存在するか確認
        let existingCostRequirementsData = realm.objects(CostRequirements.self)
        if existingCostRequirementsData.isEmpty {
            try! realm.write {
                
                let costRequirement1 = CostRequirements()
                costRequirement1.costRequirement = 1000
                costRequirement1.tripPoint = 5
                realm.add(costRequirement1)
                
                let costRequirement2 = CostRequirements()
                costRequirement2.costRequirement = 2000
                costRequirement2.tripPoint = 5
                realm.add(costRequirement2)
                
                let costRequirement3 = CostRequirements()
                costRequirement3.costRequirement = 3000
                costRequirement3.tripPoint = 5
                realm.add(costRequirement3)
                
                let costRequirement4 = CostRequirements()
                costRequirement4.costRequirement = 4000
                costRequirement4.tripPoint = 5
                realm.add(costRequirement4)
            }
            print("Initial data has been added to Realm.")
        } else {
            print("Initial data already exists in Realm.")
        }
             
//        帰宅時間
//        すでにデータが存在するか確認
        let existingCurfewRequirementsData = realm.objects(CurfewRequirements.self)
        if existingCurfewRequirementsData.isEmpty {
            try! realm.write {
                let curfewRequirement1 = CurfewRequirements()
                curfewRequirement1.curfewRequirement = "16:00"
                curfewRequirement1.tripPoint = 5
                realm.add(curfewRequirement1)
                
                let curfewRequirement2 = CurfewRequirements()
                curfewRequirement2.curfewRequirement = "17:00"
                curfewRequirement2.tripPoint = 5
                realm.add(curfewRequirement2)
                
                let curfewRequirement3 = CurfewRequirements()
                curfewRequirement3.curfewRequirement = "18:00"
                curfewRequirement3.tripPoint = 5
                realm.add(curfewRequirement3)
                
                let curfewRequirement4 = CurfewRequirements()
                curfewRequirement4.curfewRequirement = "19:00"
                curfewRequirement4.tripPoint = 5
                realm.add(curfewRequirement4)
            }
            print("Initial data has been added to Realm.")
        } else {
            print("Initial data already exists in Realm.")
        }
          
        //        User情報
        //        すでにデータが存在するか確認
        let existingUserData = realm.objects(User.self)
        if existingUserData.isEmpty {
            try! realm.write {
                let user = User()
                user.userID = "userID"
                user.userName = "userName"
                user.tripPoints = 0
                user.tripLevel = 1
                realm.add(user)
            }
            print("Initial data has been added to Realm.")
        } else {
            print("Initial data already exists in Realm.")
        }
        
        //        旅の記録
        //        すでにデータが存在するか確認
//        let existingTripLogData = realm.objects(TripLog.self)
//        if existingTripLogData.isEmpty {
//            try! realm.write {
//                let tripLog1 = TripLog()
//                tripLog1.destinationRequirement = "東京駅"
//                tripLog1.transportationRequirement = "自転車"
//                tripLog1.costRequirement = 1000
//                tripLog1.curfewRequirement = "16:00"
//                tripLog1.tripPoint = 20
//                tripLog1.tripComment = "楽しかった！"
//                realm.add(tripLog1)
//                
//                
//            }
//            print("Initial data has been added to Realm.")
//        } else {
//            print("Initial data already exists in Realm.")
//        }
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

