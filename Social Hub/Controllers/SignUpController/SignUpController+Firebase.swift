//
//  SignUpController+Firebase.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase

extension SignUpController {
    
    func createAccount(profileImage:UIImage, fullname:String, email:String, password:String) {
        Auth.auth().createUser(withEmail: email, password: password) { (AuthDataResult, Error) in
            // Error Check
            if let error = Error { print("Found Error => ", error) ; return }
            // Upload Profile Picture
            guard let uid = Auth.auth().currentUser?.uid else { return }
            guard let uploadImageData = profileImage.jpegData(compressionQuality: 0.4) else { return }
            let fileName = NSUUID().uuidString
            let ref = Storage.storage().reference().child("profile-image").child(fileName)
            ref.putData(uploadImageData, metadata: nil, completion: { (StorageMetadata, Error) in
                // Error Check
                if let error = Error { print("Found Error => ", error) ; return }
                ref.downloadURL(completion: { (URL, Error) in
                    // Error Check
                    if let error = Error { print("Found Error => ", error) ; return }
                    var urlFinal = "https://firebasestorage.googleapis.com/v0/b/socialhub8872.appspot.com/o/profile-image%2FC807A064-5605-47EE-BCF7-EDB827CE8C6B?alt=media&token=ea2c0fab-293c-4e7f-a772-603ffbcc9539"
                    if let url = URL { urlFinal = url.absoluteString }
                    // Prepare Final Resting Place
                    let values:[String:Any] = [
                        "username":fullname,
                        "email":email,
                        "profileImageUrl":urlFinal
                    ]
                    Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (Error, DatabaseReference) in
                        // Error Check
                        if let error = Error { print("Found Error => ", error) ; return }
                        DispatchQueue.main.async {
                            print("Successful")
                            self.closeAnimation(user: User(uid: uid, dictionary: values))
                        }
                    })
                })
            })
        }
    }
    
}
