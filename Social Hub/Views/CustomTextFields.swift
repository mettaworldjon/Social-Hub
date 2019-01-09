//
//  CustomTextFields.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit

class CustomTextFields: UIView {
    
    let textField = UITextField()
    let showPassword = UIButton(type: .system)
    var notShown = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.96, green:0.97, blue:0.96, alpha:1.00)
        self.layer.cornerRadius = 6
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clicked)))
        showPassword.addTarget(self, action: #selector(showOrHide), for: .touchUpInside)
        showPassword.translatesAutoresizingMaskIntoConstraints = false
        showPassword.setImage(#imageLiteral(resourceName: "eye-noshow").withRenderingMode(.alwaysOriginal), for: .normal)
        showPassword.heightAnchor.constraint(equalToConstant: 15).isActive = true
        showPassword.widthAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    convenience init(pasword:Bool) {
        self.init()
        if pasword {
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            self.addSubview(showPassword)
            NSLayoutConstraint.activate([
                showPassword.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                showPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                textField.trailingAnchor.constraint(equalTo: showPassword.leadingAnchor, constant: -5)
                ])
        } else {
            textField.placeholder = "Email"
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        }
    }
    
    @objc func clicked() {
        textField.becomeFirstResponder()
    }
    
    @objc func showOrHide() {
        if !notShown {
            textField.isSecureTextEntry = false
            notShown = true
        } else {
            textField.isSecureTextEntry = true
            notShown = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
