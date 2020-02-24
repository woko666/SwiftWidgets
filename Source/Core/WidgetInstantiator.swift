//
//  WidgetInstantiator.swift
//  Example
//
//  Created by woko on 07/02/2020.
//

import Foundation

public protocol WidgetInstantiator: class {
    func getWidget<ClassType: WidgetInstantiable>(_ type: ClassType.Type, isReusable: Bool, setup: ((ClassType.Model) -> Void)) -> ClassType
    func getWidgetWithModel<ClassType: Widget>(_ existing: ClassType) -> ClassType
}

public extension WidgetInstantiator {
    func getWidget<ClassType: WidgetInstantiable>(_ type: ClassType.Type, setup: ((ClassType.Model) -> Void) = {_ in}) -> ClassType {
        return getWidget(type, isReusable: false, setup: setup)
    }
    
    func getWidget<ClassType: WidgetInstantiable>(_ type: ClassType.Type, isReusable: Bool, setup: ((ClassType.Model) -> Void) = {_ in}) -> ClassType {
        let widget = ClassType.create() as! ClassType
        widget.createModel(isReusable: isReusable)
        setup(widget.model)
        return widget
    }
    
    func getWidgetWithModel<ClassType: Widget>(_ existing: ClassType) -> ClassType {
        let widget = existing.createInstance() as! ClassType
        widget.imodel = existing.imodel
        return widget
    }
}
