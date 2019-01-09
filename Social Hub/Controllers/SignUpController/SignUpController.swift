//
//  SignUpController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import YPImagePicker


class SignUpController: UIViewController {
    
    let userProfileIcon:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return btn
    }()
    
    let cameraIcon:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        btn.setImage(#imageLiteral(resourceName: "cam").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    var heightForKeyboardAdjustments:NSLayoutConstraint?
    var heightForKeyboardAdjustments2:NSLayoutConstraint?
    
    
    let name:CustomTextFields = {
        let name = CustomTextFields(pasword: false)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textField.placeholder = "Name"
        name.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return name
    }()
    
    let email:CustomTextFields = {
        let email = CustomTextFields(pasword: false)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.textField.placeholder = "Email"
        email.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return email
    }()
    
    let password:CustomTextFields = {
        let password = CustomTextFields(pasword: true)
        password.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return password
    }()
    
    let signUpButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.setTitle("Create An Account", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor("59B58D")
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    let termsAndPrivacy:UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.numberOfLines = 0
        let attr = NSMutableAttributedString(attributedString: NSAttributedString(string: "By signing up, you agree to our\n", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular),
            NSAttributedString.Key.foregroundColor : UIColor("969FA2")
            ]))
        attr.append(NSAttributedString(string: "Terms", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold),
            NSAttributedString.Key.foregroundColor : UIColor("59B58D")
            ]))
        attr.append(NSAttributedString(attributedString: NSAttributedString(string: " and ", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular),
            NSAttributedString.Key.foregroundColor : UIColor("969FA2")
            ])))
        attr.append(NSAttributedString(string: "Privacy", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold),
            NSAttributedString.Key.foregroundColor : UIColor("59B58D")
            ]))
        text.attributedText = attr
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stopEditing)))
        handleNavBar()
        handleDelegates()
        view.addSubview(userProfileIcon)
        view.addSubview(cameraIcon)
        userProfileIcon.addTarget(self, action: #selector(launchImagePicker), for: .touchUpInside)
        heightForKeyboardAdjustments = userProfileIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        NSLayoutConstraint.activate([
            userProfileIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraIcon.bottomAnchor.constraint(equalTo: userProfileIcon.bottomAnchor),
            cameraIcon.trailingAnchor.constraint(equalTo: userProfileIcon.trailingAnchor),
            heightForKeyboardAdjustments!
            ])
        let sv = UIStackView(arrangedSubviews: [name,email,password])
        sv.axis = .vertical
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sv)
        heightForKeyboardAdjustments2 = sv.topAnchor.constraint(equalTo: userProfileIcon.bottomAnchor, constant: 50)
        NSLayoutConstraint.activate([
            sv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightForKeyboardAdjustments2!,
            sv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            ])
        let sv2 = UIStackView(arrangedSubviews: [signUpButton,termsAndPrivacy])
        signUpButton.addTarget(self, action: #selector(attemptSignUp), for: .touchUpInside)
        sv2.translatesAutoresizingMaskIntoConstraints = false
        sv2.spacing = 20
        sv2.axis = .vertical
        view.addSubview(sv2)
        NSLayoutConstraint.activate([
            sv2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sv2.leadingAnchor.constraint(equalTo: sv.leadingAnchor),
            sv2.trailingAnchor.constraint(equalTo: sv.trailingAnchor),
            sv2.topAnchor.constraint(equalTo: sv.bottomAnchor, constant: 20)
            ])
    }
    
    @objc func launchImagePicker() {
        // Image Picker Config
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.startOnScreen = .library
        config.showsCrop = .rectangle(ratio: 1)
        config.shouldSaveNewPicturesToAlbum = false
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancel in
            if cancel {
                picker.dismiss(animated: true, completion: nil)
            }
            if let photo = items.singlePhoto {
                print("Got Photo?")
                print("Here You Go")
                DispatchQueue.main.async {
                    self.userProfileIcon.setImage(photo.image.withRenderingMode(.alwaysOriginal), for: .normal)
                    self.userProfileIcon.layer.cornerRadius = 50
                    self.userProfileIcon.clipsToBounds = true
                    picker.dismiss(animated: true, completion: nil)
                }
            }
        }
        present(picker, animated: true, completion: nil)
    }
    
    @objc fileprivate func attemptSignUp() {
        guard let image = self.userProfileIcon.imageView?.image else { return }
        guard let name = self.name.textField.text else { return }
        guard let email = self.email.textField.text else { return }
        guard let password = self.password.textField.text else { return }
        let validEmail = Validation.shared.isValidEmail(testStr: email)
        let validPassword = Validation.shared.validPassword(pwd: password)
        if validEmail && validPassword {
            print("Signing In")
            self.createAccount(profileImage: image, fullname: name, email: email, password: password)
        }
    }
    
    fileprivate func handleDelegates() {
        name.textField.delegate = self
        email.textField.delegate = self
        password.textField.delegate = self
    }
    
    fileprivate func handleNavBar() {
        self.title = "Sign Up"
        let cancel = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeView))
        let rightSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: #selector(closeView))
        self.navigationItem.rightBarButtonItems = [rightSpace,cancel]
    }
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func closeAnimation(user:User) {
        view.endEditing(true)
        UIView.animate(withDuration: 0.8, animations: {
            self.navigationController?.navigationBar.alpha = 0
            self.userProfileIcon.alpha = 0
            self.name.alpha = 0
            self.email.alpha = 0
            self.password.alpha = 0
            self.signUpButton.alpha = 0
            self.termsAndPrivacy.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.switchToMainViewController(user: user)
        }
    }
    
    @objc func stopEditing() {
        view.endEditing(true)
    }
    
}

extension SignUpController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.heightForKeyboardAdjustments?.constant = 10
            self.heightForKeyboardAdjustments2?.constant = 40
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.heightForKeyboardAdjustments?.constant = 50
            self.heightForKeyboardAdjustments2?.constant = 50
            self.view.layoutIfNeeded()
        }
    }
}

