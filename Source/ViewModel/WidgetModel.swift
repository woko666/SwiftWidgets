//
//  SWModel.swift
//  Example
//
//  Created by woko on 07/12/2019.
//

import Foundation
import UIKit

open class WidgetModel/*: WidgetModelBase*/ {
    public var isReusable: Bool
    
    // MARK: Skin model
    public var margin: Insets
    public var padding: Insets
    public var separator: SeparatorModel
    public var color: ColorModel
    public var accessory: AccessoryModel
    
    public var width: Float?
    public var height: Float?
    public var size: Float {
        @available(*, unavailable)
        get {
            fatalError("This property is set-only (sets the width and height properties)")
        }
        set {
            width = newValue
            height = newValue
        }
    }
    
    // MARK: Actions
    public var tap: ((Widget) -> Void)?
    public var tapped: (() -> Void)? {
        @available(*, unavailable)
        get {
            fatalError("This property is set-only (sets the tap property without a callback parameter)")
        }
        set {
            tap = { widget in
                newValue?()
            }
        }
    }
    public var del: ((Widget) -> Void)?
    
    // MARK: View model (widget-specific)
    
    
    // MARK: Init
    required public convenience init() {
        self.init(isReusable: false, rightMargin: Settings.Offset.marginRight, leftMargin: Settings.Offset.marginLeft, topMargin: Settings.Offset.marginTop, botMargin: Settings.Offset.marginBot, rightPadding: Settings.Offset.paddingRight, leftPadding: Settings.Offset.paddingLeft, topPadding: Settings.Offset.paddingTop, botPadding: Settings.Offset.paddingBot, color: ColorModel(), separator: SeparatorModel(), accessory: AccessoryModel())
        afterInit()
    }
    public required init(isReusable: Bool, rightMargin: Float, leftMargin: Float, topMargin: Float, botMargin: Float, rightPadding: Float, leftPadding: Float, topPadding: Float, botPadding: Float, color: ColorModel, separator: SeparatorModel, accessory: AccessoryModel) {
        self.isReusable = isReusable
        self.margin = Insets(top: topMargin, left: leftMargin, bottom: botMargin, right: rightMargin)
        self.padding = Insets(top: topPadding, left: leftPadding, bottom: botPadding, right: rightPadding)
        self.color = color
        self.separator = separator
        self.accessory = accessory
    }
    
    // Custom initialization after init has called
    open func afterInit() {
        
    }
}

public extension WidgetModel {
    func zeroPaddingMargin() {
        padding.all = 0
        margin.all = 0
    }
    
    func isEmbedded() {
        padding.all = 0
        margin.all = 0
        separator.enabled = false
    }
    
    var separatorPadding: Float {
        @available(*, unavailable)
        get {
            fatalError("This property is set-only (sets separator.leftPadding & separator.rightPadding")
        }
        set {
            separator.leftPadding = newValue
            separator.rightPadding = newValue
        }
    }
}

open class Insets {
    public var top: Float = 0
    public var left: Float = 0
    public var bottom: Float = 0
    public var right: Float = 0
    
    public init() { }
    
    public init(top: Float, left: Float, bottom: Float, right: Float) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
    
    public var horizontal: Float {
        @available(*, unavailable)
        get {
            fatalError("This property is set-only (sets left & right")
        }
        set {
            left = newValue
            right = newValue
        }
    }
    
    public var vertical: Float {
        @available(*, unavailable)
        get {
            fatalError("This property is set-only (sets top & bottom")
        }
        set {
            top = newValue
            bottom = newValue
        }
    }
    
    public var all: Float {
        @available(*, unavailable)
        get {
            fatalError("This property is set-only (sets top, bottom, left, right")
        }
        set {
            top = newValue
            bottom = newValue
            left = newValue
            right = newValue
        }
    }
}

public enum AccessoryType {
    case none // don't show any accessory view
    case disclosureIndicator // regular chevron
    case activityIndicator // activity indicator
    case checkmark // checkmark
    case image // custom image
    case view // custom view
}

open class SeparatorModel {
    public var enabled: Bool // is separator shown or not?
    public var height: Float // height of the separator
    public var color: UIColor // separator color
    public var rightPadding: Float // right padding
    public var leftPadding: Float // left padding
    
    var padding: Float {
        @available(*, unavailable)
        get {
            fatalError("This property is set-only (sets leftPadding & rightPadding")
        }
        set {
            leftPadding = newValue
            rightPadding = newValue
        }
    }
    
    public convenience init() {
        self.init(enabled: Settings.Misc.hasSeparator, height: Settings.Offset.separatorHeight, color: Settings.Color.separator, rightPadding: Settings.Offset.separatorPaddingRight, leftPadding: Settings.Offset.separatorPaddingLeft)
    }
    
    public init(enabled: Bool, height: Float, color: UIColor, rightPadding: Float, leftPadding: Float) {
        self.enabled = enabled
        self.height = height
        self.color = color
        self.rightPadding = rightPadding
        self.leftPadding = leftPadding
    }
}

open class AccessoryModel {
    public var type: AccessoryType = .none
    public var size: CGSize
    public var rightPadding: Float
    public var color: UIColor
    public var view: UIView? {
        didSet {
            if view != nil {
                type = .view
            }
        }
    }
    public var image: UIImage? {
        didSet {
            if image != nil {
                type = .image
            }
        }
    }
    
    public convenience init() {
        self.init(size: Settings.Offset.accessorySize, rightPadding: Settings.Offset.accessoryPadding, color: Settings.Color.accessory)
    }
    
    public init(size: CGSize, rightPadding: Float, color: UIColor) {
        self.size = size
        self.rightPadding = rightPadding
        self.color = color
    }
}

open class ColorModel {
    public var background: UIColor
    public var padding: UIColor
    public var content: UIColor
    public var selected: UIColor
    public var tint: UIColor
    
    public convenience init() {
        self.init(background: Settings.Color.background, padding: Settings.Color.padding, content: Settings.Color.content, selected: Settings.Color.selected, tint: Settings.Color.tint)
    }
    
    public init(background: UIColor, padding: UIColor, content: UIColor, selected: UIColor, tint: UIColor) {
        self.background = background
        self.padding = padding
        self.content = content
        self.selected = selected
        self.tint = tint
    }
}
