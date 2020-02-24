//
//  CustomWidget.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import Foundation
import UIKit

class CustomWidget: Widget, WidgetInstantiable {
    typealias Model = CustomWidgetModel
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spacingConstraint: NSLayoutConstraint!
    
    public let imageComp = ImageComponent()
    
    override func load() {
        super.load()
        
        spacingConstraint.constant = CGFloat(model.titleImageSpacing)
        imageComp.setup(target: imageView, model: model.image, widgetModel: model)
        LabelComponent().setup(target: mainLabel, model: model.text, widgetModel: model)
    }
}

class CustomWidgetModel: WidgetModel {
    var image = ImageComponentModel()
    var text = LabelComponentModel()
    var titleImageSpacing: Float = 20
    
    // override defaults
    override func afterInit() {
        text.alignment = .center
        height = 300
    }
}
