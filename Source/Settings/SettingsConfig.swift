//
//  SkinConfig.swift
//  Example
//
//  Created by woko on 25/09/2019.
//

import Foundation
import UIKit

public protocol SettingsConfig {
    // MARK: Colors
    var backgroundColor: String { get }
    var paddingColor: String { get }
    var contentColor: String { get }
    var separatorColor: String { get }
    var darkGrayColor: String { get }
    var lightGrayColor: String { get }
    var tintColor: String { get }
    var primaryColor: String { get }
    var navBarColor: String { get }
    var tabBarColor: String { get }
    var textColor: String { get }
    var selectedColor: String { get }
    var accessoryColor: String { get }
    
    // MARK: Offsets
    var marginBase: Float { get }
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
    var accessoryPadding: Float { get }
    
    // MARK: Fonts
    var lightFont: UIFont? { get }
    var regularFont: UIFont? { get }
    var semiboldFont: UIFont? { get }
    var boldFont: UIFont? { get }
    
    var defaultFont: ConfigFont { get }
    var headerFont: ConfigFont { get }
    var titleFont: ConfigFont { get }
    var headlineFont: ConfigFont { get }
    
    // MARK: Misc
    var hasSeparator: Bool { get }
    var accessorySize: CGSize { get }
}

public extension SettingsConfig {
    // MARK: Colors
    var backgroundColor: String {"ffffff00" }
    var paddingColor: String {"ffffff00" }
    var contentColor: String { "ffffff00" }
    var separatorColor: String {
        if #available(iOS 13.0, *) {
            // dark mode compatible color
            return UIColor.opaqueSeparator.hexString
        } else {
            return UIColor.lightGray.hexString
        }
    }
    var darkGrayColor: String {
        if #available(iOS 13.0, *) {
            // dark mode compatible color
            return UIColor.systemGray2.hexString
        } else {
            return UIColor.gray.hexString
        }
    }
    var lightGrayColor: String {
        if #available(iOS 13.0, *) {
            // dark mode compatible color
            return UIColor.systemGray5.hexString
        } else {
            return UIColor.lightGray.hexString
        }
    }
    var tintColor: String { "770000" }
    var primaryColor: String { "ff0000" }
    var navBarColor: String { "007aff" }
    var tabBarColor: String { "007aff" }
    var textColor: String {
        if #available(iOS 13.0, *) {
            // dark mode compatible color
            return UIColor.label.hexString
        } else {
            return UIColor.darkText.hexString
        }
    }
    var selectedColor: String { "ffffff00" }
    var accessoryColor: String {
        if #available(iOS 13.0, *) {
            // dark mode compatible color
            return UIColor.systemGray2.hexString
        } else {
            return UIColor.gray.hexString
        }
    }
    
    // MARK: Offsets
    var marginBase: Float { 4 }
    var marginLeft: Float { 0 }
    var marginRight: Float { 0 }
    var marginTop: Float { 0 }
    var marginBot: Float { 0 }
    var paddingLeft: Float { marginBase }
    var paddingRight: Float { marginBase }
    var paddingTop: Float { marginBase }
    var paddingBot: Float { marginBase }
    var separatorHeight: Float { 1 }
    var separatorPaddingLeft: Float { marginBase }
    var separatorPaddingRight: Float { marginBase }
    var accessoryPadding: Float { 12 }
    var accessorySize: CGSize { CGSize(width: 16, height: 16) }
    
    // MARK: Fonts
    var lightFont: UIFont? { nil }
    var regularFont: UIFont? { nil }
    var semiboldFont: UIFont? { nil }
    var boldFont: UIFont? { nil }
    
    var defaultFont: ConfigFont { ConfigFont(size: 16, weight: .regular) }
    var headerFont: ConfigFont { ConfigFont(size: 26, weight: .regular) }
    var titleFont: ConfigFont { ConfigFont(size: 22, weight: .regular) }
    var headlineFont: ConfigFont { ConfigFont(size: 18, weight: .bold) }
    
    // MARK: Misc
    var hasSeparator: Bool { true }
}

public struct ConfigFont {
    var size: Float
    var weight: UIFont.Weight
}
