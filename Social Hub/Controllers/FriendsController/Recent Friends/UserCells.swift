//
//  RecentFriendCollectionCell.swift
//  Social Hub
//
//  Created by Jonathan on 12/28/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Kingfisher

class UserCells: UICollectionViewCell {
    
    var user:User? {
        didSet {
            self.userName.text = self.user?.username
            guard let profileUrlString = self.user?.profileImageUrl else { return }
            guard let url = URL(string: profileUrlString) else { return }
            profile.kf.setImage(with: url)
        }
    }
    
    
    let profile:UIImageView = {
        let iv = UIImageView(image: UIImage(named:"profile70px"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iv.layer.cornerRadius = 35
        iv.clipsToBounds = true
        return iv
    }()
    
    let userName:UILabel = {
        let name = UILabel()
        name.text = "Johhny Swift"
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 14, weight: .bold)
        name.textColor = UIColor("455154")
        name.textAlignment = .center
        name.numberOfLines = 0
        name.sizeToFit()
        return name
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.addSubview(profile)
        NSLayoutConstraint.activate([
            profile.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profile.topAnchor.constraint(equalTo: self.topAnchor)
            ])
        
        self.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 10),
            userName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userName.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            userName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
