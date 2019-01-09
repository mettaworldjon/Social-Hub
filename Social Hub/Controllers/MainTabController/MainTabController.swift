//
//  MainTabController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    var currentUser:User? {
        didSet {
            mainFeedController.currentuser = self.currentUser
            profileController.user = self.currentUser
        }
    }
    
    var post:[Post] = [Post]() {
        didSet {
            self.post = mainFeedController.post
            print("Hello")
        }
    }
    

    let mainFeedController = MainFeedController(collectionViewLayout: UICollectionViewFlowLayout())
    let profileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBar.barTintColor = UIColor(red:0.96, green:0.97, blue:0.96, alpha:1.00)
        
        let mainFeed = UINavigationController(rootViewController: mainFeedController)
        mainFeed.tabBarItem.selectedImage = #imageLiteral(resourceName: "main-feed-icon")
        mainFeed.tabBarItem.image = #imageLiteral(resourceName: "main-icon")
        mainFeed.tabBarItem.title = "Feed"
        
        let friends = UINavigationController(rootViewController: FriendController(collectionViewLayout: UICollectionViewFlowLayout()))
        friends.view.backgroundColor = .gray
        friends.tabBarItem.selectedImage = #imageLiteral(resourceName: "friend-selected")
        friends.tabBarItem.image = #imageLiteral(resourceName: "friends")
        friends.tabBarItem.title = "Friends"
        
        let messages = UINavigationController(rootViewController: MessageController(collectionViewLayout: UICollectionViewFlowLayout()))
        messages.tabBarItem.selectedImage = #imageLiteral(resourceName: "message-selected")
        messages.tabBarItem.image = #imageLiteral(resourceName: "message-unselected")
        messages.tabBarItem.title = "Messages"
        
        let activity = UINavigationController(rootViewController: ActivityController(collectionViewLayout: UICollectionViewFlowLayout()))
        activity.tabBarItem.selectedImage = #imageLiteral(resourceName: "activity-selected")
        activity.tabBarItem.image = #imageLiteral(resourceName: "activity-unselected")
        activity.tabBarItem.title = "Activities"
        
        
        let profile = UINavigationController(rootViewController: profileController)
        profile.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile-selected")
        profile.tabBarItem.image = #imageLiteral(resourceName: "profile-unselected")
        profile.tabBarItem.title = "Profile"        
        
        self.viewControllers = [mainFeed,friends,messages,activity,profile]
    
        
    }
    
    
    
    
}
