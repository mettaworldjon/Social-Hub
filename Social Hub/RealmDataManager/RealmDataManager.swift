//
//  RealmDataManager.swift
//  Social Hub
//
//  Created by Jonathan on 12/29/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import RealmSwift

class RealmDataManager {
    
    private init(){}
    
    static public let shared = RealmDataManager()
    
    let realm = try! Realm()
    
    
}

// User Management
extension RealmDataManager {
    func fetchRealmUsers() -> Results<RealmUser> {
        let users = realm.objects(RealmUser.self)
        return users
    }
    
    func insertRealmUser(user:User) {
        let realmUser = RealmUser()
        realmUser.createRealmUserFromUserModal(user: user)
        do {
            try self.realm.write {
                self.realm.add(realmUser)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteUsers() {
        let realmUserDatabase = self.realm.objects(RealmUser.self)
        do {
            try self.realm.write {
                self.realm.delete(realmUserDatabase)
            }
        } catch let error {
            print(error)
        }
    }
}
