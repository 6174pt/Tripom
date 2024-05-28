//
//  CostRequirements.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/28.
//

import Foundation
import RealmSwift

class CostRequirements: Object {
    @Persisted var costRequirement: Int = 0
    @Persisted var tripPoint: Int = 5
//    この旅条件が提示されるかどうかのBool値
    @Persisted var isPresented: Bool = true
}

