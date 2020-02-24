//
//  ToggleComponent.swift
//  Example
//
//  Created by woko on 03/02/2020.
//

import Foundation
import UIKit
import Kingfisher

open class ToggleComponent: WidgetComponent {
    public typealias Target = UISwitch
    public typealias VM = ToggleComponentModel
    public typealias WM = WidgetModel
    
    public var imageLoaded: (() -> Void)?
    public weak var target: Target?
    public weak var model: VM?
    public weak var widget: Widget?
    
    public init() { }
    
    public func setup(target: Target, model: VM, widgetModel: WM, widget: Widget) {
        self.target = target
        self.model = model
        self.widget = widget
        
        target.onTintColor = widgetModel.color.tint
        target.isEnabled = model.isEnabled
        target.setOn(model.isOn, animated: false)
        target.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }

    @objc func switchChanged(sourceSwitch: UISwitch) {
        let value = sourceSwitch.isOn
                
        guard let model = model, let widget = widget else { return }
        model.isOn = value
        model.stateChanged?(widget, value)
        // Do something
    }
    
    func toggle() {
        guard let target = target, let widget = widget, let model = model else { return }
        
        let newState = !target.isOn
        target.setOn(newState, animated: true)
        model.stateChanged?(widget, newState)
    }
}

open class ToggleComponentModel {
    public var isOn: Bool = true
    public var isEnabled: Bool = true
    public var stateChanged: ((Widget, Bool) -> Void)?
    
    public init() { }
}
