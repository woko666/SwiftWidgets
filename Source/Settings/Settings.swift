//
//  Appearance.swift
//  Example
//
//  Created by woko on 25/09/2019.
//

import Foundation
import UIKit

public protocol SettingsOffset {
    var basic: Float { get }
    var basic2: Float { get }
    var basic3: Float { get }
    var basic4: Float { get }
    var basic6: Float { get }
    var basic8: Float { get }
    
    var marginLeft: Float { get }
    var marginRight: Float { get }
    var marginTop: Float { get }
    var marginBot: Float { get }
    
    var paddingLeft: Float { get }
    var paddingRight: Float { get }
    var paddingTop: Float { get }
    var paddingBot: Float { get }
    
    var separatorHeight: Float { get }
    var separatorPaddingLeft: Float { get }
    var separatorPaddingRight: Float { get }
    
    var accessorySize: CGSize { get }
    var accessoryPadding: Float { get }
}

public protocol SettingsColor {
    var background: UIColor { get }
    var padding: UIColor { get }
    var content: UIColor { get }
    var separator: UIColor { get }
    var darkGray: UIColor { get }
    var lightGray: UIColor { get }
    var text: UIColor { get }
    var primary: UIColor { get }
    var tint: UIColor { get }
    var navBar: UIColor { get }
    var tabBar: UIColor { get }
    var selected: UIColor { get }
    var accessory: UIColor { get }
}

public protocol SettingsFont {
    var `default`: UIFont { get }
    var header: UIFont { get }
    var title: UIFont { get }
    var headline: UIFont { get }
    
    func with(size: Float, weight: UIFont.Weight) -> UIFont
}

public extension SettingsFont {
    func with(size: Float) -> UIFont {
        return with(size: size, weight: .regular)
    }
}

public protocol SettingsMisc {
    var hasSeparator: Bool { get }
}

open class Settings {
    public static var Offset: SettingsOffset!
    public static var Color: SettingsColor!
    public static var Font: SettingsFont!
    public static var Misc: SettingsMisc!
    
    public static func initDefaults(_ conf: SettingsConfig) {
        Settings.Offset = SettingsOffsetDefault(conf)
        Settings.Color = SettingsColorDefault(conf)
        Settings.Font = SettingsFontDefault(conf)
        Settings.Misc = SettingsMiscDefault(conf)
    }
}

public struct SettingsOffsetDefault: SettingsOffset {
    public var conf: SettingsConfig
    public init(_ conf: SettingsConfig) {
        self.conf = conf
    }
    
    public var basic: Float { conf.marginBase }
    public var basic2: Float { conf.marginBase * 2 }
    public var basic3: Float { conf.marginBase * 3 }
    public var basic4: Float { conf.marginBase * 4 }
    public var basic6: Float { conf.marginBase * 6 }
    public var basic8: Float { conf.marginBase * 8 }
    
    public var marginLeft: Float { conf.marginLeft }
    public var marginRight: Float { conf.marginRight }
    public var marginTop: Float { conf.marginTop }
    public var marginBot: Float { conf.marginBot }
    
    public var paddingLeft: Float { conf.paddingLeft }
    public var paddingRight: Float { conf.paddingRight }
    public var paddingTop: Float { conf.paddingTop }
    public var paddingBot: Float { conf.paddingBot }
    
    public var separatorHeight: Float { conf.separatorHeight }
    public var separatorPaddingLeft: Float { conf.separatorPaddingLeft }
    public var separatorPaddingRight: Float { conf.separatorPaddingRight }
    
    public var accessorySize: CGSize { conf.accessorySize }
    public var accessoryPadding: Float { conf.accessoryPadding }
}

public struct SettingsColorDefault: SettingsColor {
    public var conf: SettingsConfig
    public init(_ conf: SettingsConfig) {
        self.conf = conf
    }
    
    public var background: UIColor { UIColor.from(hexString: conf.backgroundColor) }
    public var padding: UIColor { UIColor.from(hexString: conf.paddingColor) }
    public var content: UIColor { UIColor.from(hexString: conf.contentColor) }
    public var separator: UIColor { UIColor.from(hexString: conf.separatorColor) }
    public var darkGray: UIColor { UIColor.from(hexString: conf.darkGrayColor) }
    public var lightGray: UIColor { UIColor.from(hexString: conf.lightGrayColor) }
    public var text: UIColor { UIColor.from(hexString: conf.textColor) }
    public var primary: UIColor { UIColor.from(hexString: conf.primaryColor) }
    public var tint: UIColor { UIColor.from(hexString: conf.tintColor) }
    public var navBar: UIColor { UIColor.from(hexString: conf.navBarColor) }
    public var tabBar: UIColor { UIColor.from(hexString: conf.tabBarColor) }
    public var selected: UIColor { UIColor.from(hexString: conf.selectedColor) }
    public var accessory: UIColor { UIColor.from(hexString: conf.accessoryColor) }
}
    
public struct SettingsFontDefault: SettingsFont {
    public var conf: SettingsConfig
    public init(_ conf: SettingsConfig) {
        self.conf = conf
    }
    
    public var `default`: UIFont {
        with(size: conf.defaultFont.size, weight: conf.defaultFont.weight)
    }
    
    public var header: UIFont {
        with(size: conf.headerFont.size, weight: conf.headerFont.weight)
    }
    
    public var title: UIFont {
        with(size: conf.titleFont.size, weight: conf.titleFont.weight)
    }
    
    public var headline: UIFont {
        with(size: conf.headlineFont.size, weight: conf.headlineFont.weight)
    }
    
    public func with(size: Float, weight: UIFont.Weight = .regular) -> UIFont {
        var font: UIFont?
        switch weight {
        case .light:
            font = conf.lightFont
        case .regular:
            font = conf.regularFont
        case .semibold:
            font = conf.semiboldFont
        case .bold:
            font = conf.boldFont
        default:
            break
        }
        if let font = font {
            return UIFont(descriptor: font.fontDescriptor, size: CGFloat(size))
        }
        return UIFont.systemFont(ofSize: CGFloat(size), weight: weight)
    }
}

public struct SettingsMiscDefault: SettingsMisc {
    public var conf: SettingsConfig
    public init(_ conf: SettingsConfig) {
        self.conf = conf
    }
    
    public var hasSeparator: Bool { conf.hasSeparator }
}

// extensions to standard classes
/*extension SkinMargin {
    var basic10: CGFloat { 0 }
}

extension SkinMarginDefault {
    var basic10: CGFloat { conf.marginBase * 10 }
}*/
