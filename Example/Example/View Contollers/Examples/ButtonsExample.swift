//
//  ButtonsExample.swift
//  Example
//
//  Created by woko on 15/02/2020.
//

import Foundation
import UIKit

class ButtonsExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWidgets()
    }
    
    func loadWidgets() {
        let button = addWidget(ButtonWidget.self) {
            $0.text.text = "Button"
            $0.text.font = Settings.Font.with(size: 30, weight: .bold)
            $0.text.color = UIColor.white
            $0.padding.vertical = Settings.Offset.basic
            $0.cornerRadius = 1.0
            $0.buttonColor = Settings.Color.primary
            $0.disabledTextColor = UIColor.black
            $0.height = 100
        }
        button.model.click = {
            print("button click")
        }
        button.model.tap = { _ in
            button.model.isEnabled = !button.model.isEnabled
            button.updateButton()
        }
        
        addReusableWidget(ButtonWidget.self) {
            $0.text.text = "Disabled Button"
            $0.text.font = Settings.Font.with(size: 30, weight: .bold)
            $0.text.color = UIColor.white
            $0.padding.vertical = Settings.Offset.basic
            $0.cornerRadius = 0.5
            $0.buttonColor = Settings.Color.primary
            $0.disabledTextColor = UIColor.black
            $0.isEnabled = false
            $0.tap = { _ in
                print("Disabled button tap")
            }
            $0.click = {
                print("Disabled button click (shouldn't get called)")
            }
        }
        
    }
}

