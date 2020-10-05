//
//  TrackModel.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 01.10.2020.
//

import RealmSwift

final class RealmTrackModel: Object {
    @objc dynamic var id: Int = 0
    let locationPoints = List<RealmCoordinatesModel>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

