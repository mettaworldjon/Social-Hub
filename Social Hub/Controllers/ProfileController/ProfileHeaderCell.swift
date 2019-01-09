//
//  ProfileHeaderCell.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileHeaderCell: UICollectionViewCell {
    
    var user:User? {
        didSet {
            if user != nil {
                self.name.text = user?.username
            }
            fetchProfilePicture()
        }
    }
    
    let profileButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.layer.cornerRadius = 50
        return btn
    }()
    
    let messageButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "profile-message").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 48).isActive = true
        btn.layer.cornerRadius = 24
        return btn
    }()
    
    let menuButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "profile-menu").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 48).isActive = true
        btn.layer.cornerRadius = 24
        return btn
    }()
    
    let name:UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "  "
        name.font = .systemFont(ofSize: 24, weight: .bold)
        name.textColor = UIColor("455154")
        return name
    }()
    
    let profileDetails:UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "iOS Engineer Swift 4.x and Beyond"
        name.font = .systemFont(ofSize: 14, weight: .regular)
        name.textAlignment = .center
        name.numberOfLines = 0
        name.textColor = UIColor("969FA2")
        return name
    }()
    
    let segments:UISegmentedControl = {
        let bar = UISegmentedControl()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.tintColor = UIColor("59B58D")
        bar.insertSegment(withTitle: "Likes", at: 0, animated: true)
        bar.insertSegment(withTitle: "Photos", at: 0, animated: true)
        bar.insertSegment(withTitle: "Post", at: 0, animated: true)
        bar.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)], for: .normal)
        bar.selectedSegmentIndex = 0
        return bar
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        self.addSubview(profileButton)
        NSLayoutConstraint.activate([
            profileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20)
            ])
        self.addSubview(messageButton)
        NSLayoutConstraint.activate([
            messageButton.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
            messageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50)
            ])
        self.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50)
            ])
        
        self.addSubview(name)
        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            name.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 11)
            ])
        
        self.addSubview(profileDetails)
        NSLayoutConstraint.activate([
            profileDetails.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 6),
            profileDetails.leadingAnchor.constraint(equalTo: messageButton.trailingAnchor, constant: 0),
            profileDetails.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: 0)
            ])
        
        self.addSubview(segments)
        segments.addTarget(self, action: #selector(handleSegments), for: .valueChanged)
        NSLayoutConstraint.activate([
            segments.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            segments.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            segments.topAnchor.constraint(equalTo: profileDetails.bottomAnchor, constant: 30),
            segments.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    func fetchProfilePicture() {
        let url = URL(string: user?.profileImageUrl ?? "")
        let image = UIImageView()
        image.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "Profile"), options: nil) { (result) in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                self.profileButton.setImage(image.image?.withRenderingMode(.alwaysOriginal), for: .normal)
                self.profileButton.layer.cornerRadius = 50
                self.profileButton.clipsToBounds = true
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc func handleSegments() {
        print(segments.selectedSegmentIndex)
    }
}
