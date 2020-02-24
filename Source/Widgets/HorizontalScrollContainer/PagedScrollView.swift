//
//  PagedScrollView.swift
//  Example
//
//  Created by woko on 13/02/2020.
//

import Foundation
import UIKit
import SnapKit

open class PagedScrollView: UIScrollView, ScrollViewCustomHorizontalPageSize {
    public var pageSize: CGFloat = 100
    public lazy var contentView: UIView = {
        return UIView()
    }()
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee.x = getTargetContentOffset(scrollView: scrollView, velocity: velocity)
    }
    
    public func clearContent() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    public func initialize() {
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        self.delegate = self
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview().priority(.low)
            $0.height.equalToSuperview()
        }
    }
}
