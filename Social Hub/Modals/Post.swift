//
//  Post.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/22/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit

struct Post {
    
    var user:User
    var postID:String
    var likeCount:Int = 0
    var commentCount:Int = 0
    var hasLiked = false
    let text:String
    let imageURL:String
    let imageHeight:Int
    let imageWidth:Int
    let creationDate:Double
    
    init(user:User, dictionary:[String:Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? "Jon Dow was here!"
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.imageHeight = dictionary["imageHeight"] as? Int ?? 0
        self.imageWidth = dictionary["imageWidth"] as? Int ?? 0
        self.creationDate = dictionary["creationDate"] as? Double ?? 0.0
        self.postID = dictionary["postID"] as? String ?? ""
        self.likeCount = dictionary["likeCount"] as? Int ?? 0
        self.commentCount = dictionary["commentCount"] as? Int ?? 0
    }
    
    init(post:String? = nil, imageURL:String?, imageHeight:Int?, imageWidth:Int?, text:String?, creationDate:Double?, user:User) {
        self.imageURL = imageURL ?? ""
        self.imageHeight = imageHeight ?? 0
        self.imageWidth = imageWidth ?? 0
        self.text = text ?? ""
        self.creationDate = creationDate ?? 0
        self.user = user
        self.postID = ""
    }
    
    func toDictionary() -> [String:Any] {
        return [
            "imageURL":self.imageURL,
            "imageHeight":self.imageHeight,
            "imageWidth":self.imageWidth,
            "text":self.text,
            "creationDate":self.creationDate,
            "username": self.user.username,
            "profileImageUrl":self.user.profileImageUrl,
            "email":self.user.email,
            "likeCount":self.likeCount,
            "commentCount":self.commentCount
        ]
    }
    
    func getDate() -> Date {
        return Date(timeIntervalSince1970: self.creationDate)
    }
    
}
