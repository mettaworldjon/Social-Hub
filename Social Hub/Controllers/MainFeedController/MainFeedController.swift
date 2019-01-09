//
//  MainFeedController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import Floaty



class MainFeedController: ContentCollectionController {
    
    var currentuser:User? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var post:[Post] = [Post]() {
        didSet {
            
        }
    }
    
    
    let headerID = "headerID"
    let cellID = "cellID"
    let footerID = "footerID"
    var header:MainQuickPostView?
    var firstGo = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        if firstGo {
            self.collectionView.alpha = 0
            firstGo = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.6, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.collectionView.alpha = 1
        }, completion: nil)
        handleFloatingButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        fetchPost()
        setupUI()
        setupNav()
    }
    
    fileprivate func fetchPost() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("following").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard var dictionary = snapshot.value as? [String:Any] else { return }
            dictionary[uid] = 1
            dictionary.forEach({ (key, value) in
                print("[\(key) : \(value)]")
                Database.database().fetchPost(uid: key) { (Post) in
                    self.post.insert(Post, at: 0)
                    self.post.sort(by: { (p1, p2) -> Bool in
                        return p1.getDate().compare(p2.getDate()) == .orderedDescending
                    })
                    self.collectionView.refreshControl?.endRefreshing()
                    self.collectionView.reloadData()
                }
            })
        }) { (error) in
            print("Error Found -> ", error)
        }
    }
    
    
    fileprivate func setupNav() {
        let logo = UIBarButtonItem(image: #imageLiteral(resourceName: "logo24").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        let logoTitle = UIBarButtonItem(title: "Social Hub", style: .plain, target: self, action: nil)
        logoTitle.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold),
            NSAttributedString.Key.foregroundColor : UIColor("455154")
            ], for: .normal)
        let menu = UIBarButtonItem(image: #imageLiteral(resourceName: "Options"), style: .plain, target: self, action: nil)
        let search = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: nil)
        
        self.navigationItem.leftBarButtonItems = [logo, logoTitle]
        self.navigationItem.rightBarButtonItems = [menu, search]
    }
    
    fileprivate func setupUI() {
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.collectionView.refreshControl = refreshControl
        
    }
    
    @objc func handleRefresh() {
        print("refreshing!")
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, animations: {
            self.collectionView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.alpha = 1
                self.view.layoutIfNeeded()
            })
        }
        self.post.removeAll()
        fetchPost()
    }
    
    fileprivate var lastStopScrollPoint:CGFloat = 0
    
    fileprivate func registerCells() {
        self.collectionView.register(MainQuickPostView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        self.collectionView.register(MainFeedPostView.self, forCellWithReuseIdentifier: cellID)
        self.collectionView.register(FooterController.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        

    }
    var height:CGFloat = 65
}

extension MainFeedController:UICollectionViewDelegateFlowLayout {
    
    // Header & Footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! MainQuickPostView
            header.user = self.currentuser
        }
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter , withReuseIdentifier: footerID, for: indexPath) as! FooterController
        return footer
    }
    
    // Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: height)
    }
    
    // Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 260)
    }
    
    // Post
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !post.isEmpty {
            let text = post[indexPath.item].text
            let suspectedWidth = view.frame.width - 15 - 15
            let size = CGSize(width: suspectedWidth, height: 1000)
            let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)]
            let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 245)
        }
        return CGSize(width: view.frame.width, height: 297)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MainFeedPostView
        if !post.isEmpty {
            cell.post = self.post[indexPath.item]
            cell.myDelegate = self
            cell.myIndex = indexPath
            cell.user = self.currentuser
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        print("Lets go!")
        print(indexPath)
    }
    
    
          
}

// Floating Buttton
extension MainFeedController {

    func handleFloatingButton() {
        let items = Floaty.global.button.items
        for item in items {
            Floaty.global.button.removeItem(item: item)
        }
        Floaty.global.button.addItem("Post", icon: #imageLiteral(resourceName: "profile-message")) { (FloatyItem) in
            let composeController = ComposePostController()
            guard let safeUser = self.currentuser else { return }
            composeController.user = safeUser
            let composeControllerNav = UINavigationController(rootViewController: composeController)
            self.present(composeControllerNav, animated: true)
            print("New Post")
        }
        Floaty.global.button.buttonColor = UIColor("59B58D")
        Floaty.global.show()
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        collectionView.collectionViewLayout.invalidateLayout()
        
        if scrollView.contentOffset.y <= -88.0 {
            AllPurpose.shared.showFloaty()
        } else if lastStopScrollPoint > scrollView.contentOffset.y {
            AllPurpose.shared.showFloaty()
        } else {
            AllPurpose.shared.hideFloaty()
        }
        lastStopScrollPoint = scrollView.contentOffset.y
    }

}

extension MainFeedController:MainFeedPostViewDelegate, CommentViewControllerProtocol {
    func reloadPost(post: Post) {
        let cell = self.post.lastIndex {
            $0.postID == post.postID
        }
        guard let cellNum = cell else { return }
        let post = self.collectionView.cellForItem(at: IndexPath(item: cellNum, section: 0)) as! MainFeedPostView
        post.addOneToCommentCount()
        
    }

    
    func launchComments(post: Post) {
        let commentController = CommentViewController()
        commentController.post = post
        commentController.delegate = self
        self.navigationController?.pushViewController(commentController, animated: true)
    }
    
    
    func scrollToIndex(myIndex: IndexPath) {
        collectionView.scrollToItem(at: myIndex, at: .top, animated: true)
    }
}
