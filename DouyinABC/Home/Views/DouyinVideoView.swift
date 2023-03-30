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
import SDWebImage


class VerticalButton: UIButton {
    
    let imageTopMargin = 0.0
    let textTopMargin = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Adjust image position
        let imageSize = imageView?.frame.size ?? CGSize.zero
        let imageY = (bounds.size.height - imageSize.height - titleLabel!.frame.size.height - imageTopMargin - textTopMargin) / 2.0
        let imageX = (bounds.size.width - imageSize.width) / 2.0
        imageView?.frame = CGRect(x: imageX, y: imageY, width: imageSize.width, height: imageSize.height)

        // Adjust title position
        let titleSize = titleLabel?.frame.size ?? CGSize.zero
        let titleY = imageY + imageSize.height + imageTopMargin + textTopMargin
        let titleX = (bounds.size.width - titleSize.width) / 2.0
        titleLabel?.frame = CGRect(x: 0, y: titleY, width: self.bounds.size.width, height: titleSize.height)


    }

    override var intrinsicContentSize: CGSize{
        return .init(width: CGFloat.maximum(self.imageView?.frame.width ?? 0, self.titleLabel?.frame.width ?? 0), height: (self.imageView?.frame.height ?? 0) + (self.titleLabel?.frame.height ?? 0))
    }
    
}


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

class DouyinPlayerView: UIView {
    
    public lazy var playerProgress: DraggableSlider = {
        let progress = DraggableSlider(frame: CGRect(x: 0, y: self.frame.height - 60, width: self.frame.width, height: 30))
        progress.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        progress.tintColor = UIColor.white
        progress.minimumValue = 0
        progress.layer.cornerRadius = 2.5
        progress.maximumValue = 1
        progress.value = 0.0
        progress.delegate = self
        return progress
    }()
    public lazy var pauseImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName:"play.fill"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.tintColor = .white
        view.alpha = 0.3
        view.isHidden = true
        return view
    }()
    
    public lazy var tapGestureRecognizer = {
        let ges = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        ges.numberOfTapsRequired = 1
        ges.delegate = self
        return ges
    }()
    
    lazy var player: AVQueuePlayer = AVQueuePlayer(playerItem: nil)
    
    lazy var playerLayer: AVPlayerLayer = AVPlayerLayer()
    
    lazy var converImageView: UIImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        self.player.actionAtItemEnd = .none
        self.playerLayer.frame = self.bounds
        self.playerLayer.player = self.player
        self.playerLayer.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(self.playerLayer)
        
        
        // Add progress bar to view
        self.converImageView.frame = self.bounds
        self.converImageView.contentMode = .scaleAspectFill
        self.addSubview(self.converImageView)
        
        
        self.addSubview(pauseImageView)
        NSLayoutConstraint.activate([
            self.pauseImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            self.pauseImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.pauseImageView.widthAnchor.constraint(equalToConstant: 80),
            self.pauseImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
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
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] time in
            guard let self = self else { return }
            self.updateProgressBar(animate: false)
        })
        
        addGestureRecognizer(tapGestureRecognizer)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer.frame = self.bounds
    }
    
    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self)
    }
    
    func play() {
        if (player.timeControlStatus == .paused || player.timeControlStatus == .none) {
            self.player.play()
        }
        self.updateProgressBar()
    }
    
    func pause() {
        self.player.pause()
        self.updateProgressBar()
    }
    
    func stop() {
        self.player.pause()
        self.updateProgressBar()
    }
    
    func replay(){
        self.player.currentItem?.seek(to: CMTime.zero, completionHandler: { finish in
            self.updateProgressBar()
        })
    }
    
    @objc func playerItemDidFinishPlaying() {
        // Notify delegate that video finished playing
        replay()
    }
    
    @objc func sliderValueChanged(_ sender: DraggableSlider) {
        let progress = sender.value
        let duration = self.player.currentItem?.duration.seconds ?? 0.0
        let time = CMTime(seconds: Double(progress) * duration, preferredTimescale: 1000)
        player.seek(to: time)
    }
    
    
    private func updateProgressBar(animate: Bool = true) {
        let duration = CMTimeGetSeconds(self.player.currentItem?.duration ?? CMTime.zero)
        if duration.isFinite {
            let currentTime = CMTimeGetSeconds(self.player.currentItem?.currentTime() ?? .zero)
            let progress = Float(currentTime / duration)
//            self.playerProgress.setProgress(progress, animated: animate)
            self.playerProgress.setValue(progress, animated: false)
        }
    }
    
    // Handle single tap gesture
    @objc private func didTapView() {
        // Handle like button tap
        if self.player.timeControlStatus == .playing {
            self.pause()
            self.pauseImageView.isHidden = false
        } else if self.player.timeControlStatus == .paused {
            self.play()
            self.pauseImageView.isHidden = true
        }
    }
}

