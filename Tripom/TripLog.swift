//
//  TripLog.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/28.
//

import Foundation
import RealmSwift

class TripLog: Object {
//    旅条件
//    @Persisted var tripDate:
    @Persisted var destinationRequirement: String = ""
    @Persisted var transportationRequirement: String = ""
    @Persisted var costRequirement: Int = 0
    @Persisted var curfewRequirement: String = ""
//    旅ポイント(不要？？)
    @Persisted var tripPoint: Int = 20
//    コメント
    @Persisted var tripComment: String = ""
//    写真
//    @Persisted var photoURL: String = ""
    @Persisted var photoURLs: List<String> = List<String>()
}
