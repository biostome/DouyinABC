//
//  ViewController.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/17.
//

import UIKit
import AVFoundation
import UIKit

class HomeViewController: UIViewController {
    
    var index: Int = 0

    init(index:Int, title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.index = index
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: PageScrollView = {
        let view = PageScrollView(frame: .zero)
        view.dataSource = self
        view.isPagingEnabled = true
        view.contentInsetAdjustmentBehavior = .never
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .black
        
        return view
    }()
    
    var videoURLs = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)

        // Append additional URLs
//
//
//
        guard let video1URL = URL(string: "https://www.w3schools.com/html/movie.mp4"),
              let video2URL = URL(string: "https://media.w3.org/2010/05/sintel/trailer.mp4"),
              let video3URL = URL(string: "https://v-cdn.zjol.com.cn/276982.mp4"),
              let video4URL = URL(string: "https://v-cdn.zjol.com.cn/276984.mp4"),
              let video5URL = URL(string: "https://v-cdn.zjol.com.cn/276985.mp4") else {
            fatalError("Failed to find video URLs")
        }
        videoURLs = [video1URL,video2URL,video3URL,video4URL,video5URL]
        scrollView.reloadData()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let playerView = self.scrollView.currentView as? DouyinVideoView {
            playerView.play()
        }
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .clear
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }else{
            self.navigationController?.navigationBar.barTintColor = .yellow
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let playerView = self.scrollView.currentView as? DouyinVideoView {
            playerView.pause()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
}

extension HomeViewController: PageScrollViewDataSource {
    
    func numberOfViews(in pageScrollView: PageScrollView) -> Int{
        return videoURLs.count
    }
    
    func pageScrollView(_ pageScrollView: PageScrollView, viewForItemAt index: Int) -> UIView {
        let view = DouyinVideoView(frame: view.frame, videoURL: videoURLs[index])
        view.backgroundColor = .black
        return view
    }
    
    func pageScrollView(_ pageScrollView: PageScrollView,view: UIView, didDisplayAt index: Int){
        let playerView = view as? DouyinVideoView
        playerView?.play()
    }
    
    func pageScrollView(_ pageScrollView: PageScrollView, view: UIView, didEndDisplayAt index: Int) {
        let playerView = view as? DouyinVideoView
        playerView?.pause()
        playerView?.pauseImageHidden(hidden: true)
    }
    
    func pageScrollView(_ pageScrollView: PageScrollView, view: UIView, willBeginDraggingAt index: Int) {
        let playerView = view as? DouyinVideoView
        UIView.animate(withDuration: 0.1) {
            playerView?.transparentSubviews(alpha: 0.3)
        }
    }
    
    func pageScrollView(_ pageScrollView: PageScrollView, view: UIView, didEndDraggingAt index: Int) {
        let playerView = view as? DouyinVideoView
        UIView.animate(withDuration: 0.1) {
            playerView?.transparentSubviews(alpha: 1)
        }
    }
    
}
