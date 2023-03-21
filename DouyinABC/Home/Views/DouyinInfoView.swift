//
//  DouyinInfoView.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/18.
//

import Foundation
import UIKit
import ActiveLabel


class DouyinInfoView: UIView {
    
    var originContent: String = ""
    
    var isExpandContent: Bool = false
    
    var expandText = " 展开"
    
    var collapseText = " 收起"
    
    lazy var authorNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("@ABC", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    lazy var contentLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.textColor = .init(white: 1, alpha: 0.9)
        label.lineBreakMode = .byTruncatingMiddle
        label.isUserInteractionEnabled = true
        
        label.customize { label in
            label.enabledTypes = [.mention, .hashtag, .custom(pattern: "展开"),.custom(pattern: "收起")]
            label.configureLinkAttribute = { (type, attributes, isSelected) in
                var atts = attributes
                switch type {
                case .mention:
                    atts[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: label.font.pointSize)
                    atts[NSAttributedString.Key.foregroundColor] = UIColor.white
                case .hashtag:
                    atts[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: label.font.pointSize)
                    atts[NSAttributedString.Key.foregroundColor] = UIColor.white
                case .custom(pattern: "展开"):
                    atts[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: label.font.pointSize)
                    atts[NSAttributedString.Key.foregroundColor] = UIColor.white
                case .custom(pattern: "收起"):
                    atts[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: label.font.pointSize)
                    atts[NSAttributedString.Key.foregroundColor] = UIColor.white
                default:
                    atts[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: label.font.pointSize)
                    atts[NSAttributedString.Key.foregroundColor] = UIColor.white
                }
                return atts
            }
        }
        
        label.handleCustomTap(for: .custom(pattern: "展开")) { pattern in
            print("Tapped hashtag: \(pattern)")
            self.isExpandContent.toggle()
            self.contentLabel.text = self.originContent + (self.isExpandContent ? self.collapseText:self.expandText)
            self.contentLabel.numberOfLines = self.isExpandContent ? 0 : 2
        }
        label.handleCustomTap(for: .custom(pattern: "收起")) { pattern in
            print("Tapped hashtag: \(pattern)")
            self.isExpandContent.toggle()
            self.contentLabel.text = self.originContent + (self.isExpandContent ? self.collapseText:self.expandText)
            self.contentLabel.numberOfLines = self.isExpandContent ? 0 : 2
        }
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "•3月8日"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .gray
        return label
    }()
    
    private var expandContent = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(authorNameButton)
        addSubview(contentLabel)
        addSubview(dateLabel)
        
        authorNameButton.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            authorNameButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            authorNameButton.topAnchor.constraint(equalTo: topAnchor),
            authorNameButton.bottomAnchor.constraint(equalTo: contentLabel.topAnchor),
            
            dateLabel.centerYAnchor.constraint(equalTo: authorNameButton.centerYAnchor),
            dateLabel.leftAnchor.constraint(equalTo: authorNameButton.rightAnchor, constant: 5),
            dateLabel.rightAnchor.constraint(greaterThanOrEqualTo: rightAnchor, constant: 5)
        ])
        
        let text = "This is a text with @mentions and #hashtags.This is a text with @mentions and #hashtags.This is a text with @mentions and #hashtags.This is a text with @mentions and #hashtags.This is a text with @mentions and #hashtags.This is a text with @mentions and #hashtags.This is a text with @mentions and #hashtags.This is a text with @mentions and #hashtags. "
        originContent = text
        contentLabel.text = originContent + (isExpandContent ? collapseText:expandText)
        contentLabel.numberOfLines = isExpandContent ? 0 : 2
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
//        contentLabel.addGestureRecognizer(tapGesture)
//        contentLabel.isUserInteractionEnabled = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
