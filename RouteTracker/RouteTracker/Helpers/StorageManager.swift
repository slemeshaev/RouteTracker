//
//  StorageManager.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 04.10.2020.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    // сохранение объекта user
    static func saveObject(_ user: MUser) {
        
        try! realm.write {
            realm.add(user)
        }
    }
    
    // удаление объекта user
    static func deleteObject(_ user: MUser) {
        
        try! realm.write {
            realm.delete(user)
        }
    }
    
}
