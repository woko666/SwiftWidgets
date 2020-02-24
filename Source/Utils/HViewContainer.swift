//
//  HViewContainer.swift
//  Example
//
//  Created by woko on 20/02/2020.
//

import Foundation
import UIKit

open class HViewContainer: UIView {
    public var views: [UIView]  = []
    public var horizontalAlignment: HorizontalAlignment = .left
    public var verticalAlignment: VerticalAlignment = .fill
    public var spacing: Float = 0
    
    public var isInitialized = false
    public let contentView = UIView()
    
    open func ensureIsInitialized() {
        guard !isInitialized else { return }
        isInitialized = true
        
        addSubview(contentView)
        switch horizontalAlignment {
        case .left:
            contentView.snp.makeConstraints {
                $0.top.bottom.left.equalToSuperview()
                $0.right.equalToSuperview().priority(.low)
            }
        case .center:
            contentView.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.centerX.equalToSuperview()
            }
        case .right:
            contentView.snp.makeConstraints {
                $0.top.bottom.right.equalToSuperview()
                $0.left.equalToSuperview().priority(.low)
            }
        case .fill:
            contentView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
 
    open func layoutContent() {
        ensureIsInitialized()
        
        var lastView: UIView?
        views.forEach { view in
            view.removeFromSuperview()
            contentView.addSubview(view)
            view.snp.removeConstraints()
            view.snp.makeConstraints {
                switch verticalAlignment {
                case .top:
                    $0.top.equalToSuperview()
                    $0.bottom.lessThanOrEqualToSuperview()
                case .center:
                    $0.top.greaterThanOrEqualToSuperview()
                    $0.bottom.greaterThanOrEqualToSuperview()
                    $0.centerY.equalToSuperview()
                case .bottom:
                    $0.top.greaterThanOrEqualToSuperview()
                    $0.bottom.equalToSuperview()
                case .fill:
                    $0.top.bottom.equalToSuperview()
                }
                //$0.top.bottom.equalToSuperview()
                if let lastView = lastView {
                    $0.left.equalTo(lastView.snp.right).offset(spacing)
                } else {
                    $0.left.equalToSuperview()
                }
            }
            lastView = view
        }
        if let lastView = lastView {
            lastView.snp.makeConstraints {
                $0.right.equalToSuperview()
            }
        }
    }
}
