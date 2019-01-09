//
// Created by Jonathan on 2018-12-22.
// Copyright (c) 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Floaty
import Firebase
import RSKPlaceholderTextView

protocol CompostControllerDelegate {
    func refreshAndInsertPost()
}

class ComposePostController:UIViewController {
    
    var user:User? {
        didSet {
            guard let safeUser = self.user else { return }
            self.usernameLabel.text = safeUser.username
            guard let url = URL(string: safeUser.profileImageUrl) else { return }
            self.profileImage.kf.setImage(with: url)
        }
    }
    
    var composePostDelegate:CompostControllerDelegate?

    let profileImage: UIImageView = {
        let image = UIImageView(image: UIImage(imageLiteralResourceName: "Profile"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 50).isActive = true
        image.heightAnchor.constraint(equalToConstant: 50).isActive = true
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.backgroundColor = .darkGray
        return image
    }()

    let usernameLabel: UILabel = {
        let name = UILabel()
        name.text = "Ellen Sanders"
        name.textColor = UIColor("455154")
        name.font = .systemFont(ofSize: 14, weight: .bold)
        return name
    }()

    let privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "Privacy: "
        label.textColor = UIColor("969FA2")
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    let privacyType: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Public", for: .normal)
        btn.setTitleColor(UIColor("59B58D"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        return btn
    }()

    let whatNewTextView: RSKPlaceholderTextView = {
        let textView = RSKPlaceholderTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = UIColor("455154")
        textView.placeholder = "What's up?"
        textView.font = .systemFont(ofSize: 24, weight: .bold)
        return textView
    }()
    var whatsNewHeight: NSLayoutConstraint?

    func createMedia(image:UIImage) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.frame = CGRect(x: 0, y: 0, width: (view.frame.width / 3) - (15*4), height: 85)
        btn.layer.cornerRadius = 6
        btn.clipsToBounds = true
        return btn
    }

    var addMediaButton: UIButton?
    var tagFriendButton: UIButton?
    var feelingButton: UIButton?
    var cameraButton: UIButton?
    var checkInButton: UIButton?
    var liveVideoButton: UIButton?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Floaty.global.hide()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        controllerDefaults()
        navSetup()
        handleDelegate()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5)
        ])

        let privacyStack = UIStackView(arrangedSubviews: [privacyLabel,privacyType])
        privacyStack.spacing = -4
        let userPostInfoStack: UIStackView = UIStackView(arrangedSubviews: [usernameLabel,privacyStack])
        userPostInfoStack.axis = .vertical
        userPostInfoStack.spacing = -3
        userPostInfoStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userPostInfoStack)
        whatsNewHeight = whatNewTextView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20)
        NSLayoutConstraint.activate([
            userPostInfoStack.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 15),
            userPostInfoStack.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
        ])

        view.addSubview(whatNewTextView)
        NSLayoutConstraint.activate([
            whatNewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            whatsNewHeight!,
            whatNewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            whatNewTextView.heightAnchor.constraint(equalToConstant: 98)
        ])

        let separator = UIView()
        separator.backgroundColor = UIColor("E7EAEB")
        separator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.widthAnchor.constraint(equalTo: view.widthAnchor),
            separator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separator.bottomAnchor.constraint(equalTo: whatNewTextView.bottomAnchor)
        ])

        // First Stack
        addMediaButton = createMedia(image: UIImage(imageLiteralResourceName: "media-button"))
        tagFriendButton = createMedia(image: UIImage(imageLiteralResourceName: "tagfriend-button"))
        feelingButton = createMedia(image: UIImage(imageLiteralResourceName: "camera-button"))
        let mediaStack1 = UIStackView(arrangedSubviews: [addMediaButton!,tagFriendButton!,feelingButton!])
        mediaStack1.distribution = .equalSpacing
        mediaStack1.spacing = 15

        // Second Stack
        cameraButton = createMedia(image: UIImage(imageLiteralResourceName: "camera-button"))
        checkInButton = createMedia(image: UIImage(imageLiteralResourceName: "checkin-button"))
        liveVideoButton = createMedia(image: UIImage(imageLiteralResourceName: "feeling-button"))
        let mediaStack2 = UIStackView(arrangedSubviews: [cameraButton!,checkInButton!,liveVideoButton!])
        mediaStack2.distribution = .equalSpacing
        mediaStack2.spacing = 15

        let mainMediaStack = UIStackView(arrangedSubviews: [mediaStack1,mediaStack2])
        mainMediaStack.axis = .vertical
        mainMediaStack.spacing = 15
        mainMediaStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainMediaStack)
        NSLayoutConstraint.activate([
            mainMediaStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
            mainMediaStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15 ),
            mainMediaStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }

    public func handleDelegate() {
        whatNewTextView.delegate = self
    }

    private func navSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closePost))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Publish", style: .done, target: self, action: #selector(publishPost))
    }

    private func controllerDefaults() {
        view.backgroundColor = .white
        self.title = "Creat Post"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeKeyboard)))
    }

    @objc func removeKeyboard() {
        view.endEditing(true)
    }

    @objc func publishPost() {
        print("Publishing.......")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let safeUser = self.user else { return }
        let post = Post(imageURL: nil, imageHeight: nil, imageWidth: nil, text: whatNewTextView.text, creationDate: Date().timeIntervalSince1970, user: safeUser)
        Database.database().uploadPost(uid: uid, post: post) {
            print("Helloooooo World")
            self.composePostDelegate?.refreshAndInsertPost()
            self.closePost()
        }
    }

    @objc func closePost() {
        print("Closing Post")
        removeKeyboard()
        self.dismiss(animated: true)
    }

}

extension ComposePostController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.whatsNewHeight?.constant = 15
            self.view.layoutIfNeeded()
        }
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.whatsNewHeight?.constant = 20
            self.view.layoutIfNeeded()
        }
    }
}
