//
//  UIExtensions.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import Foundation
import UIKit

extension UIColor {
    var alpha: CGFloat {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return alpha
    }
    
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: UInt32 = (UInt32)(r * 255) << 16 | (UInt32)(g * 255) << 8 | (UInt32)(b * 255) << 0
        
        return String(format: "%06x", rgb)
    }
    
    class func from(hexString: String?) -> UIColor {
        guard let hexString = hexString else {
            return .black
        }
        
        var cString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 && cString.count != 8 {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        if cString.count == 6 {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        } else {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0,
                green: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
                blue: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
                alpha: CGFloat(rgbValue & 0x000000FF) / 255.0
            )
        }
    }
    
    func lighter(by rate: CGFloat = 0.3) -> UIColor? {
        return self.adjust(by: abs(rate) )
    }
    
    func darker(by rate: CGFloat = 0.3) -> UIColor? {
        return self.adjust(by: -abs(rate) )
    }
    
    func adjust(by rate: CGFloat = 0.3) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: max(min(red + rate, 1.0), 0.0),
                           green: max(min(green + rate, 1.0), 0.0),
                           blue: max(min(blue + rate, 1.0), 0.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}

extension UIView {
    @discardableResult func addWithConstraintsTo(_ parent: UIView) -> (left: NSLayoutConstraint, right: NSLayoutConstraint, top: NSLayoutConstraint, bot: NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
            
        let leftPaddingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: parent, attribute: .leading, multiplier: 1, constant: 0)
        parent.addConstraint(leftPaddingConstraint)
        
        let rightPaddingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: parent, attribute: .trailing, multiplier: 1, constant: 0)
        parent.addConstraint(rightPaddingConstraint)
        
        let topPaddingConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1, constant: 0)
        parent.addConstraint(topPaddingConstraint)
        
        let botPaddingConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1, constant: 0)
        parent.addConstraint(botPaddingConstraint)
        
        return (left: leftPaddingConstraint, right: rightPaddingConstraint, top: topPaddingConstraint, bot: botPaddingConstraint)
    }
}
 
extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    mutating func remove(at indices: [Int]) {
        Set(indices).sorted(by: >).forEach { index in
            self.remove(at: index)
        }
    }
}
