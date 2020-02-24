//
//  WidgetSeparator.swift
//  Example
//
//  Created by woko on 03/02/2020.
//

import Foundation
import UIKit

public extension Widget {
    func updateSeparator() {
        separator?.removeFromSuperview()
        separator = nil
        if imodel.separator.enabled {
            initSeparator()
        }
    }
        
    func initSeparator() {
        let separator = UIView()
        self.separator = separator
        separator.backgroundColor = imodel.separator.color
        addSubview(separator)
    
        separator.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: separator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(imodel.separator.height)))
        addConstraint(NSLayoutConstraint(item: separator, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: CGFloat(imodel.separator.leftPadding)))
        addConstraint(NSLayoutConstraint(item: separator, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: CGFloat(-imodel.separator.rightPadding)))
        addConstraint(NSLayoutConstraint(item: separator, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
}