extension DouyinPlayerView: DraggableSliderDelegate {
    func draggableSliderTouchesEnded(draggableSlider: DraggableSlider) {
        let progress = draggableSlider.value
        let duration = self.player.currentItem?.duration.seconds ?? 0.0
        let time = CMTime(seconds: Double(progress) * duration, preferredTimescale: 1000)
        self.player.seek(to: time)
    }
}

extension DouyinPlayerView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view { // 获取点击的视图
            if touchedView == self { // 判断是否是期望的视图
                return true // 允许手势操作继续执行
            }
        }
        return false // 取消手势操作
    }
}

class DouyinVideoView: DouyinPlayerView {
    
    lazy var avatarView: DouyinAvatarView = {
        let view = DouyinAvatarView(frame: .init(origin: .zero, size: .init(width: 50, height: 80)))
        return view
    }()
    
    lazy var authorView: DouyinInfoView = {
        let view = DouyinInfoView()
        return view
    }()
    
    lazy var musicAlbumView: MusicAlbumView = {
        let view = MusicAlbumView(frame: .zero)
        return view
    }()
    
    lazy var musicTitleBar: MusicTitleBar = {
        let view = MusicTitleBar(frame: .zero)
        return view
    }()
    
    
    public lazy var likeButton: VerticalButton = {
        let button = VerticalButton(frame: .zero)
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config)?.withTintColor(.systemPink, renderingMode: .alwaysOriginal), for: .selected)
        button.backgroundColor = UIColor.clear
        button.tintColor = UIColor.clear
        button.setTitle("0", for: .normal)
        button.addTarget(self, action: #selector(likeButtonTapped(sender: )), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.sizeToFit()
        return button
    }()
    
    public lazy var commentButton: VerticalButton = {
        let button = VerticalButton(frame: .zero)
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        button.setImage(UIImage(systemName: "ellipsis.message.fill", withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: "ellipsis.message.fill", withConfiguration: config)?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal), for: .selected)
        button.tintColor = .white
        button.setTitle("0", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.sizeToFit()
        button.addTarget(self, action: #selector(commentButtonTapped(sender: )), for: .touchUpInside)
        return button
    }()
    
    public lazy var collectButton: VerticalButton = {
        let button = VerticalButton(frame: .zero)
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        button.setImage(UIImage(systemName: "star.fill", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(UIImage(systemName: "star.fill", withConfiguration: config)?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal), for: .selected)
        button.backgroundColor = UIColor.clear
        button.tintColor = UIColor.clear
        button.setTitle("0", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(collectButtonTapped(sender: )), for: .touchUpInside)
        button.sizeToFit()
        return button
    }()
    
    public lazy var shareButton: VerticalButton = {
        let button = VerticalButton(frame: .zero)
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(shareButtonTapped(sender: )), for: .touchUpInside)
        button.setTitle("0", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.tintColor = .white
        button.sizeToFit()
        return button
    }()

    public lazy var infoViewStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private var isLiked = false
    private var isCollection = false
    private var displayLink: CADisplayLink?
    private var playerStatusObserver: NSKeyValueObservation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(avatarView)
        addSubview(musicAlbumView)
        addSubview(infoViewStack)
        
        infoViewStack.addArrangedSubview(authorView)
        infoViewStack.addArrangedSubview(musicTitleBar)
        
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(collectButton)
        addSubview(shareButton)
        
        
        musicTitleBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicTitleBar.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        infoViewStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoViewStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            infoViewStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            infoViewStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -bounds.width * 0.2),
        ])
        
        musicAlbumView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicAlbumView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            musicAlbumView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            musicAlbumView.widthAnchor.constraint(equalToConstant: 40),
            musicAlbumView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.bottomAnchor.constraint(equalTo: musicAlbumView.topAnchor, constant: -15),
            shareButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            shareButton.widthAnchor.constraint(equalToConstant: 40),
            shareButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        collectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectButton.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -15),
            collectButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            collectButton.widthAnchor.constraint(equalToConstant: 40),
            collectButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentButton.bottomAnchor.constraint(equalTo: collectButton.topAnchor, constant: -15),
            commentButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            commentButton.widthAnchor.constraint(equalToConstant: 40),
            commentButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: commentButton.topAnchor, constant: -15),
            likeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.centerXAnchor.constraint(equalTo: likeButton.centerXAnchor),
            avatarView.bottomAnchor.constraint(equalTo: likeButton.topAnchor, constant: -15),
            avatarView.widthAnchor.constraint(equalToConstant: 60),
            avatarView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
        // 添加选中文本时的回调
        authorView.contentLabel.handleMentionTap { mention in
            print("Tapped mention: \(mention)")
            let alert = UIAlertController(title: "mention alert", message: mention, preferredStyle: .actionSheet)
            alert.addAction(.init(title: "确定", style: .destructive,handler: { action in
                
            }))
        }
        
        authorView.contentLabel.handleHashtagTap { hashtag in
            print("Tapped hashtag: \(hashtag)")
            let alert = UIAlertController(title: "hashtag alert", message: hashtag, preferredStyle: .actionSheet)
            alert.addAction(.init(title: "确定", style: .destructive,handler: { action in
                
            }))
        }
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapView))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.delegate = self
        
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        
        addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func likeButtonTapped(sender: UIButton) {
        isLiked.toggle()
        likeButton.isSelected = isLiked
    }
    
    @objc private func collectButtonTapped(sender: UIButton) {
        isCollection.toggle()
        collectButton.isSelected = isCollection
    }
    
    @objc private func commentButtonTapped(sender: UIButton) {
        
    }
    
    @objc private func shareButtonTapped(sender: UIButton) {
        
    }
    
    @objc func didDoubleTapView(sender: UIGestureRecognizer) {
        isLiked.toggle()
        likeButton.isSelected = isLiked
    }
    
    func transparentSubviews(alpha: CGFloat){
        self.shareButton.alpha = alpha
        self.collectButton.alpha = alpha
        self.commentButton.alpha = alpha
        self.likeButton.alpha = alpha
        self.authorView.alpha = alpha
        self.avatarView.alpha = alpha
        self.playerProgress.alpha = alpha
        self.musicTitleBar.alpha = alpha
        self.musicAlbumView.alpha = alpha
    }

    
    private var data: Datum?
    
    func setData(data: Datum) {
        self.authorView.authorText = "@" + (data.author?.nickname ?? "")
        self.authorView.descText = data.desc
        
        var marqueels:[String] = []
        for _ in 0...3 {
            let dat = "\(data.music?.title ?? "")  (\(data.music?.author ?? ""))"
            marqueels.append(dat)
        }
        self.musicTitleBar.marqueeLabel.text = marqueels.joined(separator: "     ")
        
        let diggCount = data.statistics?.diggCount?.chineseStyleFormattedString()
        let commentCount = data.statistics?.commentCount?.chineseStyleFormattedString()
        let shareCount = data.statistics?.shareCount?.chineseStyleFormattedString()
        let collectText = data.statistics?.collectCount?.chineseStyleFormattedString()
        self.likeText = diggCount ?? "0"
        self.commentText = commentCount ?? "0"
        self.shareText = shareCount ?? "0"
        self.collectText = collectText ?? "0"
        
        if let createTime = data.createTime {
            let time = Date(timeIntervalSince1970: Double(createTime))
            let fmt = DateFormatter()
            fmt.dateFormat = "MM月dd日"
            self.authorView.dateText = fmt.string(from: time)
            
        }
        
        self.player.replaceCurrentItem(with: data.video?.playerItems?.first)
    }
    
    var shareText: String? {
        set{
            self.shareButton.setTitle(newValue, for: .normal)
            self.shareButton.sizeToFit()
        }
        get{
            self.shareButton.currentTitle
        }
    }
    
    var likeText: String? {
        set{
            self.likeButton.setTitle(newValue, for: .normal)
            self.likeButton.sizeToFit()
        }
        get{
            self.likeButton.currentTitle
        }
    }
    
    var commentText: String? {
        set {
            self.commentButton.setTitle(newValue, for: .normal)
            self.commentButton.sizeToFit()
        }
        get{
            self.commentButton.currentTitle
        }
    }
    
    var collectText: String? {
        set {
            self.collectButton.setTitle(newValue, for: .normal)
            self.collectButton.sizeToFit()
        }
        get{
            self.collectButton.currentTitle
        }
    }
}

extension Int {
    func chineseStyleFormattedString() -> String {
        if self >= 10000 {
            return "\(self / 10000)" + "万"
        } else {
            return "\(self)"
        }
    }
}
