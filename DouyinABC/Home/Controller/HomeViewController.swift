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
    
    var videoItems = [AVPlayerItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)

        // Append additional URLs
//
//

        let URLs:[String] = [
            "https://www.w3schools.com/html/movie.mp4",
            "https://media.w3.org/2010/05/sintel/trailer.mp4",
            "https://v-cdn.zjol.com.cn/276982.mp4",
            "https://v-cdn.zjol.com.cn/276984.mp4",
            "http://vfx.mtime.cn/Video/2021/07/10/mp4/210710171112971120.mp4",
            "http://vfx.mtime.cn/Video/2021/07/10/mp4/210710122716702150.mp4",
            "http://vfx.mtime.cn/Video/2021/07/10/mp4/210710095541348171.mp4",
            "http://vfx.mtime.cn/Video/2021/07/10/mp4/210710094507540173.mp4",
            "http://vfx.mtime.cn/Video/2021/07/09/mp4/210709224656837141.mp4",
            "http://vfx.mtime.cn/Video/2021/07/09/mp4/210709172715355157.mp4",
            "https://sample-videos.com/video123/mkv/720/big_buck_bunny_720p_1mb.mkv",
            "https://sample-videos.com/video123/mkv/720/big_buck_bunny_720p_2mb.mkv",
            "https://sample-videos.com/video123/mkv/720/big_buck_bunny_720p_5mb.mkv",
            "https://sample-videos.com/video123/mkv/720/big_buck_bunny_720p_10mb.mkv",
            "https://sample-videos.com/video123/3gp/144/big_buck_bunny_144p_1mb.3gp",
            "https://sample-videos.com/video123/3gp/144/big_buck_bunny_144p_2mb.3gp",
            "https://sample-videos.com/video123/3gp/144/big_buck_bunny_144p_5mb.3gp",
            "https://sample-videos.com/video123/3gp/144/big_buck_bunny_144p_10mb.3gp",
        ]

        
        videoItems = URLs.compactMap({ str in
            if let u = URL(string: str) {
                return AVPlayerItem(url: u)
            }
            return nil
        })
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
        return videoItems.count
    }
    
    func pageScrollView(_ pageScrollView: PageScrollView, viewForItemAt index: Int) -> UIView {
        let view = DouyinVideoView(frame: view.frame)
        view.backgroundColor = .black
        // init play
        if (index == 0 && (view.player.timeControlStatus == .paused || view.player.timeControlStatus == .none)) {
            view.player.replaceCurrentItem(with: videoItems[index])
            view.play()
        }
        return view
    }
    
    func pageScrollView(_ pageScrollView: PageScrollView,view: UIView, didDisplayAt index: Int){
        let playerView = view as? DouyinVideoView
        if playerView?.player.currentItem != videoItems[index] {
            playerView?.player.replaceCurrentItem(with: videoItems[index])
        }
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
