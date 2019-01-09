//
//  Archives.swift
//  Social Hub
//
//  Created by Jonathan on 12/27/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

//        self.addSubview(imageProfile)
//        NSLayoutConstraint.activate([
//            imageProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
//            imageProfile.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
//            ])
//
//        let stackView = UIStackView(arrangedSubviews: [userName,timePosted])
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        self.addSubview(stackView)
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 10),
//            stackView.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor)
//            ])
//
//        self.addSubview(bottomLine)
//        NSLayoutConstraint.activate([
//            bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            bottomLine.widthAnchor.constraint(equalTo: self.widthAnchor),
//            bottomLine.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//            ])
//
//        self.addSubview(menuButton)
//        NSLayoutConstraint.activate([
//            menuButton.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor),
//            menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
//            ])
//
//        self.addSubview(postBody)
//        NSLayoutConstraint.activate([
//            postBody.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 10),
//            postBody.leadingAnchor.constraint(equalTo: imageProfile.leadingAnchor, constant: 0),
//            postBody.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
//            ])
//
//        self.addSubview(likeCount)
//        NSLayoutConstraint.activate([
//            likeCount.leadingAnchor.constraint(equalTo: postBody.leadingAnchor, constant: 0),
//            likeCount.topAnchor.constraint(equalTo: postBody.bottomAnchor, constant: 15)
//            ])
//
//        self.addSubview(sharesCount)
//        NSLayoutConstraint.activate([
//            sharesCount.trailingAnchor.constraint(equalTo: postBody.trailingAnchor, constant: 0),
//            sharesCount.topAnchor.constraint(equalTo: postBody.bottomAnchor, constant: 15)
//            ])
//
//        self.addSubview(commentCount)
//        NSLayoutConstraint.activate([
//            commentCount.centerYAnchor.constraint(equalTo: sharesCount.centerYAnchor),
//            commentCount.trailingAnchor.constraint(equalTo: sharesCount.leadingAnchor, constant: -15)
//            ])
//
//        self.addSubview(middleLine)
//        NSLayoutConstraint.activate([
//            middleLine.topAnchor.constraint(equalTo: commentCount.bottomAnchor, constant: 15),
//            middleLine.leadingAnchor.constraint(equalTo: likeCount.leadingAnchor),
//            middleLine.trailingAnchor.constraint(equalTo: sharesCount.trailingAnchor)
//            ])
//
//        self.addSubview(likeButton)
//        NSLayoutConstraint.activate([
//            likeButton.topAnchor.constraint(equalTo: middleLine.topAnchor, constant: 0),
//            likeButton.leadingAnchor.constraint(equalTo: middleLine.leadingAnchor, constant: 0),
//            likeButton.widthAnchor.constraint(equalToConstant: (self.frame.width - 30) / 2),
//            likeButton.heightAnchor.constraint(equalToConstant: 50)
//            ])
//
//        self.addSubview(shareButton)
//        NSLayoutConstraint.activate([
//            shareButton.topAnchor.constraint(equalTo: middleLine.topAnchor, constant: 0),
//            shareButton.trailingAnchor.constraint(equalTo: middleLine.trailingAnchor, constant: 0),
//            shareButton.widthAnchor.constraint(equalToConstant: (self.frame.width - 30) / 2),
//            shareButton.heightAnchor.constraint(equalToConstant: 50)
//            ])
//
//        self.addSubview(urProfileImage)
//        NSLayoutConstraint.activate([
//            urProfileImage.leadingAnchor.constraint(equalTo: imageProfile.leadingAnchor, constant: 0),
//            urProfileImage.bottomAnchor.constraint(equalTo: bottomLine.topAnchor, constant: -15)
//            ])
//
//        self.addSubview(commentBox)
//        NSLayoutConstraint.activate([
//            commentBox.leadingAnchor.constraint(equalTo: urProfileImage.trailingAnchor, constant: 10),
//            commentBox.trailingAnchor.constraint(equalTo: menuButton.trailingAnchor),
//            commentBox.centerYAnchor.constraint(equalTo: urProfileImage.centerYAnchor)
//            ])
//
//        self.addSubview(comment)
//        NSLayoutConstraint.activate([
//            comment.centerYAnchor.constraint(equalTo: commentBox.centerYAnchor),
//            comment.leadingAnchor.constraint(equalTo: commentBox.leadingAnchor, constant: 10),
//            comment.trailingAnchor.constraint(equalTo: commentBox.trailingAnchor),
//            comment.heightAnchor.constraint(equalTo: commentBox.heightAnchor)
//            ])
