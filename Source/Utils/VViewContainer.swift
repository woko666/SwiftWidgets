//
//  VViewContainer.swift
//  Example
//
//  Created by woko on 20/02/2020.
//

import Foundation
import UIKit

open class VViewContainer: UIView {
    public var views: [UIView]  = []
    public var verticalAlignment: VerticalAlignment = .fill
    public var spacing: Float = 0
    
    public var isInitialized = false
    public let contentView = UIView()
   
    open func ensureIsInitialized() {
        guard !isInitialized else { return }
        isInitialized = true
       
        addSubview(contentView)
        switch verticalAlignment {
        case .bottom:
            contentView.snp.makeConstraints {
                $0.left.bottom.right.equalToSuperview()
                $0.top.equalToSuperview().priority(.low)
            }
        case .top:
            contentView.snp.makeConstraints {
                $0.left.top.right.equalToSuperview()
                $0.bottom.equalToSuperview().priority(.low)
            }
        case .fill:
            contentView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case .center:
            contentView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
                $0.centerY.equalToSuperview()
                $0.top.bottom.greaterThanOrEqualToSuperview().priority(.low)
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
                $0.left.right.equalToSuperview()
                if let lastView = lastView {
                    $0.top.equalTo(lastView.snp.bottom).offset(spacing)
                } else {
                    $0.top.equalToSuperview()
                }
            }
            lastView = view
        }
        if let lastView = lastView {
            lastView.snp.makeConstraints {
                $0.bottom.equalToSuperview()
            }
        }
    }
}
