//
//  ReplyCell.swift
//  Social Hub
//
//  Created by Jonathan on 1/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class ReplyCell: UITableViewCell {
    
    let profileImage:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "light32px")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
        button.setTitle("Julia Harris", for: .normal)
        button.setTitleColor(UIColor("455154"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return button
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
        like.font = .systemFont(ofSize: 12, weight: .regular)
        like.textColor = UIColor("969FA2")
        return like
    }()
    
    let replyBody:UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = UIColor("969FA2")
        text.font = .systemFont(ofSize: 14)
        text.numberOfLines = 0
        text.text = "Of all of the celestial bodies that capture our attention and fascination as astronomers, none has a greater influence on life on planet Earth than it’s own satellite, the moon."
        return text
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let container = UIView()
        container.backgroundColor = UIColor("F4F6F6")
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 12
        self.addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 54),
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
        container.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 64),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
            ])
        
        container.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
            ])
        
        self.addSubview(likeCount)
        NSLayoutConstraint.activate([
            likeCount.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            likeCount.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 5)
            ])
        
        self.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: likeCount.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: likeCount.trailingAnchor, constant: 10)
            ])
        
        self.addSubview(replyBody)
        NSLayoutConstraint.activate([
            replyBody.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            replyBody.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 1.5),
            replyBody.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
