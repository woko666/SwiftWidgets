//
//  WidgetContainerBase.swift
//  Example
//
//  Created by woko on 07/02/2020.
//

import Foundation
import UIKit

public protocol WidgetContainer: WidgetInstantiator {
    var widgets: [Widget] { get set }
    
    func widgetHeightUpdated()
    func widgetHeightUpdated(_ animate: Bool?)
    var containerWidth: Float { get }
}

public extension WidgetContainer {
    func addWidget(_ widget: Widget) {
        widgets.append(widget)
    }
    
    @discardableResult func addSpace(_ height: Float) -> ViewWidget {
        return addWidget(ViewWidget.self, reuse: true) {
            $0.color.background = .clear
            $0.color.padding = .clear
            $0.color.content = .clear
            $0.height = height
            $0.separator.enabled = false
        }
    }
    
    @discardableResult func addWidget<ClassType: WidgetInstantiable>(_ type: ClassType.Type, reuse: Bool = false, setup: ((ClassType.Model) -> Void) = {_ in}) -> ClassType {
        let widget: ClassType = getWidget(type, isReusable: reuse, setup: setup)
        widgets.append(widget)
        return widget
    }
    
    @discardableResult func addReusableWidget<ClassType: WidgetInstantiable>(_ type: ClassType.Type, setup: ((ClassType.Model) -> Void) = {_ in}) -> ClassType {
        return addWidget(type, reuse: true, setup: setup)
    }
    
    func widgetHeightUpdated(_ animate: Bool?) {
    }
    
    func widgetHeightUpdated() {
        widgetHeightUpdated(nil)
    }
    
    var containerWidth: Float {
        return Float(UIScreen.main.bounds.width)
    }
}
