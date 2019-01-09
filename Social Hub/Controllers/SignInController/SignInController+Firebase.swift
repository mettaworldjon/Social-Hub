//
//  SignInController+Firebase.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase

extension SignInController {
    func signInToAccount(email:String, password:String) {
        Auth.auth().signIn(withEmail: email, password: password) { (AuthDataResult, Error) in
            // Error Check
            if let error = Error { print("Found Error => ", error) ; return }
            if let uid = Auth.auth().currentUser?.uid {
                Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    guard let dictionary = DataSnapshot.value as? [String:Any] else { return }
                    self.closeAnimation(user: User(uid: uid, dictionary: dictionary))
                }, withCancel: { (Error) in
                    print("Found error => ", Error)
                })
            }
        }
    }
}
