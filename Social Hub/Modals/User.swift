//
//  User.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/19/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import Foundation

struct User {
    
    let uid:String
    let username:String
    let profileImageUrl:String
    let email:String
    
    init(uid:String, dictionary:[String:Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}

