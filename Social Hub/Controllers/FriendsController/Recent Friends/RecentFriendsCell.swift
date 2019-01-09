//
//  RecentFriendsCell.swift
//  Social Hub
//
//  Created by Jonathan on 12/28/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit

protocol RecentFriendsCellDelegate {
    func changeHeight(height:Double)
}

class RecentFriendsCell: UICollectionViewCell {
    
    var recentFriendsCellDelegate:RecentFriendsCellDelegate?
    
    var users = [User]() {
        didSet {
            self.recentCollection.reloadData()
        }
    }
    
    let clearButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Clear History", for: .normal)
        btn.setTitleColor(UIColor("59B58D"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        return btn
    }()
    let headerTitle = UILabel()
    let cellID = "cell"
    
    
    lazy var recentCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let line = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTopSection()
        setupCollectionView()
        clearButton.addTarget(self, action: #selector(clearHistory), for: .touchUpInside)
        fetchRecentUsers()
        print(RealmDataManager.shared.fetchRealmUsers())
    }
    
    func reload() {
        self.users.removeAll()
        fetchRecentUsers()
        recentCollection.reloadData()
        if self.users.count > 0 {
            recentFriendsCellDelegate?.changeHeight(height: 202)
        }
    }
    
    func fetchRecentUsers() {
        let users = RealmDataManager.shared.fetchRealmUsers()
        users.forEach { (RealmUser) in
            self.users.append(RealmUser.giveBackUserModal())
        }
    }
    
    @objc func clearHistory() {
        recentFriendsCellDelegate?.changeHeight(height: 0)
        RealmDataManager.shared.deleteUsers()
    }
    
    fileprivate func setupTopSection() {
        self.addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            clearButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
        
        line.backgroundColor = UIColor(red:0.90, green:0.92, blue:0.92, alpha:1.00)
        line.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(line)
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 8),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.widthAnchor.constraint(equalTo: self.widthAnchor),
            line.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        headerTitle.text = "RECENTS"
        headerTitle.font = UIFont.systemFont(ofSize: 12)
        headerTitle.textColor = UIColor("969FA2")
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerTitle)
        NSLayoutConstraint.activate([
            headerTitle.bottomAnchor.constraint(equalTo: line.topAnchor, constant: -14),
            headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension RecentFriendsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 15, right: 0)
    }
    
    func setupCollectionView() {
        recentCollection.clipsToBounds = true
        recentCollection.backgroundColor = .white
        recentCollection.register(UserCells.self, forCellWithReuseIdentifier: cellID)
        self.addSubview(recentCollection)
        NSLayoutConstraint.activate([
            recentCollection.topAnchor.constraint(equalTo: line.bottomAnchor),
            recentCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            recentCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            recentCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 116)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! UserCells
        cell.user = self.users[indexPath.item]
        return cell
    }
    
    
}
