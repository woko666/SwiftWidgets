//
//  HorizontalScrollContainerExample.swift
//  Example
//
//  Created by woko on 13/02/2020.
//

import Foundation
import UIKit

class HorizontalContainersExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateUpdates = false
        loadWidgets()
    }
    
    func loadWidgets() {        
        // plain views
        do {
            addLabel("Scrolling horizontal container")
            let container = addWidget(HorizontalScrollContainerWidget.self) {
                $0.itemWidth = 150
                $0.height = 100
            }
            (0..<20).forEach { _ in
                container.model.addWidget(ViewWidget.self) {
                    $0.color.background = UIColor.randomDarkColor
                    $0.separator.enabled = false
                }
            }
        }
        
        // labels
        do {
            addLabel("Scrolling widgets with labels & padding")
            let container = addWidget(HorizontalScrollContainerWidget.self) {
                $0.itemWidth = 100
                $0.height = 100
                $0.padding.horizontal = 32
            }
            (0..<20).forEach { _ in
                let widget = container.model.addWidget(LabelWidget.self) {
                    $0.color.background = UIColor.randomDarkColor
                    $0.text.text = ["Lorem", "Ipsum", "Dolor", "Sit", "Amet"].randomElement() ?? "Text"
                    $0.text.font = Settings.Font.with(size: 16)
                    $0.text.color = .white
                    $0.text.alignment = .center
                    $0.separator.enabled = false
                }
                widget.model.tapped = {
                    print(widget.model.text.text ?? "")
                }
            }
        }
        
        // plain views
        do {
            addLabel("Stack view")
            let container = addWidget(HStackWidget.self) {
                $0.height = 100
                $0.itemSpacing = 12
            }
            (0..<3).forEach { _ in
                container.model.addWidget(ViewWidget.self) {
                    $0.color.background = UIColor.randomDarkColor
                    $0.separator.enabled = false
                    $0.tapped = {
                        print("widget tapped")
                    }
                }
            }
        }
        
        do {
            addLabel("Horizontal container widget - align left")
            let container = addWidget(HContainerWidget.self) {
                $0.height = 100
                $0.horizontalAlignment = .left
            }
            (0..<3).forEach { _ in
                container.model.addWidget(ViewWidget.self) {
                    $0.color.background = UIColor.randomDarkColor
                    $0.separator.enabled = false
                    $0.tapped = {
                        print("widget tapped")
                    }
                    $0.width = 50
                }
            }
        }
        
        do {
            addLabel("Horizontal container widget - align center")
            let container = addWidget(HContainerWidget.self) {
                $0.height = 100
                $0.horizontalAlignment = .center
            }
            (0..<3).forEach { _ in
                container.model.addWidget(ViewWidget.self) {
                    $0.color.background = UIColor.randomDarkColor
                    $0.separator.enabled = false
                    $0.tapped = {
                        print("widget tapped")
                    }
                    $0.width = 50
                }
            }
        }
        
        do {
            addLabel("Horizontal container widget - align right")
            let container = addWidget(HContainerWidget.self) {
                $0.height = 100
                $0.horizontalAlignment = .right
            }
            (0..<3).forEach { _ in
                container.model.addWidget(ViewWidget.self) {
                    $0.color.background = UIColor.randomDarkColor
                    $0.separator.enabled = false
                    $0.tapped = {
                        print("widget tapped")
                    }
                    $0.width = 50
                }
            }
        }
        
        do {
            addLabel("Horizontal container widget - fill (needs a widget without specified width")
            let container = addWidget(HContainerWidget.self) {
                $0.height = 100
                $0.horizontalAlignment = .fill
            }
            
            container.model.addWidget(ViewWidget.self) {
                $0.color.background = UIColor.randomDarkColor
                $0.separator.enabled = false
                $0.tapped = {
                    print("widget tapped")
                }
                $0.width = 100
            }
            
            container.model.addWidget(LabelWidget.self) {
                $0.text.text = "A somehow long text with some more text and some additional text etc etc et cetera."
                $0.text.font = Settings.Font.with(size: 14)
                $0.isEmbedded()
            }
        }
    }
}

