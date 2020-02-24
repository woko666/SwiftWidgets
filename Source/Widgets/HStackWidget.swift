//
//  StackWidget.swift
//  Example
//
//  Created by woko on 13/02/2020.
//

import Foundation
import UIKit
import SnapKit

open class HStackWidget: Widget, WidgetInstantiable {
    public typealias Model = HStackWidgetModel

    public lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.isLayoutMarginsRelativeArrangement = true
        view.backgroundColor = .clear
        return view
    }()
    
    open override func build() {
        addContentView(stackView)
        
        forceInteractible = true
    }
    
    open override func load() {
        super.load()

        stackView.spacing = CGFloat(model.itemSpacing)
        stackView.distribution = model.distribution
        stackView.alignment = model.alignment
        
        refreshContent()
    }
        
    open func clearContent() {
        stackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    open func refreshContent() {
        model.widgets.forEach { $0.ensureLoad() }
        addSubviews(model.widgets + model.subviews)
    }
    
    @objc open func addSubviews(_ subviews: [UIView]) {
        clearContent()
        
        subviews.forEach { view in
            if model.itemCornerRadius > 0 {
                view.layer.cornerRadius = CGFloat(model.itemCornerRadius)
                view.clipsToBounds = true
            }
            view.removeFromSuperview()
            stackView.addArrangedSubview(view)
        }
    }
}

open class HStackWidgetModel: WidgetModel, WidgetContainer {
    public var widgets: [Widget] = []
    public var subviews: [UIView] = []
    public var distribution: UIStackView.Distribution = .fillEqually
    public var alignment: UIStackView.Alignment = .fill
    public var itemSpacing: Float = 0
    public var itemCornerRadius: Float = 0
}
