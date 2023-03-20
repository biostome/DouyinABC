//
//  DouyinControlView.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/18.
//

import Foundation
import UIKit


class DouyinActivityView: UIView {
    
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "heart", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config)?.withTintColor(.systemPink, renderingMode: .alwaysOriginal), for: .selected)
        button.backgroundColor = UIColor.clear
        button.tintColor = UIColor.clear
        return button
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "bubble.left", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "square.and.arrow.up", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var collectButton: UIButton = {
        let button = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: config)?.withTintColor(.systemPink, renderingMode: .alwaysOriginal), for: .selected)
        button.backgroundColor = UIColor.clear
        button.tintColor = UIColor.clear
        button.sizeToFit()
        return button
    }()
    
    lazy var likeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.textColor = .white
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 12)
        return lb
    }()

    lazy var commentLabel: UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.textColor = .white
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 12)
        return lb
    }()

    lazy var shareLabel: UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.textColor = .white
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 12)
        return lb
    }()

    lazy var collectLabel: UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.textColor = .white
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 12)
        return lb
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let likeStack = UIStackView(arrangedSubviews: [likeButton, likeLabel])
        likeStack.axis = .vertical
        likeStack.spacing = 2
        
        let commentStack = UIStackView(arrangedSubviews: [commentButton, commentLabel])
        commentStack.axis = .vertical
        commentStack.spacing = 2
        
        let collectStack = UIStackView(arrangedSubviews: [collectButton, collectLabel])
        collectStack.axis = .vertical
        collectStack.spacing = 2
        
        let shareStack = UIStackView(arrangedSubviews: [shareButton, shareLabel])
        shareStack.axis = .vertical
        shareStack.spacing = 2
        
        
        let buttonStack = UIStackView(arrangedSubviews: [likeStack, commentStack, collectStack, shareStack])
        buttonStack.axis = .vertical
        buttonStack.spacing = 20
        addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor),
//            buttonStack.widthAnchor.constraint(equalToConstant: 40)
            buttonStack.leftAnchor.constraint(equalTo: leftAnchor),
            buttonStack.topAnchor.constraint(equalTo: topAnchor),
        ])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    func configure(with video: DouyinVideo) {
//        avatarView.image = video.authorAvatar
//        likeButton.isSelected = video.isLiked
//        collectButton.isSelected = video.isCollected
//        infoView.configure(with: video)
//    }
    
}
