//
//  QuickstartExample.swift
//  Example
//
//  Created by woko on 20/02/2020.
//

import Foundation

class QuickstartExample: WidgetTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWidget(ImageWidget.self) {
            $0.image.image = #imageLiteral(resourceName: "tea.jpg")
            $0.height = 150
        }
        
        addReusableWidget(LabelWidget.self) {
            $0.text.text = "Label widget with a pretty long text that will auto grow."
        }

        addReusableWidget(LabelWidget.self) {
            $0.text.text = "Different font and text color."
            $0.text.font = Settings.Font.with(size: 45)
            $0.text.color = Settings.Color.darkGray
            $0.text.alignment = .center
            $0.tap = { widgetInstance in
                print("Text tapped - widget", widgetInstance)
            }
        }
        
        addWidget(ButtonWidget.self) {
            $0.text.text = "Button"
            $0.text.font = Settings.Font.title
            $0.text.color = .white
            $0.padding.vertical = Settings.Offset.basic
            $0.cornerRadius = 1.0
            $0.buttonColor = Settings.Color.primary
            $0.height = 80
            $0.click = {
                print("button click")
            }
        }
    }
}
