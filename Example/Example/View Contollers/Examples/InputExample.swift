//
//  FormExample.swift
//  Example
//
//  Created by woko on 15/02/2020.
//

import Foundation
import UIKit

class InputExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWidgets()
    }
    
    func loadWidgets() {
        addWidget(SwitchWidget.self) {
            $0.text.text = "Switch widget"
            $0.toggle.stateChanged = { (widget, state) in
                print("isOn:", state)
            }
        }
        
        addWidget(TextFieldWidget.self) {
            $0.placeholder.text = "Enter text here"
            $0.color.content = Settings.Color.lightGray
            $0.textInput.textChanged = { (widget, text) in
                print("text:", text)
            }
        }
        
        addWidget(TextAreaWidget.self) {
            $0.textInput.text = "[Fixed size] Add some text here to the end of this sentence please: "
            $0.placeholder.text = "Fixed size placeholder"
            $0.height = 200
            $0.color.content = Settings.Color.lightGray
            $0.textInput.textChanged = { (widget, text) in
                print("text:", text)
            }
        }
        
        addWidget(TextAreaWidget.self) {
            $0.textInput.text = "[Grows with content] Add some text here to the end of this sentence please: "
            $0.color.content = Settings.Color.lightGray
            $0.textInput.textChanged = { (widget, text) in
                print("text:", text)
            }
        }
        
        addWidget(TextAreaWidget.self) {
            $0.color.content = Settings.Color.lightGray
            $0.placeholder.text = "Grows with content placeholder"
            $0.textInput.textChanged = { (widget, text) in
                print("text:", text)
            }
        }
    }
}

