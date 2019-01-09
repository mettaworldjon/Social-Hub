//
//  Comment.swift
//  Social Hub
//
//  Created by Jonathan on 1/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import Foundation

struct Comment {
    let user:User
    let text:String
    let commentTime:Double
    
    
    init(user:User, dictionary:[String:Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.commentTime = dictionary["commentTime"] as? Double ?? 0
    }
    
    func getDate() -> Date {
        return Date(timeIntervalSince1970: self.commentTime)
    }
    
}
