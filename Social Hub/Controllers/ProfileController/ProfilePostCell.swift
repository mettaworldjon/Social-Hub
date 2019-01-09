//
//  ProfilePostCell.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/19/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit

class ProfilePostCell: UICollectionViewCell {
    
    var post:Post? {
        didSet {
            guard let safePost = post else { return }
            username.setTitle(safePost.user.username, for: .normal)
            postBody.text = safePost.text
            self.postTime.text = safePost.getDate().timeAgoDisplay()
            self.profileImage.kf.setImage(with: URL(string: safePost.user.profileImageUrl))
        }
    }
    
    
    let profileImage:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 32).isActive = true
        image.widthAnchor.constraint(equalToConstant: 32).isActive = true
        image.layer.cornerRadius = 16
        image.clipsToBounds = true  
        return image
    }()
    
    let username:UIButton = {
        let name = UIButton(type: .system)
        name.setTitle("Jose Spencer", for: .normal)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        name.setTitleColor(UIColor("455154"), for: .normal)
        return name
    }()
    
    let postTime:UILabel = {
        let post = UILabel()
        post.translatesAutoresizingMaskIntoConstraints = false
        post.text = "2 mins ago"
        post.textColor = UIColor("969FA2")
        post.font = .systemFont(ofSize: 12, weight: .regular)
        return post
    }()
    
    
    let menuButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btn.setImage(#imageLiteral(resourceName: "Options").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let bottomBorder:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = UIColor("E7EAEB")
        return view
    }()
    
    
    
    let postBody:VerticalAlignLabel = {
        let post = VerticalAlignLabel()
        post.translatesAutoresizingMaskIntoConstraints = false
        post.text = "Never put off till tomorrow what may be done day after tomorrow just as well."
        post.font = .systemFont(ofSize: 22, weight: .bold)
        post.textColor = UIColor("455154")
        post.numberOfLines = 0
        post.contentMode = .topLeft
        return post
    }()
    
    let likeButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "like-button").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    let commentButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "comment-button").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    let shareButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "share-button").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    let buttonActionStackView:UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 2
        return sv
    }()
    
    let likeStats:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("89.4K likes", for: .normal)
        btn.setTitleColor(UIColor("969FA2"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        return btn
    }()
    let commentStats:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("93 comments", for: .normal)
        btn.setTitleColor(UIColor("969FA2"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        return btn
    }()
    let statsStackView:UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        return sv
    }()
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
        
        self.addSubview(username)
        NSLayoutConstraint.activate([
            username.heightAnchor.constraint(equalTo: profileImage.heightAnchor),
            username.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
            ])
        
        self.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            menuButton.heightAnchor.constraint(equalTo: profileImage.heightAnchor)
            ])
        
        self.addSubview(postTime)
        NSLayoutConstraint.activate([
            postTime.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            postTime.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -10)
            ])
        
        self.addSubview(buttonActionStackView)
        buttonActionStackView.addArrangedSubview(likeButton)
        buttonActionStackView.addArrangedSubview(commentButton)
        buttonActionStackView.addArrangedSubview(shareButton)
        NSLayoutConstraint.activate([
            buttonActionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonActionStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
            ])
        
        self.addSubview(postBody)
        NSLayoutConstraint.activate([
            postBody.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            postBody.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postBody.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            postBody.bottomAnchor.constraint(equalTo: buttonActionStackView.topAnchor, constant: -5)
            ])
        
        self.addSubview(statsStackView)
        statsStackView.addArrangedSubview(likeStats)
        statsStackView.addArrangedSubview(commentStats)
        NSLayoutConstraint.activate([
            statsStackView.centerYAnchor.constraint(equalTo: buttonActionStackView.centerYAnchor),
            statsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
        
        self.addSubview(bottomBorder)
        NSLayoutConstraint.activate([
            bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBorder.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
