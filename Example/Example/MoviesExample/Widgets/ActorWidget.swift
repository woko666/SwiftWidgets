//
//  ActorWidget.swift
//  Example
//
//  Created by woko on 20/02/2020.
//

import Foundation
import UIKit

class ActorWidget: Widget, WidgetInstantiable {
    typealias Model = ActorWidgetModel
    
    let content = HViewContainer()
    let vertical = VViewContainer()
    let nameLabel = UILabel()
    let characterLabel = UILabel()
    let imageView = UIImageView()
    
    public let imageComp = ImageComponent()
    
    override func build() {
        vertical.views = [nameLabel, characterLabel]
        vertical.verticalAlignment = .center
        content.views = [imageView, vertical]
        content.verticalAlignment = .center
        
        addContentView(content)
    }
    
    override func load() {
        super.load()
        
        content.spacing = Settings.Offset.basic
        vertical.spacing = Settings.Offset.basic
        
        content.layoutContent()
        vertical.layoutContent()
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(60)
        }
        
        LabelComponent().setup(target: nameLabel, model: model.name, widgetModel: model)
        LabelComponent().setup(target: characterLabel, model: model.character, widgetModel: model)
        imageComp.setup(target: imageView, model: model.image, widgetModel: model)
        
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
    }
}

class ActorWidgetModel: WidgetModel {
    public var name = LabelComponentModel()
    public var character = LabelComponentModel()
    public var image = ImageComponentModel()
}
