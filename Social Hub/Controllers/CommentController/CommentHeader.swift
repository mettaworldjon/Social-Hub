//
//  CommentHeader.swift
//  Social Hub
//
//  Created by Jonathan on 1/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class CommentHeader: UIView {
    
    var comment: Comment? {
        didSet {
            self.postReply.text = comment?.text
            self.userName.setTitle(comment?.user.username, for: .normal)
            self.timeLabel.text = comment?.getDate().timeAgoDisplay()
            guard let profileUrl = comment?.user.profileImageUrl else { return }
            guard let fullURL = URL(string: profileUrl) else { return }
            self.profileImage.kf.setImage(with: fullURL)
        }
    }

    
    let profileImage:UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named: "darkLogo32")?.withRenderingMode(.alwaysOriginal)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return button
    }()
    
    let userName:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor("455154"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return button
    }()
    
    let menu:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Options")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return button
    }()
    
    let postReply:UILabel = {
        let body = UILabel()
        body.translatesAutoresizingMaskIntoConstraints = false
        body.font = .systemFont(ofSize: 16)
        body.textColor = UIColor("455154")
        body.text = ""
        return body
    }()
    
    let timeLabel:UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.text = "45 min ago"
        time.font = .systemFont(ofSize: 12, weight: .regular)
        time.textColor = UIColor("969FA2")
        return time
    }()
    
    let likeCount:UILabel = {
        let like = UILabel()
        like.translatesAutoresizingMaskIntoConstraints = false
        like.text = "4 likes"
        like.font = .systemFont(ofSize: 14, weight: .regular)
        like.textColor = UIColor("969FA2")
        return like
    }()
    
    let replyCount:UILabel = {
        let like = UILabel()
        like.translatesAutoresizingMaskIntoConstraints = false
        like.text = "34 replies"
        like.font = .systemFont(ofSize: 14, weight: .regular)
        like.textColor = UIColor("969FA2")
        return like
    }()
    
    let likeButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Like", for: .normal)
        btn.setTitleColor(UIColor("59B58D"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    let replyButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Reply", for: .normal)
        btn.setTitleColor(UIColor("59B58D"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 14)
            ])
        
        self.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
            ])
        
        self.addSubview(menu)
        NSLayoutConstraint.activate([
            menu.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            menu.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
            ])
        
        self.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: menu.leadingAnchor, constant: -10)
            ])
        
        self.addSubview(likeCount)
        NSLayoutConstraint.activate([
            likeCount.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: 0),
            likeCount.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
            ])
        
        self.addSubview(replyCount)
        NSLayoutConstraint.activate([
            replyCount.centerYAnchor.constraint(equalTo: likeCount.centerYAnchor),
            replyCount.leadingAnchor.constraint(equalTo: likeCount.trailingAnchor, constant: 10)
            ])
        
        self.addSubview(postReply)
        NSLayoutConstraint.activate([
            postReply.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: 0),
            postReply.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            postReply.trailingAnchor.constraint(equalTo: menu.trailingAnchor, constant: 0)
            ])
        
        self.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.centerYAnchor.constraint(equalTo: likeCount.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: menu.trailingAnchor)
            ])
        
        self.addSubview(replyButton)
        NSLayoutConstraint.activate([
            replyButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            replyButton.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -10)
            ])
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

