//
//  SkinningExample.swift
//  Example
//
//  Created by woko on 15/02/2020.
//

import Foundation
import UIKit

class SkinningExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWidgets()
    }
    
    func reloadPage() {
        removeAllWidgets()
        loadWidgets()
        reloadWidgets()
    }
    
    func loadWidgets() {
        
        getButton("Red", color: UIColor.from(hexString: Config().primaryColor)) {
            Settings.initDefaults(Config())
            self.reloadPage()
        }
        
        getButton("Blue", color: UIColor.from(hexString: ConfigBlue().primaryColor)) {
            Settings.initDefaults(ConfigBlue())
            self.reloadPage()
        }
        
        getButton("Green", color: UIColor.from(hexString: ConfigGreen().primaryColor)) {
            Settings.initDefaults(ConfigGreen())
            self.reloadPage()
        }
     
        addReusableWidget(LabelWidget.self) {
            $0.text.text = "Label widget with a pretty long text that should auto grow. Two lines is really not enough, it has to be more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more ."
        }
        
        addWidget(SwitchWidget.self) {
            $0.text.text = "Switch widget"
            $0.toggle.stateChanged = { (widget, state) in
                print("isOn:", state)
            }
        }
        
        addReusableWidget(ButtonWidget.self) {
            $0.text.text = "Primary color"
            $0.text.font = Settings.Font.with(size: 30, weight: .bold)
            $0.text.color = UIColor.white
            $0.padding.vertical = Settings.Offset.basic
            $0.cornerRadius = 0
            $0.buttonColor = Settings.Color.primary
        }
    }
    
    func getButton(_ text: String, color: UIColor, callback: @escaping () -> Void) {
        addWidget(ButtonWidget.self) {
            $0.text.text = text
            $0.text.font = Settings.Font.with(size: 30, weight: .bold)
            $0.text.color = UIColor.white
            $0.padding.vertical = Settings.Offset.basic
            $0.cornerRadius = 1.0
            $0.buttonColor = color
            $0.click = callback
        }
    }
}

class ConfigBlue: SettingsConfig {
    var primaryColor: String { "0000ff" }
    var textColor: String { "000077" }
    var tintColor: String { "000077" }
}

class ConfigGreen: SettingsConfig {
    var primaryColor: String { "00ff00" }
    var textColor: String { "007700" }
    var tintColor: String { "007700" }
}
