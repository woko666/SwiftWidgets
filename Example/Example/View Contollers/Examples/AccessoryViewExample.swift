//
//  AccessoryViewExample.swift
//  Example
//
//  Created by woko on 15/02/2020.
//

import Foundation
import UIKit

class AccessoryViewExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWidgets()
    }
    
    func loadWidgets() {
        addWidget(LabelWidget.self) {
            $0.text.text = "Accessory image"
            $0.accessory.image = #imageLiteral(resourceName: "like")
        }

        addWidget(LabelWidget.self) {
            $0.text.text = "Tinted Accessory image"
            $0.accessory.image = #imageLiteral(resourceName: "cancelButton")
            $0.accessory.color = UIColor.blue
        }

        addWidget(LabelWidget.self) {
            $0.text.text = "Accessory view"
            let view = UIView()
            view.backgroundColor = Settings.Color.primary
            $0.accessory.view = view
        }
        
        do {
            let view = UIView()
            view.backgroundColor = .red
            let widget = addWidget(LabelWidget.self) {
                $0.text.text = "Change size, padding and color of the\naccessory view after 5 seconds"
                $0.accessory.view = view
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                view.backgroundColor = .blue
                widget.model.accessory.rightPadding = 10
                widget.model.accessory.size = CGSize(width: 25, height: 40)
                widget.updateAccessory()
            }
        }
        
        addWidget(LabelWidget.self) {
            $0.text.text = "Accessory activityIndicator"
            $0.accessory.type = .activityIndicator
        }
        
        addWidget(LabelWidget.self) {
            $0.text.text = "Accessory checkmark"
            $0.accessory.type = .checkmark
        }
        
        addWidget(LabelWidget.self) {
            $0.text.text = "Accessory disclosureIndicator"
            $0.accessory.type = .disclosureIndicator
        }
    }
}

