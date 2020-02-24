//
//  WidgetCore.swift
//  Example
//
//  Created by woko on 05/02/2020.
//

import Foundation
import UIKit

public extension Widget {
    func updateCoreProperties() {
        guard let imodel = imodel else { return }
        
        rightMarginConstraint?.constant = -CGFloat(imodel.margin.right)
        leftMarginConstraint?.constant = CGFloat(imodel.margin.left)
        topMarginConstraint?.constant = CGFloat(imodel.margin.top)
        botMarginConstraint?.constant = -CGFloat(imodel.margin.bottom)
        
        rightPaddingConstraint?.constant = -CGFloat(imodel.padding.right)
        leftPaddingConstraint?.constant = CGFloat(imodel.padding.left)
        topPaddingConstraint?.constant = CGFloat(imodel.padding.top)
        botPaddingConstraint?.constant = -CGFloat(imodel.padding.bottom)        
        
        backgroundColor = imodel.color.background.alpha > 0 ? imodel.color.background : nil
        paddingView?.backgroundColor = imodel.color.padding.alpha > 0 ? imodel.color.padding : UIColor.clear
        contentView?.backgroundColor = imodel.color.content.alpha > 0 ? imodel.color.content : UIColor.clear
    }
    
    func addContentView(_ view: UIView) {
        if view.superview != self {
            view.removeFromSuperview()
        }
        paddingView?.subviews.forEach { $0.removeFromSuperview() }

        if paddingView == nil {
            let paddingView = UIView()
            (left: leftMarginConstraint, right: rightMarginConstraint, top: topMarginConstraint, bot: botMarginConstraint) = paddingView.addWithConstraintsTo(self)
            self.paddingView = paddingView
            //botMarginConstraint?.priority = .defaultHigh // if tableview controller computes UIView-Encapsulated-Layout-Height we need one lower priority constraint
        }
        
        guard let paddingView = paddingView else { return }
        
        (left: leftPaddingConstraint, right: rightPaddingConstraint, top: topPaddingConstraint, bot: botPaddingConstraint) = view.addWithConstraintsTo(paddingView)
        self.contentView = view
        
        updateCoreProperties()
    }
}
