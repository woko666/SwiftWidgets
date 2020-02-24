//
//  WidgetInstantiable.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import Foundation

public protocol WidgetInstantiable: Widget {
    associatedtype Model: WidgetModel
}

public extension WidgetInstantiable {
    var model: Model { imodel as! Model }
    var instantiateModel: Model { Model() }
    
    func createModel(isReusable: Bool) {
        imodel = instantiateModel
        imodel.isReusable = isReusable
    }
}
