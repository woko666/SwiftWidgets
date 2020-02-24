//
//  ViewWidget.swift
//  Example
//
//  Created by woko on 13/02/2020.
//

import Foundation
import UIKit

open class ViewWidget: Widget, WidgetInstantiable {
    public typealias Model = WidgetModel
    
    open override func build() {
        addContentView(UIView())
    }
}
