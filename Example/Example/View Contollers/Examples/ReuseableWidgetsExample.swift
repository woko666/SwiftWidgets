//
//  ReuseableWidgetsExample.swift
//  Example
//
//  Created by woko on 15/02/2020.
//

import Foundation
import UIKit

class ReuseableWidgetsExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWidgets()
    }
    
    func loadWidgets() {
        (0..<20).forEach { _ in
            addReusableLabel("R", UIColor.red)
            addReusableLabel("G", UIColor.green)
            addReusableLabel("B", UIColor.blue)
            addReusableLabel("Y", UIColor.yellow)
            addReusableLabel("P", UIColor.systemPink)
            addReusableLabel("B", UIColor.brown)
            addReusableLabel("B", UIColor.black)
            addReusableLabel("P", UIColor.purple)
            addReusableLabel("W", UIColor.lightGray)
        }
    }
        
    func addReusableLabel(_ name: String, _ color: UIColor) {
        addReusableWidget(LabelWidget.self) {
            $0.text.text = "Reusable widget " + name
            $0.text.color = color
            $0.text.font = Settings.Font.with(size: 20)
            $0.tap = { instance in
                instance.imodel.accessory.type = [AccessoryType.activityIndicator, AccessoryType.checkmark, AccessoryType.disclosureIndicator].randomElement() ?? .none
                instance.imodel.accessory.color = UIColor(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1.0)
                instance.updateAccessory()
            }
        }
    }
}

