//
//  GuardDog.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/19/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import Foundation
import Firebase

class GuardDogController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        if let _ = Auth.auth().currentUser?.uid {
            // Valid User
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.switchToMainViewController()
        } else {
            // Throw out!
            DispatchQueue.main.async {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchToSignUpViewController()
            }
            
        }
        
    }
    
}
