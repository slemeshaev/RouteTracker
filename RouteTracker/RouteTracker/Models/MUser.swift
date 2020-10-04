//
//  MUser.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 04.10.2020.
//

import UIKit
import RealmSwift

class MUser: Object {
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    
    override static func primaryKey() -> String? {
        return "login"
    }
}
