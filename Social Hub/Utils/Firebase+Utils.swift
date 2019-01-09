//
//  Firebase+Utils.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/24/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    
    func getUID() -> String {
        if let uid = Auth.auth().currentUser?.uid {
            return uid
        } else {
            return ""
        }
    }
    
    func fetchSpecificUser(uid:String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            guard let dictionary = DataSnapshot.value as? [String:Any] else { return }
            completion(User(uid: uid, dictionary: dictionary))
        }) { (Error) in
            print("Error Found ", Error)
        }
    }
    
    func fetchUsers(completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").observeSingleEvent(of: .value, with: { (DataSnapshot) in
            guard let dictionary = DataSnapshot.value as? [String:Any] else { return }
            dictionary.forEach({ (key, value) in
                guard let userDict = value as? [String:Any] else { return }
                completion(User(uid: key, dictionary: userDict))
            })
        }) { (Error) in
            print("Error Found ", Error)
        }
    }
    
    
    func fetchPostSocket(uid:String, completion:@escaping (Post) -> ()) {
//        let ref = Database.database().reference().child("post").child(uid)
//        ref.observe(.value, with: { (DataSnapshot) in
//            guard let dictionary = DataSnapshot.value as? [String:Any] else { return }
//            self.fetchSpecificUser(uid: uid, completion: { (User) in
//                dictionary.forEach({ (key, value) in
//                    guard let postDictionary = value as? [String:Any] else { return }
//                    let post = Post(user: User, dictionary: postDictionary)
//                    DispatchQueue.main.async {
//                        completion(post)
//                    }
//                })
//            })
//        }) { (Error) in
//            print("Error found ", Error)
//        }



        let ref = Database.database().reference().child("post").child(uid)
        ref.observe(.childAdded, with: { (DataSnapshot) in
            guard let dict = DataSnapshot.value as? [String:Any] else { return }
            self.fetchSpecificUser(uid: uid) { (User) in
                let post = Post(user: User, dictionary: dict)
                DispatchQueue.main.async {
                    completion(post)
                }
            }
        }) { (Error) in
            print("Error found ", Error)
        }

    }

    func fetchPost(uid:String, completion:@escaping (Post) -> ()) {
        let ref = Database.database().reference().child("post").child(uid)
        ref.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            guard let dictionary = DataSnapshot.value as? [String:Any] else { return }
            self.fetchSpecificUser(uid: uid, completion: { (User) in
                dictionary.forEach({ (key, value) in
                    guard var postDictionary = value as? [String:Any] else { return }
                    postDictionary["postID"] = key
                    var post = Post(user: User, dictionary: postDictionary)
                    self.didLikePost(uid: self.getUID(), postId: post.postID, completion: { (Bool) in
                        DispatchQueue.main.async {
                            post.hasLiked = Bool
                            completion(post)
                        }
                    })
                })
            })
        }) { (Error) in
            print("Error found ", Error)
        }
    }
    
    func didLikePost(uid:String, postId:String, completion:@escaping (Bool) -> ()) {
        let ref = Database.database().reference().child("post-like").child(uid).child(postId)
        ref.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            completion(DataSnapshot.exists())
        }) { (Error) in
            print("Error found ", Error)
        }
    }
    
    func uploadPost(uid:String, post:Post, completion:(() -> ())? = nil) {
        let databaseRef = Database.database().reference().child("post").child(uid)
        print("Upload Data => ", post.toDictionary())
        databaseRef.childByAutoId().updateChildValues(post.toDictionary()) { (Error, DatabaseReference) in
            // Error Check
            if let error = Error { print("Error Found => ", error); return }
            print("Uploaded")
            DispatchQueue.main.async {
                if completion != nil {
                    completion!()
                } else {
                    print("Man idk what just happened....")
                }
            }
        }
    }
    
    func followStatus(currentUserUID:String, user:String, completion:@escaping ((Bool) -> ())) {
        let ref = Database.database().reference().child("following").child(currentUserUID).child(user)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let _ = snapshot.value as? Int {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func followUser(currentUserUID:String, userToFollow:String, completion:((Bool) -> ())? = nil) {
        let ref = Database.database().reference().child("following").child(currentUserUID)
        let value = [userToFollow:1]
        ref.updateChildValues(value) { (err, ref) in
            if let err = err {
                print("Error found -> ", err)
                if let complete = completion {
                    complete(false)
                    return
                }
                return
            }
            if let complete = completion {
                complete(true)
            }
        }
    }
    
    func unfollowUser(currentUserUID:String, userToUnfollow:String, completion:@escaping ((Bool) -> ())) {
        let ref = Database.database().reference().child("following").child(currentUserUID).child(userToUnfollow)
        ref.removeValue { (err, ref) in
            if let err = err {
                print("Error found -> ", err)
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func fetchComments(post:Post, completion:@escaping ((Comment) -> ())) {
        let postServerRef = Database.database().reference().child("post-comments").child(post.user.uid).child(post.postID)
        postServerRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            guard let dictionary = DataSnapshot.value as? [String:Any] else { return }
            dictionary.forEach({ (key, value) in
                guard let comment = value as? [String:Any] else { return }
                guard let uid = comment["uid"] as? String else { return }
                self.fetchSpecificUser(uid: uid, completion: { (User) in
                    let comment = Comment(user: User, dictionary: comment)
                    completion(comment)
                })
            })
        }) { (Error) in
            print("Error found => ", Error)
        }
    }
    
    func sendComment(post:Post, uid:String, textData:String, completion:@escaping ((Post) -> ())) {
        let postServerRef = Database.database().reference().child("post-comments").child(post.user.uid).child(post.postID)
        let value:[String:Any] = [
            "uid" : uid,
            "text" : textData,
            "commentTime": Date().timeIntervalSince1970
        ]
        postServerRef.childByAutoId().updateChildValues(value) { (error, _) in
            if let error = error {
                print("Error found => ", error)
                return
            }
            print("Uploaded")
            let ref = Database.database().reference(fromURL: "\(Database.database().reference().child("post").child(post.user.uid).child(post.postID))/commentCount")
            ref.observeSingleEvent(of: .value, with: { (DataSnapshot) in
                guard var count = DataSnapshot.value as? Int else { return }
                count += 1
                ref.setValue(count)
                completion(post)
            })
        }
    }
}
