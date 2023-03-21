//
//  TabbarViewController.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/18.
//

import Foundation
import UIKit
import ESTabBarController_swift

class TabBarViewController: ESTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = UIColor(red: 30/255.0, green: 30/255.0, blue: 30/255.0, alpha: 1)
        tabBar.tintColor = .white
//        tabBar.barTintColor = .red// UIColor(red: 30/255.0, green: 30/255.0, blue: 30/255.0, alpha: 1)
        tabBar.backgroundImage = UIImage()
//        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true


        
        let nav1 = UINavigationController(rootViewController: NavigationBarViewController())

        let v2 = FriendViewController()
        let v3 = UIViewController()
        let v4 = MessageViewController()
        let v5 = MineViewController()
        
        
        nav1.tabBarItem = ESTabBarItem(TextTabBarItem(),title: "首页")
        v2.tabBarItem = ESTabBarItem(TextTabBarItem(),title: "朋友")
        
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        v3.tabBarItem = ESTabBarItem(DouyinTabView(),
                                     title: nil,
                                     image: UIImage(systemName: "plus")?.withConfiguration(config),
                                     selectedImage: UIImage(systemName: "plus")?.withConfiguration(config))
        
        v4.tabBarItem = ESTabBarItem(TextTabBarItem(),title: "消息")
        v5.tabBarItem = ESTabBarItem(TextTabBarItem(),title: "我的")
        
        viewControllers = [nav1, v2, v3, v4, v5]
    }
    
    
}

class TextTabBarItem: ESTabBarItemContentView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.gray
        highlightTextColor = UIColor.white
        titleLabel.font = .systemFont(ofSize: 16)
        imageView.isHidden = true
        image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.center = center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.sizeToFit()
    }
}

class DouyinTabView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title = nil
        titleLabel.isHidden = true
        iconColor = UIColor.white
        highlightIconColor = UIColor.white
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.contentMode = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.font = .systemFont(ofSize: 18)
        imageView.frame = .init(origin: .zero, size: CGSize(width: 42, height: 32))
        imageView.center = center
    }
}
