//
//  NowTripRequirements.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/28.
//

import Foundation
import RealmSwift

class NowTripRequirements: Object {
    @Persisted var nowDestinationRequirement: String = ""
    @Persisted var nowTransportationRequirement: String = ""
    @Persisted var nowCostRequirement: Int = 0
    @Persisted var nowCurfewRequirement: String = ""
    @Persisted var allTripPoint: Int = 20
}
