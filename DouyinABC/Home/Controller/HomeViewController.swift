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

    lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.dataSource = self
        view.isPagingEnabled = true
        view.delegate = self
        view.register(PlayerCell.self, forCellWithReuseIdentifier: "CELL")
        view.contentInsetAdjustmentBehavior = .never
        view.automaticallyAdjustsScrollIndicatorInsets = false
        return view
    }()
    
    var videoItems = [AVPlayerItem]()
    
    var datas:[Datum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)

        // Append additional URLs

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

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
        
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        if let cell = self.collectionView.cellForItem(at: .init(row: currentIndex, section: 0)) as? PlayerCell {
            cell.videoView.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let cell = self.collectionView.cellForItem(at: .init(row: currentIndex, section: 0)) as? PlayerCell {
            cell.videoView.pause()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func loadData(){
        Task {
            let aweme = await requestData()
            self.datas = aweme?.data ?? []
            self.collectionView.reloadData()
        }
    }
    
    private func requestData() async -> Awemes? {
        guard let path = Bundle.main.path(forResource: "awemes", ofType: "json") else {
            return nil
        }
        do {
            let aweme = try Awemes(fromURL: URL(filePath: path))
            return aweme
        }catch {
            print(error)
        }
        return nil
    }
    
    
    var currentIndex: Int = 0
    var previousIndex: Int = 0
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as? PlayerCell
        cell?.setData(data: self.datas[indexPath.row])
        if indexPath.row == 0 {
            cell?.videoView.play()
        }
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidEndScrollingAnimation(scrollView)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.y / scrollView.frame.height)
        if currentIndex != index && scrollView.subviews.count > 0 {
            previousIndex = currentIndex
            let previousCell = self.collectionView.cellForItem(at: IndexPath(row: previousIndex, section: 0)) as? PlayerCell
            previousCell?.videoView.pause()
            currentIndex = index
            let nextCell = self.collectionView.cellForItem(at: IndexPath(row: currentIndex, section: 0)) as? PlayerCell
            nextCell?.videoView.play()
            nextCell?.videoView.pauseImageView.isHidden = true
        }
    }

}

class PlayerCell: UICollectionViewCell {
    
    lazy var videoView: DouyinVideoView  = {
        let view = DouyinVideoView(frame: self.contentView.frame)
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            videoView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            videoView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            videoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            videoView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(data: Datum) {
        videoView.setData(data: data)
    }
}
