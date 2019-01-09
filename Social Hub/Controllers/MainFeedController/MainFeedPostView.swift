//
//  MainFeedPostView.swift
//  Social Hub
//
//  Created by Jonathan on 12/24/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView
import Kingfisher
import Firebase

protocol MainFeedPostViewDelegate {
    func scrollToIndex(myIndex:IndexPath)
    func launchComments(post:Post)
}

class MainFeedPostView: UICollectionViewCell {
    
    var myDelegate:MainFeedPostViewDelegate?
    
    var user:User? {
        didSet {
            guard let user = self.user else { return }
            guard let fullURL = URL(string: user.profileImageUrl) else { return }
            self.urProfileImage.kf.setImage(with: fullURL, for: .normal)
            self.urProfileImage.setImage(self.urProfileImage.imageView?.image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    var post:Post? {
        didSet {
            userName.text = self.post?.user.username
            postBody.text = self.post?.text
            guard let profileImageUrl = post?.user.profileImageUrl else { return }
            guard let fullURL = URL(string: profileImageUrl) else { return }
            imageProfile.kf.setImage(with: fullURL, for: .normal)
            self.timePosted.text = post?.getDate().timeAgoDisplay()
            self.commentCount.setTitle("\(post?.commentCount ?? 0) comments", for: .normal)
            self.likeCount.setTitle("\(post?.likeCount ?? 0) likes", for: .normal)
            self.likeButton.tintColor = (post?.hasLiked == true ? UIColor(red:0.93, green:0.29, blue:0.34, alpha:1.00) : UIColor(red:0.59, green:0.62, blue:0.64, alpha:1.00))
        }
    }
    
    fileprivate func getPost() -> Post {
        if let safePost = self.post {
            return safePost
        } else {
            return Post(user: User(uid: "", dictionary: [:]), dictionary: [:])
        }
    }
    
    fileprivate func getUID() -> String {
        if let uid = Auth.auth().currentUser?.uid {
            return uid
        } else {
            return ""
        }
    }
    
    var myIndex:IndexPath?
    
    let imageProfile:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        btn.setImage(UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let userName:UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 14, weight: .bold)
        name.text = "Loading....."
        name.textColor = UIColor("455154")
        return name
    }()
    
    let timePosted:UILabel = {
        let time = UILabel()
        time.text = "Now"
        time.font = .systemFont(ofSize: 12, weight: .regular)
        time.textColor = UIColor("969FA2")
        return time
    }()
    
    let menuButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "Options").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return btn
    }()
    
    let postBody:UILabel = {
        let body = UILabel()
        body.translatesAutoresizingMaskIntoConstraints = false
        body.text = "When television was young, there was a hugely popular show based on the still popular fictional character of Superman."
        body.font = .systemFont(ofSize: 16, weight: .regular)
        body.textColor = UIColor("455154")
        body.numberOfLines = 0
        return body
    }()
    
    let likeCount:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("516 likes", for: .normal)
        btn.setTitleColor(UIColor("969FA2"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return btn
    }()
    
    lazy var commentCount:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("6 comments", for: .normal)
        btn.setTitleColor(UIColor("969FA2"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        btn.addTarget(self, action: #selector(hanldeComments), for: .touchUpInside)
        return btn
    }()
    @objc func hanldeComments() {
        guard let safePost = post else { return }
        myDelegate?.launchComments(post: safePost)
    }
    
    let sharesCount:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("61 shares", for: .normal)
        btn.setTitleColor(UIColor("969FA2"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return btn
    }()
    
    let middleLine:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = UIColor("E7EAEB")
        return view
    }()
    
    let bottomLine:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        view.backgroundColor = UIColor("F4F6F6")
        return view
    }()
    
    let likeButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Like", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        btn.setTitleColor(UIColor("455154"), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "Love").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor(red:0.93, green:0.29, blue:0.34, alpha:1.00)
        btn.semanticContentAttribute = .forceLeftToRight
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        return btn
    }()
    
    let shareButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Share", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        btn.setTitleColor(UIColor("455154"), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "Share").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.semanticContentAttribute = .forceLeftToRight
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        return btn
    }()
    
    let urProfileImage:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        btn.setImage(UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    
    let commentBox:UIView = {
        let comment = UIView()
        comment.backgroundColor = UIColor("F4F6F6")
        comment.translatesAutoresizingMaskIntoConstraints = false
        comment.heightAnchor.constraint(equalToConstant: 32).isActive = true
        comment.layer.cornerRadius = 6
        return comment
    }()
    
    let comment:RSKPlaceholderTextView = {
        let comment = RSKPlaceholderTextView()
        comment.translatesAutoresizingMaskIntoConstraints = false
        comment.attributedPlaceholder = NSAttributedString(string: "Write a comment...", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)])
        comment.placeholderColor = UIColor("969FA2")
        comment.tintColor = UIColor("59B58D")
        comment.backgroundColor = .clear
        return comment
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        self.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomLine.widthAnchor.constraint(equalTo: self.widthAnchor),
            bottomLine.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        self.addSubview(urProfileImage)
        NSLayoutConstraint.activate([
            urProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            urProfileImage.bottomAnchor.constraint(equalTo: bottomLine.topAnchor, constant: -15)
            ])
        
