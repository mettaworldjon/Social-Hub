//
//  RecentFriendsCell.swift
//  Social Hub
//
//  Created by Jonathan on 12/28/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit

class FriendsHeader: UICollectionViewCell {
    
    
    let clearButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("", for: .normal)
        btn.setTitleColor(UIColor("59B58D"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        return btn
    }()
    let headerTitle = UILabel()
    
    
    lazy var recentCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let line = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTopSection()
    }
    
   
    
    fileprivate func setupTopSection() {
        self.addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            clearButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
        
        line.backgroundColor = UIColor(red:0.90, green:0.92, blue:0.92, alpha:1.00)
        line.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(line)
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 8),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.widthAnchor.constraint(equalTo: self.widthAnchor),
            line.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        headerTitle.text = "FRIENDS"
        headerTitle.font = UIFont.systemFont(ofSize: 12)
        headerTitle.textColor = UIColor("969FA2")
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerTitle)
        NSLayoutConstraint.activate([
            headerTitle.bottomAnchor.constraint(equalTo: line.topAnchor, constant: -14),
            headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




