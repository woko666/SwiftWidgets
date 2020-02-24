//
//  TextComponent.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import Foundation
import UIKit
import Nantes

open class LabelComponent: WidgetComponent {
    public typealias Target = UILabel
    public typealias VM = LabelComponentModel
    public typealias WM = WidgetModel
    
    public init() { }
    
    public func setup(target: Target, model: VM, widgetModel: WM) {
        target.font = model.font
        target.textColor = model.color
        target.tintColor = widgetModel.color.tint
        target.textAlignment = model.alignment
        target.numberOfLines = model.numberOfLines
        
        if let nantesLabel = target as? NantesLabel {
            nantesLabel.linkAttributes = [NSAttributedString.Key.foregroundColor: widgetModel.color.tint]
        }
        
        if let text = model.text {
            target.text = text
        } else if let attributedText = model.attributedText {
            target.attributedText = attributedText
        } else if let htmlText = model.htmlText {
            target.attributedText = HtmlParsing.getAttributedStringFromHtml(text: htmlText, font: model.font, textColor: model.color, tintColor: widgetModel.color.tint, textAlignment: model.alignment)
        } else {
            target.text = nil
        }
    }
}

open class LabelComponentModel {
    public var text: String?
    public var htmlText: String?
    public var attributedText: NSAttributedString?
    
    public var color: UIColor = UIColor.darkText
    public var alignment: NSTextAlignment = .left
    public var font: UIFont?
    public var numberOfLines: Int = 0
    
    public init() {
        color = Settings.Color.text
        font = Settings.Font.default
    }
}
