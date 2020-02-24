//
//  HorizontalScrollContainerWidget.swift
//  Example
//
//  Created by woko on 13/02/2020.
//

import Foundation
import UIKit
import SnapKit

open class HorizontalScrollContainerWidget: Widget, WidgetInstantiable {
    public typealias Model = HorizontalScrollContainerWidgetModel

    let scrollView = PagedScrollView()
    
    open override func build() {
        scrollView.backgroundColor = .clear
        scrollView.initialize()
        
        addContentView(scrollView)
        
        forceInteractible = true
    }
    
    open override func load() {
        super.load()

        scrollView.pageSize = CGFloat(model.itemWidth + model.itemMargin)
        
        refreshContent()
    }
    
    open func clearContent() {
        scrollView.clearContent()
    }
    
    open func refreshContent() {
        model.widgets.forEach { $0.ensureLoad() }
        addSubviews(model.widgets + model.subviews)
    }
    
    @objc open func addSubviews(_ subviews: [UIView]) {
        clearContent()
        
        var lastView: UIView?
        var index = 0
        subviews.forEach { view in
            if model.itemCornerRadius > 0 {
                view.layer.cornerRadius = CGFloat(model.itemCornerRadius)
                view.clipsToBounds = true
            }            
            view.removeFromSuperview()
            scrollView.contentView.addSubview(view)
            
            view.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                if let lastView = lastView {
                    $0.left.equalTo(lastView.snp.right).offset(model.itemMargin)
                } else {
                    $0.left.equalToSuperview()
                }
                $0.width.equalTo(model.itemWidth)
            }
            lastView = view
            index += 1
        }
        lastView?.snp.makeConstraints {
            $0.right.equalToSuperview()
        }   
    }
}

open class HorizontalScrollContainerWidgetModel: WidgetModel, WidgetContainer {
    public var widgets: [Widget] = []
    public var subviews: [UIView] = []
    public var itemWidth: Float = 100
    public var itemMargin: Float = 16
    public var itemCornerRadius: Float = 8
}
