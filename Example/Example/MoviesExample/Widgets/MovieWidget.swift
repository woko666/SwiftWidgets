//
//  CustomWidget.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import Foundation
import UIKit

class MovieWidget: Widget, WidgetInstantiable {
    typealias Model = MovieWidgetModel
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    public let imageComp = ImageComponent()
    
    override func load() {
        super.load()
        
        LabelComponent().setup(target: titleLabel, model: model.title, widgetModel: model)
        imageComp.setup(target: imageView, model: model.image, widgetModel: model)
    }
}

class MovieWidgetModel: WidgetModel {
    public var title = LabelComponentModel()
    public var image = ImageComponentModel()
}
