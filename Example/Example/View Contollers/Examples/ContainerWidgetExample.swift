//
//  ContainerWidgetExample.swift
//  Example
//
//  Created by woko on 11/02/2020.
//

import Foundation
import UIKit
import SnapKit

class ContainerWidgetExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        loadWidgets()
    }
    
    func loadWidgets() {        
        let container = addWidget(VContainerWidget.self)
        
        container.model.addWidget(ButtonWidget.self) {
            $0.text.text = "Button"
            $0.text.font = Settings.Font.with(size: 30, weight: .bold)
            $0.text.color = UIColor.white
            $0.padding.vertical = Settings.Offset.basic
            $0.cornerRadius = 1.0
            $0.buttonColor = Settings.Color.primary
            $0.disabledTextColor = UIColor.black
            $0.tap = { _ in
                print("Button tapped")
            }
        }
        
        container.model.addWidget(LabelWidget.self) {
            $0.text.text = "Different font and text color."
            $0.text.font = Settings.Font.with(size: 45)
            $0.text.color = Settings.Color.darkGray
            $0.text.alignment = .center
            $0.tap = { _ in
                print("Text tapped")
            }
        }
        
        container.model.addWidget(LabelWidget.self) {
            $0.text.htmlText = "Different <i>font</i> <a href=\"https://google.com\">and</a> <span style='color: #ff0000;'>text</span> <b>HTML</b>."
            $0.text.font = Settings.Font.with(size: 45)
            $0.text.color = Settings.Color.darkGray
            $0.text.alignment = .center
            $0.tap = { _ in
                print("Text tapped")
            }
        }
        
        container.model.addWidget(SwitchWidget.self) {
            $0.text.text = "Switch widget"
            $0.toggle.stateChanged = { (widget, state) in
                print("isOn:", state)
            }
        }
        
        container.model.addWidget(TextFieldWidget.self) {
            $0.placeholder.text = "Enter text here"
            $0.color.content = Settings.Color.lightGray
            $0.textInput.textChanged = { (widget, text) in
                print("text:", text)
            }
        }
        
        (0..<5).forEach { _ in addImageView() }
    }
        
    func addImageView() {
        addWidget(ImageWidget.self) {
            $0.image.imageUrl = imageUrl()
            $0.image.placeholder = Bool.random() ? #imageLiteral(resourceName: "placeholder") : nil
            $0.image.activityIndicator = true
        }
    }
}

