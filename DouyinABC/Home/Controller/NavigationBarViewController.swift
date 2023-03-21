//
//  NavigationBarViewController.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/21.
//

import Foundation
import Parchment
import UIKit

class NavigationBarPagingView: PagingView {
    override func setupConstraints() {
        constrainToEdges(pageView)
    }
}

class NavigationBarPagingViewController: PagingViewController {
    override func loadView() {
        view = NavigationBarPagingView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view
        )
    }
}

class NavigationBarViewController: UIViewController {
    let pagingViewController = NavigationBarPagingViewController(viewControllers: [
        DiscoverViewController(index: 0, title: "探索"),
        LocalViewController(index: 1, title: "深圳"),
        FoloViewController(index: 2, title: "关注"),
        ShopViewController(index: 3, title: "商城"),
        HomeViewController(index: 4, title: "推荐"),
    ])

    override func viewDidLoad() {
        super.viewDidLoad()

        pagingViewController.borderOptions = .hidden
        pagingViewController.menuBackgroundColor = .clear
        pagingViewController.indicatorColor = UIColor(white: 0, alpha: 0.4)
        pagingViewController.textColor = UIColor(white: 1, alpha: 0.6)
        pagingViewController.selectedTextColor = .white
        pagingViewController.select(index: 4)
        pagingViewController.indicatorColor = .white
        pagingViewController.font = .systemFont(ofSize: 16)
        pagingViewController.selectedFont = .boldSystemFont(ofSize: 16)
        pagingViewController.menuBackgroundColor = .clear
        pagingViewController.menuHorizontalAlignment = .center
        
        
        // Make sure you add the PagingViewController as a child view
        // controller and contrain it to the edges of the view.
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)

        // Set the menu view as the title view on the navigation bar. This
        // will remove the menu view from the view hierachy and put it
        // into the navigation bar.
        navigationItem.titleView = pagingViewController.collectionView
        
        
        let menuIcon = UIImage(systemName: "line.horizontal.3")
        let menuButton = UIBarButtonItem(image: menuIcon, style: .plain, target: self, action: #selector(menuButtonTapped))
        menuButton.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuButton

        let searchIcon = UIImage(systemName: "magnifyingglass")
        let searchButton = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(searchButtonTapped))
        searchButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = searchButton
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationItem.titleView?.frame = CGRect(origin: .zero, size: navigationBar.bounds.size)
        pagingViewController.menuItemSize = .fixed(width: 50, height: navigationBar.bounds.height)
        pagingViewController.menuItemSpacing = 0
        pagingViewController.menuItemLabelSpacing = 0
        pagingViewController.indicatorOptions = .visible(height: 2, zIndex: 0, spacing: .init(top: 0, left: 15, bottom: 0, right: 15), insets: .init(top: 0, left: 0, bottom: 4, right: 0))
        
    }
    
    @objc func menuButtonTapped(){
        let vc = MenuViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.view.backgroundColor = .white
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: true)
    }
    
    @objc func searchButtonTapped(){
        let vc = SearchViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.view.backgroundColor = .white
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: true)
    }
    
}
