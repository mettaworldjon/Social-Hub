//
//  CommentViewController+Keyboard.swift
//  Social Hub
//
//  Created by Jonathan on 1/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

extension CommentViewController {
    override var inputAccessoryView: UIView? {
        if inputContainer == nil {
            inputContainer = CustomView()
            inputContainer.backgroundColor = UIColor("F4F6F6")
            
            textField.delegate = self
            textField.layer.cornerRadius = 5
            textField.font = .systemFont(ofSize: 16)
            textField.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
            textField.alignTextVerticallyInContainer()
            textField.placeholder = "Write a comment"
            inputContainer.addSubview(textField)
            inputContainer.autoresizingMask = .flexibleHeight
            textField.translatesAutoresizingMaskIntoConstraints = false
            self.trailingAnchor = textField.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -52)
            NSLayoutConstraint.activate([
                self.trailingAnchor!,
                textField.heightAnchor.constraint(equalToConstant: 44),
                textField.topAnchor.constraint(equalTo: inputContainer.topAnchor,constant: 8),
                textField.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 52),
                textField.bottomAnchor.constraint(equalTo: inputContainer.layoutMarginsGuide.bottomAnchor,constant: -8)
                ])
            let cameraButton = UIButton(type: .system)
            cameraButton.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
            cameraButton.setImage(UIImage(named: "Camera")?.withRenderingMode(.alwaysOriginal), for: .normal)
            cameraButton.translatesAutoresizingMaskIntoConstraints = false
            inputContainer.addSubview(cameraButton)
            NSLayoutConstraint.activate([
                cameraButton.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -14),
                cameraButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
                ])
            let emojiButton = UIButton(type: .system)
            emojiButton.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
            emojiButton.setImage(UIImage(named: "Smile")?.withRenderingMode(.alwaysOriginal), for: .normal)
            emojiButton.translatesAutoresizingMaskIntoConstraints = false
            inputContainer.addSubview(emojiButton)
            NSLayoutConstraint.activate([
                emojiButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 14),
                emojiButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
                ])
            let sendButton = UIButton(type: .system)
            sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
            sendButton.setImage(UIImage(named: "Send-1")?.withRenderingMode(.alwaysOriginal), for: .normal)
            sendButton.translatesAutoresizingMaskIntoConstraints = false
            inputContainer.addSubview(sendButton)
            NSLayoutConstraint.activate([
                sendButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
                sendButton.leadingAnchor.constraint(equalTo: emojiButton.trailingAnchor, constant: 20)
                ])
            
        }
        return inputContainer
    }
}
