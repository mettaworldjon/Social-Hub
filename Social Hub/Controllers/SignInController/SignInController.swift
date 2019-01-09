//
//  SignInController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit

class SignInController: UIViewController {
    
    let welcomeTitle:UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.text = "Welcome\nto Social Hub"
        title.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        title.textColor = UIColor("455154")
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let subTitle:UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.textColor = UIColor("455154")
        title.text = "Where the Internet Comes to Talk \nAbout Things"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let logo:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Fill 427 Copy")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return image
    }()
    
    let email:CustomTextFields = {
        let textfield = CustomTextFields(pasword: false)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textfield.textField.returnKeyType = .continue
        return textfield
    }()
    var stackViewPosition:NSLayoutConstraint?
    var forgotViewPoistion:NSLayoutConstraint?
    
    
    let password:CustomTextFields = {
        let textfield = CustomTextFields(pasword: true)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return textfield
    }()
    
    let loginButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor("59B58D")
        btn.layer.cornerRadius = 6
        return btn
    }()

    let forgotPwd:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Forgot Password", for: .normal)
        btn.setTitleColor(UIColor("59B58D"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return btn
    }()

    let signUpButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(handleSignUpLaunch), for: .touchUpInside)
        btn.layer.cornerRadius = 6
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.setTitleColor(UIColor("455154"), for: .normal)
        btn.backgroundColor = UIColor("F4F6F6")
        btn.contentHorizontalAlignment = .left
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        let arrow = UIImageView(image: #imageLiteral(resourceName: "email"))
        arrow.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(arrow)
        NSLayoutConstraint.activate([
            arrow.heightAnchor.constraint(equalToConstant: 16),
            arrow.widthAnchor.constraint(equalToConstant: 20),
            arrow.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -15)
            ])
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stopEditing)))
        
        view.backgroundColor = .white
        view.addSubview(welcomeTitle)
        NSLayoutConstraint.activate([
            welcomeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            welcomeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
            ])
        
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logo.topAnchor.constraint(equalTo: welcomeTitle.topAnchor, constant: 0)
            ])
        
        view.addSubview(subTitle)
        NSLayoutConstraint.activate([
            subTitle.leadingAnchor.constraint(equalTo: welcomeTitle.leadingAnchor),
            subTitle.topAnchor.constraint(equalTo: welcomeTitle.bottomAnchor, constant: 15)
            ])
        
        let sv = UIStackView(arrangedSubviews: [email,password])
        sv.axis = .vertical
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewPosition = sv.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 74)
        view.addSubview(sv)
        NSLayoutConstraint.activate([
            sv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.stackViewPosition!
            ])
        
        loginButton.addTarget(self, action: #selector(attemptLogin), for: .touchUpInside)
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: sv.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: sv.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: sv.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: sv.trailingAnchor)
            ])
        
        view.addSubview(forgotPwd)
        self.forgotViewPoistion = forgotPwd.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30)
        NSLayoutConstraint.activate([
            forgotPwd.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            forgotViewPoistion!
            ])
        
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
        
        
    }

    func setDelegates() {
        email.textField.delegate = self
        password.textField.delegate = self
    }
    
    @objc func stopEditing() {
        view.endEditing(true)
    }
    
    @objc func handleSignUpLaunch() {
        let signUp = SignUpController()
        let nav = UINavigationController(rootViewController: signUp)
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func attemptLogin() {
        guard let email = email.textField.text else { return }
        guard let password = password.textField.text else { return }
        let validEmail = Validation.shared.isValidEmail(testStr: email)
        let validPassword = Validation.shared.validPassword(pwd: password)
        
        if validEmail && validPassword {
            self.signInToAccount(email: email, password: password)
        }
        
    }
    
    func closeAnimation(user:User) {
        view.endEditing(true)
        UIView.animate(withDuration: 0.9, animations: {
            self.navigationController?.navigationBar.alpha = 0
            self.welcomeTitle.alpha = 0
            self.subTitle.alpha = 0
            self.logo.alpha = 0
            self.email.alpha = 0
            self.password.alpha = 0
            self.loginButton.alpha = 0
            self.forgotPwd.alpha = 0
            self.signUpButton.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.switchToMainViewController(user: user)
        }
    }

}

extension SignInController:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.stackViewPosition?.constant = 34
            self.forgotViewPoistion?.constant = 20
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.stackViewPosition?.constant = 74
            self.forgotViewPoistion?.constant = 30
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email.textField {
            password.textField.becomeFirstResponder()
        }
        return true
    }
    
}

