//
//  UIExtensions.swift
//  Example
//
//  Created by woko on 11/02/2020.
//

import Foundation
import UIKit

extension UIColor {
    static var randomDarkColor: UIColor {
        return UIColor(hue: CGFloat.random(in: 0.0...1.0), saturation: CGFloat.random(in: 0.2...1.0), brightness: CGFloat.random(in: 0.4...0.6), alpha: 1.0)
    }
}
