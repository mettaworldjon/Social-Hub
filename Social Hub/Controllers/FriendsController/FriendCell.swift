//
//  FriendCell.swift
//  Social Hub
//
//  Created by Jonathan on 12/28/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Kingfisher

class FriendCell: UICollectionViewCell {
    
    var index:IndexPath? {
        didSet {
            if index?.item == 0 {
                //setupUpTopCell()
                setupDefaultCell()
            } else {
                setupDefaultCell()
            }
        }
    }
    
    var user:User? {
        didSet {
            userName.text = user?.username
            subLabel.text = user?.email
            guard let profileURL = user?.profileImageUrl else { return }
            guard let url = URL(string: profileURL) else { return }
            profileImage.kf.setImage(with: url)
        }
    }
    
    let line = UIView()
    
    let headerTitle = UILabel()
    
    let profileImage:UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Profile"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    let userName:UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Johhny Swift"
        name.font = .systemFont(ofSize: 16, weight: .bold)
        name.textColor = UIColor("455154")
        return name
    }()
    
    let subLabel:UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Johhny Swift"
        name.font = .systemFont(ofSize: 14, weight: .regular)
        name.textColor = UIColor("969FA2")
        return name
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    fileprivate func setupDefaultCell() {
        self.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        userDetails()
    }
    
    fileprivate func userDetails() {
        let stackView = UIStackView(arrangedSubviews: [userName,subLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
            ])
        let rightButton = UIImageView(image: #imageLiteral(resourceName: "right"))
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rightButton)
        NSLayoutConstraint.activate([
            rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            rightButton.heightAnchor.constraint(equalToConstant: 12),
            rightButton.widthAnchor.constraint(equalToConstant: 7.41),
            rightButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
            ])
        
        line.backgroundColor = UIColor(red:0.90, green:0.92, blue:0.92, alpha:1.00)
        line.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(line)
        NSLayoutConstraint.activate([
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.widthAnchor.constraint(equalTo: self.widthAnchor),
            line.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
