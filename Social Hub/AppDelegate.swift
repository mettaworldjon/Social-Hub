//
//  AppDelegate.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase
import Floaty

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentUser:User? {
        didSet {
            mainTabBarController.currentUser = self.currentUser
        }
    }
    var post = [Post]() {
        didSet {
            self.post = mainTabBarController.post
        }
    }
    
    
    let mainTabBarController = MainTabController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        fetchData()
        UITextField.appearance().tintColor = UIColor("59B58D")
        UINavigationBar.appearance().tintColor = UIColor("59B58D")
        UINavigationBar.appearance().barTintColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.95)
        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.95)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor("455154"),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor("455154"),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36, weight: .bold)]
        Floaty.global.button.plusColor = .white
        Floaty.global.button.paddingY = 110
        Floaty.global.button.friendlyTap = false
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if let _ = Auth.auth().currentUser?.uid {
            // Valid User
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.switchToMainViewController()
            self.window?.rootViewController = mainTabBarController
        } else {
            // Throw out!
//            DispatchQueue.main.async {
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.switchToSignUpViewController()
//            }
            self.window?.rootViewController = SignInController()
        }
        return true
    }

    public func switchToMainViewController() {
        self.window?.rootViewController = mainTabBarController
    }
    
    public func switchToMainViewController(user:User) {
        mainTabBarController.currentUser = user
        self.window?.rootViewController = mainTabBarController
    }
    
    public func switchToSignUpViewController() {
        window?.rootViewController = SignInController()
    }

    func fetchData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().fetchSpecificUser(uid: uid) { (user) in
            self.currentUser = user
        }
        
        Database.database().fetchUsers { (User) in
            print(User)
        }
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

