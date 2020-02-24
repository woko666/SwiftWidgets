//
//  WidgetTableViewCell.swift
//  Example
//
//  Created by woko on 08/12/2019.
//

import Foundation
import UIKit

open class WidgetTableViewCell: UITableViewCell {
    public var widget: Widget? {
        didSet {
            guard let widget = widget else { return }
            widget.removeFromSuperview()
            widget.addWithConstraintsTo(contentView)
            widget.parentCell = self
        }
    }
    
    open override func setSelected(_ selected: Bool, animated: Bool) {
        if let selectedColor = widget?.imodel.color.selected, selectedColor.alpha > 0 {
            super.setSelected(selected, animated: animated)
        }
    }
    
    open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if let selectedColor = widget?.imodel.color.selected, selectedColor.alpha > 0 {
            super.setHighlighted(highlighted, animated: animated)
        }
    }
}
