//
//  WidgetViewController.swift
//  Example
//
//  Created by woko on 07/02/2020.
//

import Foundation
import UIKit

open class VerticalWidgetViewContainer: UIView, WidgetContainer {
    public var widgets: [Widget]  = []
    public var onHeightUpdated: (() -> Void)?
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
                $0.left.right.equalToSuperview()
                if let lastWidget = lastWidget {
                    $0.top.equalTo(lastWidget.snp.bottom)
                } else {
                    $0.top.equalToSuperview()
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
                $0.bottom.equalToSuperview()
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
