//
//  RealmUser.swift
//  Social Hub
//
//  Created by Jonathan on 12/29/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import RealmSwift

class RealmUser: Object {
    @objc dynamic var uid:String?
    @objc dynamic var username:String?
    @objc dynamic var profileImageUrl:String?
    @objc dynamic var email:String?
    
    func createRealmUserFromDictionary(uid:String, dictionary:[String:Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
    
    func createRealmUserFromUserModal(user:User) {
        self.uid = user.uid
        self.username = user.username
        self.profileImageUrl = user.profileImageUrl
        self.email = user.email
    }
 
    func giveBackUserModal() -> User {
        let value:[String:Any] = [
            "username":self.username as Any,
            "profileImageUrl":self.profileImageUrl as Any,
            "email":self.email as Any
        ]
        return User(uid: self.uid!, dictionary: value)
    }
}
