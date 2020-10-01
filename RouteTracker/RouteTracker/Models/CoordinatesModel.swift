//
//  CoordinatesModel.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 01.10.2020.
//

import RealmSwift
import CoreLocation

final class RealmCoordinatesModel: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
}
