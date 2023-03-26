//
//  MusicAlbumView.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/21.
//

import Foundation
import UIKit
import SDWebImage

class MusicAlbumView: UIView {
    
    lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.bounds
        imageView.image = UIImage(named: "album")
        imageView.layer.name = "albumLayer"
        
        let rotaAnim = CABasicAnimation()
        rotaAnim.keyPath = "transform.rotation.z"
        rotaAnim.toValue = Double.pi * 2
        rotaAnim.duration = 3
        rotaAnim.isCumulative = true
        rotaAnim.repeatCount = Float.infinity
        
        imageView.layer.add(rotaAnim, forKey: "rotationAnimation")
        
        return imageView
    }()
    
    lazy var airplaneContainerLayer: CALayer = {
        let layer = CALayer()
        return layer
    }()
    
    private lazy var animateGroup: [CAShapeLayer]  = {
        let airplanes = ["airplane1","airplane2","airplane2"]
        let delayTimes = [0.0, 1.0, 2.0]
        let anim: [CAShapeLayer] = zip(airplanes, delayTimes).map { (name, delay) in
            let group = CAAnimationGroup()
            group.duration = 3
            group.beginTime = CACurrentMediaTime() + delay
            group.repeatCount = Float.infinity
            group.isRemovedOnCompletion = false
            group.fillMode = .forwards
            group.timingFunction = .init(name: .linear)
            
            let sideX = 40.0
            let sideY = 100.0
            let controlLength = 30.0
            let positionAnim = CAKeyframeAnimation(keyPath: "position")
            let begin = CGPoint(x: self.bounds.midX, y: self.bounds.maxY)
            let end = CGPoint(x: -begin.x - sideX, y: begin.y - sideY)
            let controlPoint = CGPoint(x: begin.x - sideX / 2.0 - controlLength, y: begin.y - sideY / 2 + controlLength)
            
            let bezierPath = UIBezierPath()
            bezierPath.move(to: begin)
            bezierPath.addQuadCurve(to: end, controlPoint: controlPoint)
            positionAnim.path = bezierPath.cgPath
            
            let rotationAnim = CAKeyframeAnimation(keyPath: "transform.rotation")
            rotationAnim.values = [0, Double.pi * 0.1, Double.pi * -0.1]
            
            let opacityAnim = CAKeyframeAnimation(keyPath: "opacity")
            opacityAnim.values = [0, 0.2, 0.7, 0.2, 0]
            
            let scaleAnim = CABasicAnimation()
            scaleAnim.keyPath = "transform.scale"
            scaleAnim.fromValue = 1
            scaleAnim.toValue = 2
            
            group.animations = [positionAnim, rotationAnim, scaleAnim, opacityAnim]
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.opacity = 0
            shapeLayer.contents = UIImage(named: name)?.cgImage
            shapeLayer.frame = .init(x: begin.x, y: begin.y, width: 10, height: 10)
            shapeLayer.add(group, forKey: nil)
            return shapeLayer
        }
        return anim
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(self.airplaneContainerLayer)
        self.layer.addSublayer(self.albumImageView.layer)
        self.startAnimations()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.albumImageView.frame = self.bounds
        self.airplaneContainerLayer.frame = self.bounds
    }
    
    public func startAnimations(){
        self.animateGroup.forEach { shapeLayer in
            self.airplaneContainerLayer.addSublayer(shapeLayer)
        }
        
    }
    

}
