//
//  MusicTitleBar.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/23.
//

import Foundation
import UIKit
import MarqueeLabel

class MusicTitleBar: UIView {
    
    
    lazy var greenGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.green.cgColor, UIColor.white.withAlphaComponent(0.5).cgColor]
        layer.startPoint = .zero
        layer.endPoint = .init(x: 0.8, y: 0.8)
        layer.type = .radial
        layer.opacity = 0.3
        return layer
    }()
    
    lazy var yellowGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.yellow.cgColor, UIColor.white.withAlphaComponent(0.5).cgColor]
        layer.startPoint = .init(x: 0, y: 1)
        layer.endPoint = .init(x: 0.8, y: 0.2)
        layer.type = .radial
        layer.opacity = 0.3
        return layer
    }()
    
    lazy var preButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("去汽水听>", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 12)
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
        return btn
    }()
    
    lazy var marqueeLabel: MarqueeLabel = {
        let carouselView = MarqueeLabel(frame: .init(x: 0, y: 0, width: 100, height: 40))
        carouselView.backgroundColor = .clear
        
        // Continuous Type
        
        return carouselView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(preButton)
        addSubview(marqueeLabel)
        preButton.layer.insertSublayer(greenGradientLayer, at: 0)
        preButton.layer.insertSublayer(yellowGradientLayer, at: 0)
        
        preButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preButton.leftAnchor.constraint(equalTo: leftAnchor),
            preButton.topAnchor.constraint(equalTo: topAnchor),
            preButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            preButton.widthAnchor.constraint(equalToConstant: 65),
        ])
        
        marqueeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            marqueeLabel.rightAnchor.constraint(equalTo: rightAnchor),
            marqueeLabel.leftAnchor.constraint(equalTo: preButton.rightAnchor),
            marqueeLabel.topAnchor.constraint(equalTo: topAnchor),
            marqueeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        marqueeLabel.type = .continuous
        marqueeLabel.fadeLength = 0
        marqueeLabel.leadingBuffer = 40
        marqueeLabel.trailingBuffer = 40
        marqueeLabel.text = "坏女孩 （Cover徐良）    坏女孩 （Cover徐良）    坏女孩 （Cover徐良）"
        marqueeLabel.textColor = .white
        marqueeLabel.font = UIFont.systemFont(ofSize: 14.0)
        marqueeLabel.backgroundColor = .clear
        marqueeLabel.animationCurve = .linear
        marqueeLabel.animationDelay = .zero
        marqueeLabel.speed = .duration(20)
        
        marqueeLabel.restartLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.preButton.frame = .init(x: 0, y: 0, width: 65, height: self.bounds.height)
        self.greenGradientLayer.frame = preButton.bounds
        self.yellowGradientLayer.frame = preButton.bounds
        self.marqueeLabel.frame = .init(x: self.preButton.frame.width, y: 0, width: self.bounds.width - 65, height: self.bounds.height)
    }
    
    
}
