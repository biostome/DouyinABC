//
//  DouyinVideoView.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/18.
//

import Foundation
import UIKit
import AVKit
import ActiveLabel

protocol DraggableSliderDelegate {
    func draggableSliderTouchesEnded(draggableSlider: DraggableSlider)
}

class DraggableSlider: UISlider {
    
    public var delegate: DraggableSliderDelegate?
    
    private var handleView: UIImageView!
    
    private let handleSize = CGSize(width: 5, height: 13)
    private let handleImage = UIImage(systemName: "circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    private var isDragging = false
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        // 创建把手
        handleView = UIImageView(image: handleImage)
        handleView.frame.size = handleSize
        handleView.contentMode = .scaleAspectFit
        handleView.alpha = 0
        handleView.layer.cornerRadius = 2.5
        handleView.layer.masksToBounds = false
        handleView.backgroundColor = .white
        
        setThumbImage(UIImage(), for: .normal)
        setThumbImage(UIImage(), for: .highlighted)
        addSubview(handleView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        showHandleViewAndEnlargeSlider()
        // 禁用 updateValue(with:) 方法
        isDragging = true
        updateValue(with: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        // 判断是否禁用 updateValue(with:) 方法
        if isDragging {
            updateValue(with: touches)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        hideHandleViewAndShrinkSlider()
        // 启用 updateValue(with:) 方法
        isDragging = false
        delegate?.draggableSliderTouchesEnded(draggableSlider: self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        hideHandleViewAndShrinkSlider()
        // 启用 updateValue(with:) 方法
        isDragging = false
    }
    
    private func showHandleViewAndEnlargeSlider() {
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.3)
            self.handleView.alpha = 1
        }
    }
    
    private func hideHandleViewAndShrinkSlider() {
        UIView.animate(withDuration: 0.4) {
            self.alpha = 0.8
            self.transform = CGAffineTransform.identity
            self.handleView.alpha = 0
        }
    }
    
    private func updateValue(with touches: Set<UITouch>) {
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        let percentage = touchLocation.x / bounds.size.width
        let delta = Float(percentage) * (maximumValue - minimumValue)
        let value = minimumValue + delta
        super.setValue(value, animated: false)
//        setValue(value, animated: false)
    }
    
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        let rect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
        return .init(origin: rect.origin, size: handleSize)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        handleView.center = thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value).origin
    }
    
    override func setValue(_ value: Float, animated: Bool) {
        // this time call super.setValue
        if isDragging {
            return
        }
        super.setValue(value, animated: animated)
    }
}


class VideoView: UIView {
    
    public var playerProgress: DraggableSlider!
    private var player: AVQueuePlayer?
    private var playerLayer: AVPlayerLayer?
    private var playerItem: AVPlayerItem?
    private var videoURL: URL
    
    init(frame: CGRect ,videoURL: URL) {
        self.videoURL = videoURL
        super.init(frame: frame)
        self.playerProgress = DraggableSlider(frame: CGRect(x: 0, y: self.frame.height - 60, width: self.frame.width, height: 30))
        self.playerProgress.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        self.playerProgress?.tintColor = UIColor.white
        self.playerProgress.minimumValue = 0
        self.playerProgress.layer.cornerRadius = 2.5
        self.playerProgress.maximumValue = 1
        self.playerProgress.value = 0.0
//        self.playerProgress.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        self.playerProgress.delegate = self
        self.playerItem = AVPlayerItem(url: self.videoURL)
        self.player = AVQueuePlayer(playerItem: self.playerItem)
        self.player?.actionAtItemEnd = .none
        
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.playerLayer?.frame = self.bounds
        self.layer.addSublayer(self.playerLayer!)
        
        // Add progress bar to view
        self.addSubview(self.playerProgress)
        self.playerProgress.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.playerProgress.leftAnchor.constraint(equalTo: leftAnchor,constant: 6),
            self.playerProgress.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
            self.playerProgress.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -4),
            self.playerProgress.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        // Register for player item did finish playing notification
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        // Update progress bar
        let interval = CMTimeMake(value: 1, timescale: 30)
        self.player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] time in
            guard let self = self else { return }
            self.updateProgressBar(animate: false)
        })
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapView))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.delegate = self
        
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        
        addGestureRecognizer(tapGestureRecognizer)
        addGestureRecognizer(doubleTapGestureRecognizer)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer?.frame = self.bounds
    }
    
    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self)
    }
    
    func play() {
        self.player?.play()
        self.updateProgressBar()
    }
    
    func pause() {
        self.player?.pause()
        self.updateProgressBar()
    }
    
    func stop() {
        self.player?.pause()
    }
    
    func replay(){
        self.playerItem?.seek(to: CMTime.zero, completionHandler: { finish in
            self.updateProgressBar()
        })
    }
    
    @objc internal func playerItemDidFinishPlaying() {
        // Notify delegate that video finished playing
        replay()
    }
    
    @objc func sliderValueChanged(_ sender: DraggableSlider) {
        let progress = sender.value
        let duration = playerItem?.duration.seconds ?? 0.0
        let time = CMTime(seconds: Double(progress) * duration, preferredTimescale: 1000)
        player?.seek(to: time)
    }
    
    
    private func updateProgressBar(animate: Bool = true) {
        let duration = CMTimeGetSeconds(self.playerItem?.duration ?? CMTime.zero)
        if duration.isFinite {
            let currentTime = CMTimeGetSeconds(player?.currentTime() ?? CMTime.zero)
            let progress = Float(currentTime / duration)
//            self.playerProgress.setProgress(progress, animated: animate)
            self.playerProgress.setValue(progress, animated: false)
        }
    }
    
    // Handle single tap gesture
    @objc private func didTapView() {
        // Handle like button tap
        if player?.timeControlStatus == .playing {
            player?.pause()
        } else if player?.timeControlStatus == .paused {
            player?.play()
        }
    }
    
    @objc public func didDoubleTapView(sender: UIGestureRecognizer){
        
    }
}

