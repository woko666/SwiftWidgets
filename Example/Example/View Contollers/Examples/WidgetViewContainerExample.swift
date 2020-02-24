//
//  WidgetViewControllerExample.swift
//  Example
//
//  Created by woko on 07/02/2020.
//

import Foundation
import UIKit
import SnapKit

class WidgetViewContainerExample: UIViewController {
    let mainView = VerticalWidgetViewContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainView)
        mainView.verticalAlignment = .center
        mainView.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
                $0.left.right.equalToSuperview()
            } else {
                $0.edges.equalToSuperview()
            }
        }
        view.backgroundColor = .white
        
        loadWidgets()
    }
    
    func loadWidgets() {
        mainView.addWidget(ButtonWidget.self) {
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
        
        mainView.addWidget(LabelWidget.self) {
            $0.text.text = "Different font and text color."
            $0.text.font = Settings.Font.with(size: 45)
            $0.text.color = Settings.Color.darkGray
            $0.text.alignment = .center
            $0.tap = { _ in
                print("Text tapped")
            }
        }
        
        mainView.addWidget(LabelWidget.self) {
            $0.text.htmlText = "Different <i>font</i> <a href=\"https://google.com\">and</a> <span style='color: #ff0000;'>text</span> <b>HTML</b>."
            $0.text.font = Settings.Font.with(size: 45)
            $0.text.color = Settings.Color.darkGray
            $0.text.alignment = .center
            $0.tap = { _ in
                print("Text tapped")
            }
        }
        
        mainView.addWidget(SwitchWidget.self) {
            $0.text.text = "Switch widget"
            $0.toggle.stateChanged = { (widget, state) in
                print("isOn:", state)
            }
        }
        
        mainView.addWidget(TextFieldWidget.self) {
            $0.placeholder.text = "Enter text here"
            $0.color.content = Settings.Color.lightGray
            $0.textInput.textChanged = { (widget, text) in
                print("text:", text)
            }
        }
        
        mainView.layoutWidgets()
    }
}

