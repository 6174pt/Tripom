//
//  User.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/06/04.
//

import Foundation
import RealmSwift

class User: Object {
//    旅条件
    @Persisted var userIconImageURL: String = ""
    @Persisted var userID: String = UUID().uuidString
    @Persisted var userName: String = ""
    @Persisted var tripPoints: Int = 0
    @Persisted var tripLevel: Int = 1
}
