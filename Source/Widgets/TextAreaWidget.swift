//
//  TextAreaWidget.swift
//  Example
//
//  Created by woko on 04/02/2020.
//

import Foundation
import UIKit

open class TextAreaWidget: Widget, WidgetInstantiable {
    public typealias Model = TextAreaWidgetModel
    
    public lazy var mainView: UIView = {
        return UIView()
    }()
    
    public lazy var textView: UITextView = {
        let view = UITextView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0
        return view
    }()
    
    public lazy var placeholderLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    open override func build() {
        mainView.addSubview(textView)
        mainView.addSubview(placeholderLabel)
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeholderLabel.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
        }
        
        addContentView(mainView)
        
        textView.isEditable = true
        textView.isSelectable = true
        textView.delegate = self
        
        forceInteractible = true
    }
    
    open override func load() {
        super.load()
        
        textView.snp.updateConstraints {
            $0.left.equalToSuperview().offset(model.innerEdgesHorizontal)
            $0.top.equalToSuperview().offset(model.innerEdgesVertical)
            $0.right.equalToSuperview().inset(model.innerEdgesHorizontal)
            $0.bottom.equalToSuperview().inset(model.innerEdgesVertical)
        }
        
        placeholderLabel.snp.updateConstraints {
            $0.left.equalToSuperview().offset(model.innerEdgesHorizontal)
            $0.top.equalToSuperview().offset(model.innerEdgesVertical)
            $0.right.equalToSuperview().inset(model.innerEdgesHorizontal)
        }
        
        TextAreaComponent().setup(target: textView, model: model.textInput, widgetModel: model)
        LabelComponent().setup(target: placeholderLabel, model: model.placeholder, widgetModel: model)
        
        if let text = model.textInput.text, !text.isEmpty {
            placeholderLabel.isHidden = true
        } else {
            placeholderLabel.isHidden = false
        }
        
        if model.height != nil {
            textView.isScrollEnabled = true
        } else {
            textView.isScrollEnabled = false
        }
    }
}

extension TextAreaWidget: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        let text = textView.text ?? ""
        placeholderLabel.isHidden = !text.isEmpty
        model.textInput.textChanged?(self, text)
        updateHeight()
    }
}

open class TextAreaWidgetModel: WidgetModel {
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
