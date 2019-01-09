//
//  ProfileController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import Floaty

class ProfileController: ContentCollectionController, FloatyDelegate {
    
    public var user:User? {
        didSet {
            fetchPost()
            collectionView.reloadData()
        }
    }
    
    public var post:[Post] = [Post]() {
        didSet {
        }
    }
    
    let headerID = "headerID"
    let cellID = "cellID"
    
    
    lazy var followShareButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .heavy)
        btn.backgroundColor = UIColor("59B58D")
        btn.layer.cornerRadius = 16
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.addTarget(self, action: #selector(followUnFollowUser), for: .touchUpInside)
        return btn
    }()
    var followShareButtonWidth:NSLayoutConstraint?
    
    let editButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("EDIT", for: .normal)
        btn.setTitleColor(UIColor("59B58D"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
        btn.layer.cornerRadius = 16
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 90).isActive = true
        return btn
    }()
    
    
    private var lastStopScrollPoint:CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        UIView.animate(withDuration: 0.1) {
//            self.navigationController?.navigationBar.alpha = 0
//            self.view.layoutIfNeeded()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleFloatingButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchPost()
        setupUI()
        registerCells()
        self.navigationController?.navigationBar.alpha = 0
    }
    
    func fetchPost() {
        guard let uid = self.user?.uid else { return }
        Database.database().fetchPostSocket(uid: uid) { (post) in
            self.post.insert(post, at: self.post.startIndex)
            self.collectionView.reloadData()
        }
        
    }
    
    @objc func followUnFollowUser() {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        guard let userUID = user?.uid else { return }
        Database.database().followStatus(currentUserUID: currentUID, user: userUID) { (bool) in
            if bool {
                Database.database().unfollowUser(currentUserUID: currentUID, userToUnfollow: userUID, completion: { (bool) in
                    if bool {
                        self.followShareButton.setTitle("FOLLOW", for: .normal)
                    } else {
                        self.followShareButton.setTitle("FOLLOWING", for: .normal)
                    }
                })
            } else {
                Database.database().followUser(currentUserUID: currentUID, userToFollow: userUID) { (bool) in
                    if bool {
                        self.followShareButton.setTitle("FOLLOWING", for: .normal)
                    } else {
                        self.followShareButton.setTitle("FOLLOW", for: .normal)
                    }
                }
            }
        }
    }
    
    fileprivate func registerCells() {
        self.collectionView.register(ProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        self.collectionView.register(ProfilePostCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    fileprivate func setupUI() {
        collectionView.alwaysBounceVertical = true
        setupNav()
    }
    
    fileprivate func setupNav() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        if self.user?.uid != currentUserUID {
            guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
            guard let userUID = user?.uid else { return }
            Database.database().followStatus(currentUserUID: currentUserUID, user: userUID) { (bool) in
                if bool {
                    self.followShareButton.setTitle("UNFOLLOW", for: .normal)
                } else {
                    self.followShareButton.setTitle("FOLLOW", for: .normal)
                }
            }
            followShareButtonWidth = followShareButton.widthAnchor.constraint(equalToConstant: 95)
            followShareButtonWidth?.isActive = true
        } else {
            self.followShareButton.setTitle("SHARE", for: .normal)
            followShareButtonWidth = followShareButton.widthAnchor.constraint(equalToConstant: 90)
            followShareButtonWidth?.isActive = true
        }
        self.title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: followShareButton)
    }
    
    
}

extension ProfileController:UICollectionViewDelegateFlowLayout {
    
    // Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! ProfileHeaderCell
        header.user = self.user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 260)
    }
    
    // Post
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = post[indexPath.item].text
        let suspectedWidth = view.frame.width - 15 - 15
        let size = CGSize(width: suspectedWidth, height: 1000)
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22, weight: .bold)]
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: view.frame.width - 30, height: estimatedFrame.height + 110)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProfilePostCell
        cell.post = post[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
}

// Floating Buttton
extension ProfileController {
    
    func handleFloatingButton() {
        let items = Floaty.global.button.items
        for item in items {
            Floaty.global.button.removeItem(item: item)
        }
        Floaty.global.button.addItem("Post", icon: #imageLiteral(resourceName: "profile-message")) { (FloatyItem) in
            print("New Post")
            let composeController = ComposePostController()
            guard let safeUser = self.user else { return }
            composeController.user = safeUser
            let composeControllerNav = UINavigationController(rootViewController: composeController)
            self.present(composeControllerNav, animated: true)
        }
        Floaty.global.button.buttonColor = UIColor("59B58D")
        Floaty.global.show()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= -88.0 {
            UIView.animate(withDuration: 0.3) {
                Floaty.global.button.alpha = 1
            }
        } else if lastStopScrollPoint > scrollView.contentOffset.y {
            UIView.animate(withDuration: 0.3) {
                Floaty.global.button.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                Floaty.global.button.alpha = 0
            }
        }
        lastStopScrollPoint = scrollView.contentOffset.y
    }
    
}
