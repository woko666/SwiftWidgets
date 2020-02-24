//
//  HorizontalContainerWidget.swift
//  Example
//
//  Created by woko on 19/02/2020.
//

import Foundation
import UIKit

open class HContainerWidget: Widget, WidgetInstantiable {
    public typealias Model = HContainerWidgetModel
    
    public lazy var mainContent: HorizontalWidgetViewContainer = {
        let view = HorizontalWidgetViewContainer()
        return view
    }()
    
    open override func build() {
        addContentView(mainContent)
        
        forceInteractible = true
    }
    
    open override func load() {
        super.load()
        
        mainContent.horizontalAlignment = model.horizontalAlignment
        mainContent.verticalAlignment = model.verticalAlignment
        mainContent.widgets = model.widgets
        mainContent.layoutWidgets()
        mainContent.onHeightUpdated = { [weak self] in
            self?.parentContainer?.widgetHeightUpdated()
        }
    }
}

open class HContainerWidgetModel: WidgetModel, WidgetContainer {
    public var widgets: [Widget] = []
    public var horizontalAlignment: HorizontalAlignment = .left
    public var verticalAlignment: VerticalAlignment = .fill
}
