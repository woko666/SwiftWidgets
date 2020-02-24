//
//  ContainerWidget.swift
//  Example
//
//  Created by woko on 07/02/2020.
//

import Foundation
import UIKit

open class VContainerWidget: Widget, WidgetInstantiable {
    public typealias Model = VContainerWidgetModel
    
    public lazy var mainContent: VerticalWidgetViewContainer = {
        let view = VerticalWidgetViewContainer()
        return view
    }()
    
    open override func build() {
        addContentView(mainContent)
        
        forceInteractible = true
    }
    
    open override func load() {
        super.load()
        
        mainContent.widgets = model.widgets
        mainContent.layoutWidgets()
        mainContent.onHeightUpdated = { [weak self] in
            self?.parentContainer?.widgetHeightUpdated()
        }
    }
}

open class VContainerWidgetModel: WidgetModel, WidgetContainer {
    public var widgets: [Widget] = []
}