        self.addSubview(commentBox)
        NSLayoutConstraint.activate([
            commentBox.leadingAnchor.constraint(equalTo: urProfileImage.trailingAnchor, constant: 10),
            commentBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            commentBox.centerYAnchor.constraint(equalTo: urProfileImage.centerYAnchor)
            ])
        
        self.addSubview(comment)
        NSLayoutConstraint.activate([
            comment.centerYAnchor.constraint(equalTo: commentBox.centerYAnchor),
            comment.leadingAnchor.constraint(equalTo: commentBox.leadingAnchor, constant: 10),
            comment.trailingAnchor.constraint(equalTo: commentBox.trailingAnchor),
            comment.heightAnchor.constraint(equalTo: commentBox.heightAnchor)
            ])
        
        self.addSubview(imageProfile)
        NSLayoutConstraint.activate([
            imageProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            imageProfile.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
            ])
        
        let stackView = UIStackView(arrangedSubviews: [userName,timePosted])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor)
            ])
        
        self.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
            ])
        
        self.addSubview(postBody)
        NSLayoutConstraint.activate([
            postBody.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 10),
            postBody.leadingAnchor.constraint(equalTo: imageProfile.leadingAnchor, constant: 0),
            postBody.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
            ])
        
        self.addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(handleLikeButtonPress), for: .touchUpInside)
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: commentBox.topAnchor, constant: 0),
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            likeButton.widthAnchor.constraint(equalToConstant: (self.frame.width - 30) / 2),
            likeButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        self.addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            shareButton.widthAnchor.constraint(equalToConstant: (self.frame.width - 30) / 2),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        self.addSubview(middleLine)
        NSLayoutConstraint.activate([
            middleLine.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: 0),
            middleLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            middleLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
        
        self.addSubview(likeCount)
        NSLayoutConstraint.activate([
            likeCount.leadingAnchor.constraint(equalTo: postBody.leadingAnchor, constant: 0),
            likeCount.bottomAnchor.constraint(equalTo: middleLine.bottomAnchor, constant: -15)
            ])
        
        self.addSubview(sharesCount)
        NSLayoutConstraint.activate([
            sharesCount.trailingAnchor.constraint(equalTo: postBody.trailingAnchor, constant: 0),
            sharesCount.centerYAnchor.constraint(equalTo: likeCount.centerYAnchor)
            ])
        
        self.addSubview(commentCount)
        NSLayoutConstraint.activate([
            commentCount.centerYAnchor.constraint(equalTo: sharesCount.centerYAnchor),
            commentCount.trailingAnchor.constraint(equalTo: sharesCount.leadingAnchor, constant: -15)
            ])
        
        comment.delegate = self
    }
    
}

extension MainFeedPostView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if comment == textView {
            guard let index = self.myIndex else { return }
            myDelegate?.scrollToIndex(myIndex: index)
        }
    }
    
    @objc func handleLikeButtonPress() {
        if getPost().hasLiked == true {
            self.post?.hasLiked = false
            let ref = Database.database().reference().child("post-like").child(getUID()).child(getPost().postID)
            ref.removeValue { (err, finishRef) in
                if let err = err {
                    print("Error found => ", err)
                    return
                }
                let postRef = Database.database().reference().child("post").child(self.getPost().user.uid).child(self.getPost().postID).child("likeCount")
                postRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    guard var num = DataSnapshot.value as? Int else { return }
                    num -= 1
                    postRef.setValue(num, withCompletionBlock: { (err, DatabaseReference) in
                        if let err = err {
                            print("Error found => ", err)
                            return
                        }
                        self.likeCount.setTitle("\(num) likes", for: .normal)
                    })
                }, withCancel: { (Error) in
                    print("Found error => ", Error)
                })
            }
        } else {
            self.post?.hasLiked = true
            let ref = Database.database().reference().child("post-like").child(getUID())
            let value:[String:Any] = [getPost().postID:1]
            ref.updateChildValues(value) { (err, finishRef) in
                if let err = err {
                    print("Error found => ", err)
                    return
                }
                let postRef = Database.database().reference().child("post").child(self.getPost().user.uid).child(self.getPost().postID).child("likeCount")
                postRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    guard var num = DataSnapshot.value as? Int else { return }
                    num += 1
                    postRef.setValue(num, withCompletionBlock: { (err, DatabaseReference) in
                        if let err = err {
                            print("Error found => ", err)
                            return
                        }
                        self.likeCount.setTitle("\(num) likes", for: .normal)
                    })
                }, withCancel: { (Error) in
                    print("Found error => ", Error)
                })
            }
        }
    }
    
    func addOneToCommentCount() {
        guard var count = self.post?.commentCount else { return }
        count += 1
        self.commentCount.setTitle("\(count) comments", for: .normal)
    }
}
