//
//  DouyinAvatarView.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/18.
//

import Foundation
import UIKit

class DouyinAvatarView: UIView {
    
    
    lazy var avatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.setBackgroundImage(UIImage(named: "defaultAvatar"), for: .normal)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(avatarButtonTapped(sender:)), for: .touchUpInside)
         
        return button
    }()
    
    
    lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemPink
        button.layer.cornerRadius = 18/2
        button.layer.masksToBounds = true
        let config = UIImage.SymbolConfiguration(pointSize: 8, weight: .heavy)
        button.setImage(UIImage(systemName: "plus",withConfiguration: config)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(UIImage(systemName: "checkmark",withConfiguration: config)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal), for: .selected)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(followButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    private var followButtonSize = CGSize(width: 18, height: 18)
    
    private var avatarButtonEdge = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
    
    private var isFollowed = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(avatarButton)
        addSubview(followButton)
        
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarButton.leftAnchor.constraint(equalTo: leftAnchor, constant: avatarButtonEdge.left),
            avatarButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -avatarButtonEdge.bottom),
            avatarButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -avatarButtonEdge.right),
            avatarButton.topAnchor.constraint(equalTo: topAnchor, constant: avatarButtonEdge.top)
        ])
        
        followButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            followButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            followButton.widthAnchor.constraint(equalToConstant: followButtonSize.width),
            followButton.heightAnchor.constraint(equalToConstant: followButtonSize.height)
        ])
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarButton.layer.cornerRadius = (bounds.width - 18) / 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func avatarButtonTapped(sender: UIButton) {
    }
    
    @objc func followButtonTapped(sender: UIButton) {
        isFollowed.toggle()
        followButton.isSelected = isFollowed
    }

}