extension VideoView: DraggableSliderDelegate {
    func draggableSliderTouchesEnded(draggableSlider: DraggableSlider) {
        let progress = draggableSlider.value
        let duration = playerItem?.duration.seconds ?? 0.0
        let time = CMTime(seconds: Double(progress) * duration, preferredTimescale: 1000)
        player?.seek(to: time)
    }
}

extension VideoView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view { // 获取点击的视图
            if touchedView == self { // 判断是否是期望的视图
                return true // 允许手势操作继续执行
            }
        }
        return false // 取消手势操作
    }
}

class DouyinVideoView: VideoView {
    
    private lazy var avatarView: DouyinAvatarView = {
        let view = DouyinAvatarView(frame: .init(origin: .zero, size: .init(width: 50, height: 80)))
        return view
    }()
    
    private lazy var activityView: DouyinActivityView = {
        let view = DouyinActivityView(frame: .zero)
        view.likeButton.addTarget(self, action: #selector(likeButtonTapped(sender: )), for: .touchUpInside)
        view.commentButton.addTarget(self, action: #selector(commentButtonTapped(sender: )), for: .touchUpInside)
        view.collectButton.addTarget(self, action: #selector(collectButtonTapped(sender: )), for: .touchUpInside)
        view.shareButton.addTarget(self, action: #selector(shareButtonTapped(sender: )), for: .touchUpInside)
        return view
    }()
    
    private lazy var infoView: DouyinInfoView = {
        let view = DouyinInfoView()
        return view
    }()
    
    private var isLiked = false
    private var isCollection = false
    private var displayLink: CADisplayLink?
    
    override init(frame: CGRect, videoURL: URL) {
        super.init(frame: frame, videoURL: videoURL)
        
        addSubview(avatarView)
        addSubview(activityView)
        addSubview(infoView)
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            activityView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            activityView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            infoView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            infoView.rightAnchor.constraint(equalTo: rightAnchor, constant: -bounds.width * 0.2),
        ])
        
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.centerXAnchor.constraint(equalTo: activityView.centerXAnchor),
            avatarView.bottomAnchor.constraint(equalTo: activityView.topAnchor, constant: -10),
            avatarView.widthAnchor.constraint(equalToConstant: 60),
            avatarView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // 添加选中文本时的回调
        infoView.contentLabel.handleMentionTap { mention in
            print("Tapped mention: \(mention)")
            let alert = UIAlertController(title: "mention alert", message: mention, preferredStyle: .actionSheet)
            alert.addAction(.init(title: "确定", style: .destructive,handler: { action in
                
            }))
        }
        
        infoView.contentLabel.handleHashtagTap { hashtag in
            print("Tapped hashtag: \(hashtag)")
            let alert = UIAlertController(title: "hashtag alert", message: hashtag, preferredStyle: .actionSheet)
            alert.addAction(.init(title: "确定", style: .destructive,handler: { action in
                
            }))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func likeButtonTapped(sender: UIButton) {
        isLiked.toggle()
        activityView.likeButton.isSelected = isLiked
    }
    
    @objc private func collectButtonTapped(sender: UIButton) {
        isCollection.toggle()
        activityView.collectButton.isSelected = isCollection
    }
    
    @objc private func commentButtonTapped(sender: UIButton) {
        
    }
    
    @objc private func shareButtonTapped(sender: UIButton) {
        
    }
    
    override func didDoubleTapView(sender: UIGestureRecognizer) {
        super.didDoubleTapView(sender: sender)
        isLiked.toggle()
        activityView.likeButton.isSelected = isLiked
    }
    
    func transparentSubviews(alpha: CGFloat){
        self.activityView.alpha = alpha
        self.infoView.alpha = alpha
        self.avatarView.alpha = alpha
        self.playerProgress.alpha = alpha
    }
}
