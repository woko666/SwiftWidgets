//
//  CustomWidgetExample.swift
//  Example
//
//  Created by woko on 18/02/2020.
//

import Foundation
import UIKit

class CustomWidgetExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWidgets()
    }
    
    func loadWidgets() {
            
        do {
            addReusableWidget(CustomWidget.self) {
                $0.text.text = "Custom widget with margin & padding"
                $0.text.font = Settings.Font.with(size: 22)
                $0.image.image = #imageLiteral(resourceName: "tea.jpg")
                $0.color.background = .black
                $0.color.padding = .red
                $0.color.content = .yellow
                $0.margin.all = 30
                $0.padding.all = 40
                $0.titleImageSpacing = 40
                $0.height = 500
            }
        }
        
        do {
            addReusableWidget(CustomWidget.self) {
                $0.text.text = "Default settings"
                $0.image.image = #imageLiteral(resourceName: "tea.jpg")
            }
        }

    }
}
