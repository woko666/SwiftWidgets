//
//  TextInputComponent.swift
//  Example
//
//  Created by woko on 04/02/2020.
//

import Foundation
import UIKit

open class TextFieldComponent: WidgetComponent {
    public typealias Target = UITextField
    public typealias VM = TextFieldComponentModel
    public typealias WM = WidgetModel
    
    public init() { }
    
    public func setup(target: Target, model: VM, widgetModel: WM) {
        target.font = model.font
        target.textColor = model.color
        target.tintColor = widgetModel.color.tint
        target.textAlignment = model.alignment
        target.text = model.text
    }
}

open class TextFieldComponentModel: LabelComponentModel {
    public var textChanged: ((Widget, String) -> Void)?
    public var onEnterPressed: ((Widget, UITextField) -> Void)? = { $1.resignFirstResponder() }
}
