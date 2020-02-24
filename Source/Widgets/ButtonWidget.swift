//
//  ButtonWidget.swift
//  Example
//
//  Created by woko on 04/02/2020.
//

import Foundation
import UIKit

open class ButtonWidget: Widget, WidgetInstantiable {
    public typealias Model = ButtonWidgetModel

    public lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var textLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        return view
    }()

    open override func onTap() {
        if model.isEnabled {
            model.click?()
        }
        super.onTap()
    }
    
    open override func build() {
        forceClickable = true
        mainView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        addContentView(mainView)
    }
    
    open override func load() {
        super.load()
        
        textLabel.snp.updateConstraints {
            $0.left.equalToSuperview().offset(model.innerHorizontalPadding)
            $0.right.equalToSuperview().inset(model.innerHorizontalPadding)
            $0.top.equalToSuperview().offset(model.innerVerticalPadding)
            $0.bottom.equalToSuperview().inset(model.innerVerticalPadding)
        }
        
        LabelComponent().setup(target: textLabel, model: model.text, widgetModel: model)
        
        updateButton()
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        mainView.backgroundColor = buttonSelectedColor
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isInView(touches, with: event) {
            super.touchesEnded(touches, with: event)
        } else {
            super.touchesCancelled(touches, with: event)
        }
        
        mainView.backgroundColor = buttonColor
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        mainView.backgroundColor = isInView(touches, with: event) ? buttonSelectedColor : buttonColor
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        mainView.backgroundColor = buttonColor
    }
    
    open override func sizeUpdated() {
        updateCornerRadius()
    }
    
    open func isInView(_ touches: Set<UITouch>, with event: UIEvent?) -> Bool {
        return touches.first(where: { self.hitTest($0.location(in: self), with: event) != nil }) != nil
    }
    
    open func updateButton() {
        setEnabled(model.isEnabled)
    }
    
    open func updateCornerRadius() {
        let width = bounds.width - CGFloat(model.padding.top + model.padding.bottom + model.margin.top + model.margin.bottom)
        let height = bounds.height - CGFloat(model.padding.left + model.padding.right + model.margin.left + model.margin.right)
        mainView.layer.cornerRadius = min(width, height) * CGFloat(model.cornerRadius) * 0.5
    }
     
    open func setEnabled(_ isEnabled: Bool) {
        mainView.backgroundColor = buttonColor
        textLabel.textColor = textColor
    }
    
    public var buttonColor: UIColor? {
        return model.isEnabled ? model.buttonColor : disabledColor
    }
    
    public var buttonSelectedColor: UIColor? {
        return model.isEnabled ? (model.selectedButtonColor ?? model.buttonColor?.lighter(by: 0.3)) : disabledColor
    }
    
    public var disabledColor: UIColor {
        return model.disabledColor ?? Settings.Color.lightGray
    }
    
    public var textColor: UIColor? {
        return model.isEnabled ? model.text.color : (model.disabledTextColor ?? model.text.color)
    }
}


open class ButtonWidgetModel: WidgetModel {
    public var text = LabelComponentModel()
    public var innerHorizontalPadding: Float = 0
    public var innerVerticalPadding: Float = 0
    
    public var cornerRadius: Float = 1.0
    public var buttonColor: UIColor?
    public var selectedButtonColor: UIColor?
    public var disabledColor: UIColor?
    public var disabledTextColor: UIColor?
    public var isEnabled: Bool = true
    public var click: (() -> Void)?
    
    open override func afterInit() {
        text.alignment = .center
        color.selected = .clear
    }
}
