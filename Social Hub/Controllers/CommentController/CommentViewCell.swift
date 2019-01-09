//
//  InsideComments.swift
//  Social Hub
//
//  Created by Jonathan on 1/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class InsideComments: UITableViewCell {
    
    let profileImage:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "darkLogo32")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 64),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 14)
            ])
        
        self.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CommentHeader: UIView {
    
    let profileImage:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "darkLogo32")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
