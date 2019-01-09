//
//  MainFeedController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit

class ContentCollectionController: UICollectionViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor("455154")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor("969FA2")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
//        self.navigationController?.navigationBar.isTranslucent
//        let statusBarView = UIView(frame: CGRect(x:0, y:0, width:view.frame.size.width, height: UIApplication.shared.statusBarFrame.height))
//        statusBarView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.95)
//        view.addSubview(statusBarView)
    }
}
