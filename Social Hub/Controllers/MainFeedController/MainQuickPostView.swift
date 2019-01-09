//
//  MainFeedStoryController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/24/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Kingfisher
import RSKPlaceholderTextView
import Firebase

protocol MainQuickPostViewDelegate {
    func startedQuickEditing()
    func dismissQuickView()
}

class MainQuickPostView: UICollectionViewCell {
    
    var user:User? {
        didSet {
            guard let userPicURL = user?.profileImageUrl else { return }
            guard let url = URL(string: userPicURL) else { return }
            userPhoto.kf.setImage(with: url)
        }
    }
    
    var delegate:MainQuickPostViewDelegate?
    
    
    
    let userPhoto:UIImageView = {
        let photo = UIImageView(image: #imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal))
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.heightAnchor.constraint(equalToConstant: 32).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 32).isActive = true
        photo.layer.cornerRadius = 16
        photo.clipsToBounds = true
        photo.backgroundColor = UIColor("F4F6F6")
        return photo
    }()
    
    let addPhotoButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "photoButton32px").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btn.backgroundColor = UIColor("F4F6F6")
        return btn
    }()
    
    let videoButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "videoButton32px ").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btn.backgroundColor = UIColor("F4F6F6")
        return btn
    }()
    
    let sendPostButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "send1").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btn.backgroundColor = UIColor("F4F6F6")
        return btn
    }()
    
    let locationButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "locationButton32px").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btn.backgroundColor = UIColor("F4F6F6")
        return btn
    }()
    
    let whatsNewView:RSKPlaceholderTextView = {
        let tv = RSKPlaceholderTextView()
        tv.backgroundColor = UIColor("F4F6F6")
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.placeholder = "What's new, Jonathan?"
        tv.placeholderColor = UIColor("969FA2")
        tv.font = .systemFont(ofSize: 14, weight: .regular)
        tv.returnKeyType = .send
        tv.tintColor = UIColor("59B58D")
        return tv
    }()
    var height:NSLayoutConstraint?
    var stackView:UIStackView?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor("F4F6F6")
        self.addSubview(userPhoto)
        NSLayoutConstraint.activate([
            userPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            userPhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
            ])
        
        sendPostButton.addTarget(self, action: #selector(sendPost), for: .touchUpInside)
        stackView = UIStackView(arrangedSubviews: [sendPostButton,addPhotoButton,locationButton])
        stackView?.spacing = 10
        stackView?.axis = .horizontal
        stackView?.distribution = .equalSpacing
        stackView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView!)
        NSLayoutConstraint.activate([
            (stackView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15))!,
            (stackView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15))!
            ])
        
        whatsNewView.delegate = self
        self.addSubview(whatsNewView)
        height = whatsNewView.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([
            whatsNewView.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 10),
            whatsNewView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            height!,
            whatsNewView.trailingAnchor.constraint(equalTo: (stackView?.leadingAnchor)!, constant: -5),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc func sendPost() {
        if !self.whatsNewView.text.isEmpty {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            guard let user = self.user else { return }
            let post = Post(imageURL: nil, imageHeight: nil, imageWidth: nil, text: whatsNewView.text, creationDate: Date().timeIntervalSince1970, user: user)
            Database.database().uploadPost(uid: uid, post: post) {
                self.whatsNewView.text = ""
                self.delegate?.dismissQuickView()
            }
        }
    }
}

extension MainQuickPostView:UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Started Editing!!")
        AllPurpose.shared.hideFloaty()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        AllPurpose.shared.showFloaty()            
    }
    
}
