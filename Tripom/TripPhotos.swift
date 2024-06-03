//
//  TripPhotos.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/30.
//

import Foundation
import RealmSwift

class TripPhotos: Object {
    @Persisted var imageName: String = ""
}
