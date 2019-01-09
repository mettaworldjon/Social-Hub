//
//  FriendController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class FriendController: ContentCollectionController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout, RecentFriendsCellDelegate {

    let friendID = "friendId"
    let friendsHeaderID = "friendHeaderID"
    let recent = "recent"
    
    weak var header:RecentFriendsCell?
    
    let searchBar:UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor("F4F6F6")
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.showsCancelButton = false
        return sb
    }()
    var friendsHardCopy = [User]()
    var friends:[User] = [User]() {
        didSet {
//            let index = IndexPath(item: self.friends.count - 1, section: 1)
//            self.collectionView.insertItems(at: [index])
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
        header?.reload()
        searchBar.isHidden = false
        if RealmDataManager.shared.fetchRealmUsers().count > 0 {
            changeHeight(height: 200)
        } else {
            changeHeight(height: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriends()
        setupUI()
        registerCells()
    }
    
    fileprivate func registerCells() {
        collectionView.register(FriendCell.self, forCellWithReuseIdentifier: friendID)
        collectionView.register(RecentFriendsCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: recent)
        collectionView.register(FriendsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: friendsHeaderID)
    }
    
    fileprivate func setupUI() {
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        navigationController?.navigationBar.addSubview(searchBar)
        guard let navBar = navigationController?.navigationBar else { return }
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: navBar.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -15),
            searchBar.bottomAnchor.constraint(equalTo: navBar.bottomAnchor)
            ])
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        AllPurpose.shared.hideFloaty()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(friendsHardCopy)
        if searchText.isEmpty {
            friends = friendsHardCopy
        } else {
            self.friends = self.friendsHardCopy.filter({ (user) -> Bool in
                return user.username.contains(searchText)
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        AllPurpose.shared.showFloaty()
    }
    
    // Header & Footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            print("Index ====> \(indexPath.section)")
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: recent, for: indexPath) as! RecentFriendsCell
            cell.recentFriendsCellDelegate = self
            self.header = cell
            return cell
        }
        print("Friend Section Start!")
        print("Index ====> \(indexPath.section)")
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: friendsHeaderID, for: indexPath) as! FriendsHeader
        return cell
    }
    
    
    
    // Header
    var headerHeight:Double = 200
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: Double(view.frame.width), height: headerHeight)
        default:
            return CGSize(width: Double(view.frame.width), height: 56)
        }
    }
    func changeHeight(height: Double) {
        self.headerHeight = height
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    // Friends
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 0)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return friends.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: view.frame.width, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendID, for: indexPath) as! FriendCell
        cell.index = indexPath
        cell.user = self.friends[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.isHidden = true
        searchBar.resignFirstResponder()
        createRealmUser(user: self.friends[indexPath.item])
        let destinationProfile = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        destinationProfile.user = self.friends[indexPath.item]
        self.navigationController?.pushViewController(destinationProfile, animated: true)
    }
    
    func createRealmUser(user:User) -> Void {
        let realmUsers = RealmDataManager.shared.fetchRealmUsers()
        var userExist = false
        realmUsers.forEach { (realmUser) in
            if realmUser.giveBackUserModal().uid == user.uid {
                print("Match Found!")
                userExist = true
            }
        }
        if userExist == false {
            print("Attemping to Add User to Realm Database")
            RealmDataManager.shared.insertRealmUser(user: user)
        }
    }
}

extension FriendController {
    func fetchFriends() {
        Database.database().fetchUsers { (User) in
            guard let uid = Auth.auth().currentUser?.uid else { return }
            if User.uid == uid {
                return
            }
            self.friends.append(User)
            self.friendsHardCopy = self.friends
        }
        
    }
}
