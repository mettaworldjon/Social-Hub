//
//  CommentViewController.swift
//  Social Hub
//
//  Created by Jonathan on 1/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView
import Firebase

protocol CommentViewControllerProtocol {
    func reloadPost(post:Post)
}

class CommentViewController: UITableViewController {
    
    var post:Post?
    var comments = [Comment]() {
        didSet {
            tableView.reloadData()
        }
    }
    let textField = RSKPlaceholderTextView()
    var delegate:CommentViewControllerProtocol?
    
    override var canBecomeFirstResponder: Bool { return true }
    
    var inputContainer: UIView!
    var trailingAnchor:NSLayoutConstraint?
    let cellID = "cellID"
    
    
    @objc func handlePhoto() {
        print("Clicked!!!")
    }
    
    @objc func handleSend() {
        guard let post = post else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().sendComment(post: post, uid: uid, textData: textField.text) { (Post) in
            self.delegate?.reloadPost(post: Post)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AllPurpose.shared.hideFloaty()
    }
    
    fileprivate func setupUI() {
        tableView.keyboardDismissMode = .interactive
        tableView.register(ReplyCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        let menu = UIBarButtonItem(image: #imageLiteral(resourceName: "Options"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [menu]
    }
    
    fileprivate func fetchComments() {
        guard let post = post else { return }
        Database.database().fetchComments(post: post) { (comment) in
            DispatchQueue.main.async {
                self.comments.insert(comment, at: 0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchComments()
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 118
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CommentHeader()
        let comment = self.comments[section]
        header.comment = comment
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let line = UIView()
        line.backgroundColor = UIColor("E7EAEB")
        line.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(line)
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: 1),
            line.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            line.widthAnchor.constraint(equalTo: footerView.widthAnchor),
            line.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
            ])
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let text = "Of all of the celestial bodies that capture our attention and fascination as astronomers, none has a greater influence on life on planet Earth than it’s own satellite, the moon."
        let suspectedWidth = (view.frame.width - 121)
        let size = CGSize(width: suspectedWidth, height: 1000)
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)]
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimatedFrame.height + 95
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ReplyCell
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
}

extension CommentViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.2) {
            self.trailingAnchor?.constant = -92
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.1) {
            self.trailingAnchor?.constant = -52
            self.view.layoutIfNeeded()
        }
    }
    
}


class CustomView: UIView {
    
    // this is needed so that the inputAccesoryView is properly sized from the auto layout constraints
    // actual value is not important
    
    override var intrinsicContentSize: CGSize {
        return CGSize.zero
    }
}
