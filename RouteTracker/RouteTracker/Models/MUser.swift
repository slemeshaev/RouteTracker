//
//  MUser.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 04.10.2020.
//

import UIKit
import RealmSwift

class MUser: Object {
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
    
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
    
    override static func primaryKey() -> String? {
        return "login"
    }
    
}
