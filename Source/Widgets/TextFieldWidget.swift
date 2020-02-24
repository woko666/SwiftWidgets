//
//  TextFieldWidget.swift
//  Example
//
//  Created by woko on 04/02/2020.
//

import Foundation
import UIKit

open class TextFieldWidget: Widget, WidgetInstantiable, UITextFieldDelegate {
    public typealias Model = TextFieldWidgetModel
    
    public lazy var mainView: UIView = {
        return UIView()
    }()
    
    public lazy var textField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.isUserInteractionEnabled = true
        return view
    }()
    
    public lazy var placeholderLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open override func build() {
        mainView.addSubview(textField)
        mainView.addSubview(placeholderLabel)
        
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeholderLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addContentView(mainView)
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        forceInteractible = true
    }
    
    open override func load() {
        super.load()
        
        textField.snp.updateConstraints {
            $0.left.equalToSuperview().offset(model.innerEdgesHorizontal)
            $0.top.equalToSuperview().offset(model.innerEdgesVertical)
            $0.right.equalToSuperview().inset(model.innerEdgesHorizontal)
            $0.bottom.equalToSuperview().inset(model.innerEdgesVertical)
        }
        
        placeholderLabel.snp.updateConstraints {
            $0.left.equalToSuperview().offset(model.innerEdgesHorizontal)
            $0.top.equalToSuperview().offset(model.innerEdgesVertical)
            $0.right.equalToSuperview().inset(model.innerEdgesHorizontal)
            $0.bottom.equalToSuperview().inset(model.innerEdgesVertical)
        }
        
        TextFieldComponent().setup(target: textField, model: model.textInput, widgetModel: model)
        LabelComponent().setup(target: placeholderLabel, model: model.placeholder, widgetModel: model)
        
        if let text = model.textInput.text, !text.isEmpty {
            placeholderLabel.isHidden = true
        } else {
            placeholderLabel.isHidden = false
        }
    }
    
    @objc open func textFieldDidChange() {
        let text = textField.text ?? ""
        placeholderLabel.isHidden = !text.isEmpty
        model.textInput.textChanged?(self, text)
    }
    
    // MARK: UITextFieldDelegate
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model.textInput.onEnterPressed?(self, textField)
        return true
    }
}

open class TextFieldWidgetModel: WidgetModel {
    public var textInput = TextFieldComponentModel()
    public var placeholder = LabelComponentModel()
    public var innerEdgesHorizontal: Float = 0
    public var innerEdgesVertical: Float = 0
    
    open override func afterInit() {
        placeholder.color = Settings.Color.darkGray
        innerEdgesHorizontal = Settings.Offset.basic
        innerEdgesVertical = Settings.Offset.basic
    }
}
