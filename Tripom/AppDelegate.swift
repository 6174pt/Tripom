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
        
        let config = Realm.Configuration(schemaVersion: 14)
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
                
                let destinationTripRequirement5 = DestinationRequirements()
                destinationTripRequirement5.destinationRequirement = "東京タワー"
                destinationTripRequirement5.tripPoint = 5
                realm.add(destinationTripRequirement5)

                let destinationTripRequirement6 = DestinationRequirements()
                destinationTripRequirement6.destinationRequirement = "スカイツリー"
                destinationTripRequirement6.tripPoint = 5
                realm.add(destinationTripRequirement6)

                let destinationTripRequirement7 = DestinationRequirements()
                destinationTripRequirement7.destinationRequirement = "浅草寺"
                destinationTripRequirement7.tripPoint = 5
                realm.add(destinationTripRequirement7)

                let destinationTripRequirement8 = DestinationRequirements()
                destinationTripRequirement8.destinationRequirement = "明治神宮"
                destinationTripRequirement8.tripPoint = 5
                realm.add(destinationTripRequirement8)

                let destinationTripRequirement9 = DestinationRequirements()
                destinationTripRequirement9.destinationRequirement = "新宿御苑"
                destinationTripRequirement9.tripPoint = 5
                realm.add(destinationTripRequirement9)

                let destinationTripRequirement10 = DestinationRequirements()
                destinationTripRequirement10.destinationRequirement = "上野公園"
                destinationTripRequirement10.tripPoint = 5
                realm.add(destinationTripRequirement10)

                let destinationTripRequirement11 = DestinationRequirements()
                destinationTripRequirement11.destinationRequirement = "渋谷スクランブル交差点"
                destinationTripRequirement11.tripPoint = 5
                realm.add(destinationTripRequirement11)

                let destinationTripRequirement12 = DestinationRequirements()
                destinationTripRequirement12.destinationRequirement = "銀座"
                destinationTripRequirement12.tripPoint = 5
                realm.add(destinationTripRequirement12)

                let destinationTripRequirement13 = DestinationRequirements()
                destinationTripRequirement13.destinationRequirement = "築地市場"
                destinationTripRequirement13.tripPoint = 5
                realm.add(destinationTripRequirement13)

                let destinationTripRequirement14 = DestinationRequirements()
                destinationTripRequirement14.destinationRequirement = "皇居"
                destinationTripRequirement14.tripPoint = 5
                realm.add(destinationTripRequirement14)

                let destinationTripRequirement15 = DestinationRequirements()
                destinationTripRequirement15.destinationRequirement = "お台場"
                destinationTripRequirement15.tripPoint = 5
                realm.add(destinationTripRequirement15)

                let destinationTripRequirement16 = DestinationRequirements()
                destinationTripRequirement16.destinationRequirement = "六本木ヒルズ"
                destinationTripRequirement16.tripPoint = 5
                realm.add(destinationTripRequirement16)

                let destinationTripRequirement17 = DestinationRequirements()
                destinationTripRequirement17.destinationRequirement = "お台場ヴィーナスフォート"
                destinationTripRequirement17.tripPoint = 5
                realm.add(destinationTripRequirement17)

                let destinationTripRequirement18 = DestinationRequirements()
                destinationTripRequirement18.destinationRequirement = "東京ディズニーランド"
                destinationTripRequirement18.tripPoint = 5
                realm.add(destinationTripRequirement18)

                let destinationTripRequirement19 = DestinationRequirements()
                destinationTripRequirement19.destinationRequirement = "東京ディズニーシー"
                destinationTripRequirement19.tripPoint = 5
                realm.add(destinationTripRequirement19)

                let destinationTripRequirement20 = DestinationRequirements()
                destinationTripRequirement20.destinationRequirement = "東京国立博物館"
                destinationTripRequirement20.tripPoint = 5
                realm.add(destinationTripRequirement20)

                let destinationTripRequirement21 = DestinationRequirements()
                destinationTripRequirement21.destinationRequirement = "上野動物園"
                destinationTripRequirement21.tripPoint = 5
                realm.add(destinationTripRequirement21)

                let destinationTripRequirement22 = DestinationRequirements()
                destinationTripRequirement22.destinationRequirement = "国立西洋美術館"
                destinationTripRequirement22.tripPoint = 5
                realm.add(destinationTripRequirement22)

                let destinationTripRequirement23 = DestinationRequirements()
                destinationTripRequirement23.destinationRequirement = "サンシャインシティ"
                destinationTripRequirement23.tripPoint = 5
                realm.add(destinationTripRequirement23)

                let destinationTripRequirement24 = DestinationRequirements()
                destinationTripRequirement24.destinationRequirement = "東京ドームシティ"
                destinationTripRequirement24.tripPoint = 5
                realm.add(destinationTripRequirement24)

                let destinationTripRequirement25 = DestinationRequirements()
                destinationTripRequirement25.destinationRequirement = "赤坂サカス"
                destinationTripRequirement25.tripPoint = 5
                realm.add(destinationTripRequirement25)

                let destinationTripRequirement26 = DestinationRequirements()
                destinationTripRequirement26.destinationRequirement = "汐留"
                destinationTripRequirement26.tripPoint = 5
                realm.add(destinationTripRequirement26)

                let destinationTripRequirement27 = DestinationRequirements()
                destinationTripRequirement27.destinationRequirement = "日本橋"
                destinationTripRequirement27.tripPoint = 5
                realm.add(destinationTripRequirement27)

                let destinationTripRequirement28 = DestinationRequirements()
                destinationTripRequirement28.destinationRequirement = "東京駅"
                destinationTripRequirement28.tripPoint = 5
                realm.add(destinationTripRequirement28)

                let destinationTripRequirement29 = DestinationRequirements()
                destinationTripRequirement29.destinationRequirement = "東京湾"
                destinationTripRequirement29.tripPoint = 5
                realm.add(destinationTripRequirement29)

                let destinationTripRequirement30 = DestinationRequirements()
                destinationTripRequirement30.destinationRequirement = "大江戸温泉物語"
                destinationTripRequirement30.tripPoint = 5
                realm.add(destinationTripRequirement30)

                let destinationTripRequirement31 = DestinationRequirements()
                destinationTripRequirement31.destinationRequirement = "根津神社"
                destinationTripRequirement31.tripPoint = 5
                realm.add(destinationTripRequirement31)

                let destinationTripRequirement32 = DestinationRequirements()
                destinationTripRequirement32.destinationRequirement = "千鳥ヶ淵"
                destinationTripRequirement32.tripPoint = 5
                realm.add(destinationTripRequirement32)

                let destinationTripRequirement33 = DestinationRequirements()
                destinationTripRequirement33.destinationRequirement = "東京都庁展望台"
                destinationTripRequirement33.tripPoint = 5
                realm.add(destinationTripRequirement33)

                let destinationTripRequirement34 = DestinationRequirements()
                destinationTripRequirement34.destinationRequirement = "原宿"
                destinationTripRequirement34.tripPoint = 5
                realm.add(destinationTripRequirement34)

                let destinationTripRequirement35 = DestinationRequirements()
                destinationTripRequirement35.destinationRequirement = "代々木公園"
                destinationTripRequirement35.tripPoint = 5
                realm.add(destinationTripRequirement35)

                let destinationTripRequirement36 = DestinationRequirements()
                destinationTripRequirement36.destinationRequirement = "代官山"
                destinationTripRequirement36.tripPoint = 5
                realm.add(destinationTripRequirement36)

                let destinationTripRequirement37 = DestinationRequirements()
                destinationTripRequirement37.destinationRequirement = "恵比寿ガーデンプレイス"
                destinationTripRequirement37.tripPoint = 5
                realm.add(destinationTripRequirement37)

                let destinationTripRequirement38 = DestinationRequirements()
                destinationTripRequirement38.destinationRequirement = "錦糸町"
                destinationTripRequirement38.tripPoint = 5
                realm.add(destinationTripRequirement38)

                let destinationTripRequirement39 = DestinationRequirements()
                destinationTripRequirement39.destinationRequirement = "吉祥寺"
                destinationTripRequirement39.tripPoint = 5
                realm.add(destinationTripRequirement39)

                let destinationTripRequirement40 = DestinationRequirements()
                destinationTripRequirement40.destinationRequirement = "井の頭恩賜公園"
                destinationTripRequirement40.tripPoint = 5
                realm.add(destinationTripRequirement40)

                let destinationTripRequirement41 = DestinationRequirements()
                destinationTripRequirement41.destinationRequirement = "三鷹の森ジブリ美術館"
                destinationTripRequirement41.tripPoint = 5
                realm.add(destinationTripRequirement41)

                let destinationTripRequirement42 = DestinationRequirements()
                destinationTripRequirement42.destinationRequirement = "大井競馬場"
                destinationTripRequirement42.tripPoint = 5
                realm.add(destinationTripRequirement42)

                let destinationTripRequirement43 = DestinationRequirements()
                destinationTripRequirement43.destinationRequirement = "お台場海浜公園"
                destinationTripRequirement43.tripPoint = 5
                realm.add(destinationTripRequirement43)

                let destinationTripRequirement44 = DestinationRequirements()
                destinationTripRequirement44.destinationRequirement = "日比谷公園"
                destinationTripRequirement44.tripPoint = 5
                realm.add(destinationTripRequirement44)

                let destinationTripRequirement45 = DestinationRequirements()
                destinationTripRequirement45.destinationRequirement = "高尾山"
                destinationTripRequirement45.tripPoint = 5
                realm.add(destinationTripRequirement45)

                let destinationTripRequirement46 = DestinationRequirements()
                destinationTripRequirement46.destinationRequirement = "青山霊園"
                destinationTripRequirement46.tripPoint = 5
                realm.add(destinationTripRequirement46)

                let destinationTripRequirement47 = DestinationRequirements()
                destinationTripRequirement47.destinationRequirement = "東京ミッドタウン"
                destinationTripRequirement47.tripPoint = 5
                realm.add(destinationTripRequirement47)

                let destinationTripRequirement48 = DestinationRequirements()
                destinationTripRequirement48.destinationRequirement = "新橋"
                destinationTripRequirement48.tripPoint = 5
                realm.add(destinationTripRequirement48)

                let destinationTripRequirement49 = DestinationRequirements()
                destinationTripRequirement49.destinationRequirement = "丸の内"
                destinationTripRequirement49.tripPoint = 5
                realm.add(destinationTripRequirement49)

                let destinationTripRequirement50 = DestinationRequirements()
                destinationTripRequirement50.destinationRequirement = "大手町"
                destinationTripRequirement50.tripPoint = 5
                realm.add(destinationTripRequirement50)

                let destinationTripRequirement51 = DestinationRequirements()
                destinationTripRequirement51.destinationRequirement = "神田明神"
                destinationTripRequirement51.tripPoint = 5
                realm.add(destinationTripRequirement51)

                let destinationTripRequirement52 = DestinationRequirements()
                destinationTripRequirement52.destinationRequirement = "神楽坂"
                destinationTripRequirement52.tripPoint = 5
                realm.add(destinationTripRequirement52)

                let destinationTripRequirement53 = DestinationRequirements()
                destinationTripRequirement53.destinationRequirement = "池袋サンシャイン水族館"
                destinationTripRequirement53.tripPoint = 5
                realm.add(destinationTripRequirement53)

                let destinationTripRequirement54 = DestinationRequirements()
                destinationTripRequirement54.destinationRequirement = "高円寺"
                destinationTripRequirement54.tripPoint = 5
                realm.add(destinationTripRequirement54)

                let destinationTripRequirement55 = DestinationRequirements()
                destinationTripRequirement55.destinationRequirement = "下北沢"
                destinationTripRequirement55.tripPoint = 5
                realm.add(destinationTripRequirement55)

                let destinationTripRequirement56 = DestinationRequirements()
                destinationTripRequirement56.destinationRequirement = "秋葉原"
                destinationTripRequirement56.tripPoint = 5
                realm.add(destinationTripRequirement56)

                let destinationTripRequirement57 = DestinationRequirements()
                destinationTripRequirement57.destinationRequirement = "御茶ノ水"
                destinationTripRequirement57.tripPoint = 5
                realm.add(destinationTripRequirement57)

                let destinationTripRequirement58 = DestinationRequirements()
                destinationTripRequirement58.destinationRequirement = "武道館"
                destinationTripRequirement58.tripPoint = 5
                realm.add(destinationTripRequirement58)

                let destinationTripRequirement59 = DestinationRequirements()
                destinationTripRequirement59.destinationRequirement = "靖国神社"
                destinationTripRequirement59.tripPoint = 5
                realm.add(destinationTripRequirement59)

                let destinationTripRequirement60 = DestinationRequirements()
                destinationTripRequirement60.destinationRequirement = "上野東照宮"
                destinationTripRequirement60.tripPoint = 5
                realm.add(destinationTripRequirement60)

                let destinationTripRequirement61 = DestinationRequirements()
                destinationTripRequirement61.destinationRequirement = "築地本願寺"
                destinationTripRequirement61.tripPoint = 5
                realm.add(destinationTripRequirement61)

                let destinationTripRequirement62 = DestinationRequirements()
                destinationTripRequirement62.destinationRequirement = "墨田水族館"
                destinationTripRequirement62.tripPoint = 5
                realm.add(destinationTripRequirement62)

                let destinationTripRequirement63 = DestinationRequirements()
                destinationTripRequirement63.destinationRequirement = "浅草花やしき"
                destinationTripRequirement63.tripPoint = 5
                realm.add(destinationTripRequirement63)

                let destinationTripRequirement64 = DestinationRequirements()
                destinationTripRequirement64.destinationRequirement = "水道橋"
                destinationTripRequirement64.tripPoint = 5
                realm.add(destinationTripRequirement64)

                let destinationTripRequirement65 = DestinationRequirements()
                destinationTripRequirement65.destinationRequirement = "目黒川"
                destinationTripRequirement65.tripPoint = 5
                realm.add(destinationTripRequirement65)

                let destinationTripRequirement66 = DestinationRequirements()
                destinationTripRequirement66.destinationRequirement = "東京大神宮"
                destinationTripRequirement66.tripPoint = 5
                realm.add(destinationTripRequirement66)

                let destinationTripRequirement67 = DestinationRequirements()
                destinationTripRequirement67.destinationRequirement = "北の丸公園"
                destinationTripRequirement67.tripPoint = 5
                realm.add(destinationTripRequirement67)

                let destinationTripRequirement68 = DestinationRequirements()
                destinationTripRequirement68.destinationRequirement = "芝公園"
                destinationTripRequirement68.tripPoint = 5
                realm.add(destinationTripRequirement68)

                let destinationTripRequirement69 = DestinationRequirements()
                destinationTripRequirement69.destinationRequirement = "六義園"
                destinationTripRequirement69.tripPoint = 5
                realm.add(destinationTripRequirement69)

                let destinationTripRequirement70 = DestinationRequirements()
                destinationTripRequirement70.destinationRequirement = "浜離宮恩賜庭園"
                destinationTripRequirement70.tripPoint = 5
                realm.add(destinationTripRequirement70)

                let destinationTripRequirement71 = DestinationRequirements()
                destinationTripRequirement71.destinationRequirement = "旧岩崎邸庭園"
                destinationTripRequirement71.tripPoint = 5
                realm.add(destinationTripRequirement71)

                let destinationTripRequirement72 = DestinationRequirements()
                destinationTripRequirement72.destinationRequirement = "武蔵野御陵"
                destinationTripRequirement72.tripPoint = 5
                realm.add(destinationTripRequirement72)

                let destinationTripRequirement73 = DestinationRequirements()
                destinationTripRequirement73.destinationRequirement = "高輪ゲートウェイ駅"
                destinationTripRequirement73.tripPoint = 5
                realm.add(destinationTripRequirement73)

                let destinationTripRequirement74 = DestinationRequirements()
                destinationTripRequirement74.destinationRequirement = "東京ビッグサイト"
                destinationTripRequirement74.tripPoint = 5
                realm.add(destinationTripRequirement74)

                let destinationTripRequirement75 = DestinationRequirements()
                destinationTripRequirement75.destinationRequirement = "八芳園"
                destinationTripRequirement75.tripPoint = 5
                realm.add(destinationTripRequirement75)

                let destinationTripRequirement76 = DestinationRequirements()
                destinationTripRequirement76.destinationRequirement = "築地銀だこ"
                destinationTripRequirement76.tripPoint = 5
                realm.add(destinationTripRequirement76)

                let destinationTripRequirement77 = DestinationRequirements()
                destinationTripRequirement77.destinationRequirement = "上野アメ横"
                destinationTripRequirement77.tripPoint = 5
                realm.add(destinationTripRequirement77)

                let destinationTripRequirement78 = DestinationRequirements()
                destinationTripRequirement78.destinationRequirement = "アクアシティお台場"
                destinationTripRequirement78.tripPoint = 5
                realm.add(destinationTripRequirement78)

                let destinationTripRequirement79 = DestinationRequirements()
                destinationTripRequirement79.destinationRequirement = "東京ジョイポリス"
                destinationTripRequirement79.tripPoint = 5
                realm.add(destinationTripRequirement79)

                let destinationTripRequirement80 = DestinationRequirements()
                destinationTripRequirement80.destinationRequirement = "お台場レインボーブリッジ"
                destinationTripRequirement80.tripPoint = 5
                realm.add(destinationTripRequirement80)

                let destinationTripRequirement81 = DestinationRequirements()
                destinationTripRequirement81.destinationRequirement = "新宿アルタ"
                destinationTripRequirement81.tripPoint = 5
                realm.add(destinationTripRequirement81)

                let destinationTripRequirement82 = DestinationRequirements()
                destinationTripRequirement82.destinationRequirement = "東急プラザ銀座"
                destinationTripRequirement82.tripPoint = 5
                realm.add(destinationTripRequirement82)

                let destinationTripRequirement83 = DestinationRequirements()
                destinationTripRequirement83.destinationRequirement = "渋谷109"
                destinationTripRequirement83.tripPoint = 5
                realm.add(destinationTripRequirement83)

                let destinationTripRequirement84 = DestinationRequirements()
                destinationTripRequirement84.destinationRequirement = "表参道ヒルズ"
                destinationTripRequirement84.tripPoint = 5
                realm.add(destinationTripRequirement84)

                let destinationTripRequirement85 = DestinationRequirements()
                destinationTripRequirement85.destinationRequirement = "ニューヨークバー（パークハイアット東京）"
                destinationTripRequirement85.tripPoint = 5
                realm.add(destinationTripRequirement85)

                let destinationTripRequirement86 = DestinationRequirements()
                destinationTripRequirement86.destinationRequirement = "三井アウトレットパーク木更津"
                destinationTripRequirement86.tripPoint = 5
                realm.add(destinationTripRequirement86)

                let destinationTripRequirement87 = DestinationRequirements()
                destinationTripRequirement87.destinationRequirement = "お台場ダイバーシティ"
                destinationTripRequirement87.tripPoint = 5
                realm.add(destinationTripRequirement87)

                let destinationTripRequirement88 = DestinationRequirements()
                destinationTripRequirement88.destinationRequirement = "青梅駅"
                destinationTripRequirement88.tripPoint = 5
                realm.add(destinationTripRequirement88)

                let destinationTripRequirement89 = DestinationRequirements()
                destinationTripRequirement89.destinationRequirement = "高輪"
                destinationTripRequirement89.tripPoint = 5
                realm.add(destinationTripRequirement89)

                let destinationTripRequirement90 = DestinationRequirements()
                destinationTripRequirement90.destinationRequirement = "紀尾井町"
                destinationTripRequirement90.tripPoint = 5
                realm.add(destinationTripRequirement90)

                let destinationTripRequirement91 = DestinationRequirements()
                destinationTripRequirement91.destinationRequirement = "赤羽"
                destinationTripRequirement91.tripPoint = 5
                realm.add(destinationTripRequirement91)

                let destinationTripRequirement92 = DestinationRequirements()
                destinationTripRequirement92.destinationRequirement = "西新宿"
                destinationTripRequirement92.tripPoint = 5
                realm.add(destinationTripRequirement92)

                let destinationTripRequirement93 = DestinationRequirements()
                destinationTripRequirement93.destinationRequirement = "東京都美術館"
                destinationTripRequirement93.tripPoint = 5
                realm.add(destinationTripRequirement93)

                let destinationTripRequirement94 = DestinationRequirements()
                destinationTripRequirement94.destinationRequirement = "江戸東京博物館"
                destinationTripRequirement94.tripPoint = 5
                realm.add(destinationTripRequirement94)

                let destinationTripRequirement95 = DestinationRequirements()
                destinationTripRequirement95.destinationRequirement = "渋谷ヒカリエ"
                destinationTripRequirement95.tripPoint = 5
                realm.add(destinationTripRequirement95)

                let destinationTripRequirement96 = DestinationRequirements()
                destinationTripRequirement96.destinationRequirement = "アメヤ横丁"
                destinationTripRequirement96.tripPoint = 5
                realm.add(destinationTripRequirement96)

                let destinationTripRequirement97 = DestinationRequirements()
                destinationTripRequirement97.destinationRequirement = "代官山T-SITE"
                destinationTripRequirement97.tripPoint = 5
                realm.add(destinationTripRequirement97)

                let destinationTripRequirement98 = DestinationRequirements()
                destinationTripRequirement98.destinationRequirement = "自由が丘"
                destinationTripRequirement98.tripPoint = 5
                realm.add(destinationTripRequirement98)

                let destinationTripRequirement99 = DestinationRequirements()
                destinationTripRequirement99.destinationRequirement = "中目黒"
                destinationTripRequirement99.tripPoint = 5
                realm.add(destinationTripRequirement99)

                let destinationTripRequirement100 = DestinationRequirements()
                destinationTripRequirement100.destinationRequirement = "高輪プリンスホテル"
                destinationTripRequirement100.tripPoint = 5
                realm.add(destinationTripRequirement100)

                let destinationTripRequirement101 = DestinationRequirements()
                destinationTripRequirement101.destinationRequirement = "東京体育館"
                destinationTripRequirement101.tripPoint = 5
                realm.add(destinationTripRequirement101)

                let destinationTripRequirement102 = DestinationRequirements()
                destinationTripRequirement102.destinationRequirement = "スカイツリーソラマチ"
                destinationTripRequirement102.tripPoint = 5
                realm.add(destinationTripRequirement102)

                let destinationTripRequirement103 = DestinationRequirements()
                destinationTripRequirement103.destinationRequirement = "西麻布"
                destinationTripRequirement103.tripPoint = 5
                realm.add(destinationTripRequirement103)

                let destinationTripRequirement104 = DestinationRequirements()
                destinationTripRequirement104.destinationRequirement = "渋谷ストリーム"
                destinationTripRequirement104.tripPoint = 5
                realm.add(destinationTripRequirement104)

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
                user.userIconImageURL = ""
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

