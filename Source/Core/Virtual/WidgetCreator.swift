//
//  WidgetCreator.swift
//  Example
//
//  Created by woko on 07/02/2020.
//

import Foundation

open class WidgetCreator: WidgetInstantiator {
    public init() {}
    
    open func getWidget<ClassType: WidgetInstantiable>(_ type: ClassType.Type, isReusable: Bool, setup: ((ClassType.Model) -> Void)?) -> ClassType {
        let widget = ClassType.create() as! ClassType
        widget.createModel(isReusable: isReusable)
        widget.model.separator.enabled = false
        return widget
    }
}
