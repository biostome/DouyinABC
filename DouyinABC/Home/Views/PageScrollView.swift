//
//  VideoPlayerScrollView.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/18.
//

import Foundation
import UIKit

protocol PageScrollViewDataSource: AnyObject {
    func numberOfViews(in pageScrollView: PageScrollView) -> Int
    func pageScrollView(_ pageScrollView: PageScrollView, viewForItemAt index: Int) -> UIView
    func pageScrollView(_ pageScrollView: PageScrollView, view: UIView, didEndDisplayAt index: Int)
    func pageScrollView(_ pageScrollView: PageScrollView, view: UIView, didDisplayAt index: Int)
    func pageScrollView(_ pageScrollView: PageScrollView, view: UIView, willBeginDraggingAt index: Int)
    func pageScrollView(_ pageScrollView: PageScrollView, view: UIView, didEndDraggingAt index: Int)
}

class PageScrollView: UIScrollView {

    weak var dataSource: PageScrollViewDataSource?

    var currentIndex = 0
    var previousIndex = 0
    
    var currentView:UIView {
        return self.subviews[currentIndex]
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reloadData() {
        guard let dataSource = self.dataSource else { return }

        let numberOfViews = dataSource.numberOfViews(in: self)

        var contentHeight: CGFloat = 0

        for index in 0..<numberOfViews {
            let view = dataSource.pageScrollView(self, viewForItemAt: index)
            view.frame = CGRect(x: 0, y: self.frame.height * CGFloat(index), width: self.frame.width, height: self.frame.height)
            self.addSubview(view)
            contentHeight += view.frame.height
        }

        self.contentSize = CGSize(width: self.frame.width, height: contentHeight)
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let numberOfViews = self.subviews.count
        
        var contentHeight: CGFloat = 0
        
        for index in 0..<numberOfViews {
            let view = self.subviews[index]
            view.frame = CGRect(x: 0, y: self.frame.height * CGFloat(index), width: self.frame.width, height: self.frame.height)
            contentHeight += view.frame.height
        }
        
        self.contentSize = CGSize(width: self.frame.width, height: contentHeight)
    }
}

extension PageScrollView: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidEndScrollingAnimation(scrollView)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.y / self.frame.height)
        if currentIndex != index && self.subviews.count > 0 {
            previousIndex = currentIndex
            dataSource?.pageScrollView(self, view: self.subviews[previousIndex], didEndDisplayAt: previousIndex)
            currentIndex = index
            dataSource?.pageScrollView(self, view: self.subviews[index], didDisplayAt: index)
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.y / self.frame.height)
        targetContentOffset.pointee = CGPoint(x: 0, y: CGFloat(index) * self.frame.height)
        dataSource?.pageScrollView(self, view: self.subviews[index], didEndDraggingAt: index)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dataSource?.pageScrollView(self, view: self.subviews[currentIndex], willBeginDraggingAt: currentIndex)
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }

}


