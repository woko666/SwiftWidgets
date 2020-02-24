//
//  HorizontalWidgetViewContainer.swift
//  Example
//
//  Created by woko on 19/02/2020.
//

import Foundation
import UIKit

open class HorizontalWidgetViewContainer: UIView, WidgetContainer {
    public var widgets: [Widget]  = []
    public var onHeightUpdated: (() -> Void)?
    public var horizontalAlignment: HorizontalAlignment = .left
    public var verticalAlignment: VerticalAlignment = .fill
    
    public var containerWidth: Float {
        return Float(frame.width)
    }
    
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
 
    open func layoutWidgets() {
        ensureIsInitialized()
        
        var lastWidget: Widget?
        widgets.forEach { widget in
            widget.parentContainer = self
            widget.ensureLoad()
            widget.removeFromSuperview()
            contentView.addSubview(widget)
            widget.snp.removeConstraints()
            widget.snp.makeConstraints {
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
                if let lastWidget = lastWidget {
                    $0.left.equalTo(lastWidget.snp.right)
                } else {
                    $0.left.equalToSuperview()
                }
                if let width = widget.imodel.width {
                    $0.width.equalTo(width)
                }
                if let height = widget.imodel.height {
                    $0.height.equalTo(height)
                }
            }
            lastWidget = widget
        }
        if let lastWidget = lastWidget {
            lastWidget.snp.makeConstraints {
                $0.right.equalToSuperview()
            }
        }
    }
    
    open func removeWidget(_ widget: Widget) {
        if let index = widgets.firstIndex(of: widget) {
            widget.removeFromSuperview()
            widgets.remove(at: index)
            layoutWidgets()
        }
    }
    
    open func widgetHeightUpdated(_ animate: Bool?) {
        onHeightUpdated?()
    }
}
