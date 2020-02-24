//
//  EmbeddedWidgetsExample.swift
//  Example
//
//  Created by woko on 07/02/2020.
//

import Foundation
import UIKit
import SnapKit

class EmbeddedWidgetsExample: ExampleBase {
    let maker = WidgetCreator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        loadWidgets()
    }
    
    func loadWidgets() {
        do {
            let parent = UIView()
            view.addSubview(parent)
            parent.snp.makeConstraints {
                $0.left.equalToSuperview()
                if #available(iOS 11.0, *) {
                    $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
                } else {
                    $0.top.equalToSuperview()
                }
                $0.width.equalTo(150)
                $0.height.equalTo(60)
            }
   
            getButton().embedIn(parent)
        }
        
        do {
            let parent = UIView()
            view.addSubview(parent)
            parent.snp.makeConstraints {
                $0.right.equalToSuperview()
                if #available(iOS 11.0, *) {
                    $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
                } else {
                    $0.top.equalToSuperview()
                }
                $0.width.equalTo(100)
                $0.height.equalTo(200)
            }

            getButton().embedIn(parent)
        }
        
        do {
            let parent = UIView()
            view.addSubview(parent)
            parent.snp.makeConstraints {
                $0.left.equalToSuperview()
                if #available(iOS 11.0, *) {
                    $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
                } else {
                    $0.top.equalToSuperview()
                }
                $0.width.equalTo(150)
                $0.height.equalTo(60)
            }
   
            getButton().embedIn(parent)
        }
        
        do {
            let parent = UIView()
            view.addSubview(parent)
            parent.snp.makeConstraints {
                $0.right.equalToSuperview()
                if #available(iOS 11.0, *) {
                    $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
                } else {
                    $0.bottom.equalToSuperview()
                }
                $0.width.equalTo(200)
                $0.height.equalTo(100)
            }

            getButton().embedIn(parent)
        }
        
        do {
            let parent = UIView()
            view.addSubview(parent)
            parent.snp.makeConstraints {
                $0.left.equalToSuperview()
                if #available(iOS 11.0, *) {
                    $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
                } else {
                    $0.bottom.equalToSuperview()
                }
                $0.width.equalTo(200)
                $0.height.equalTo(80)
            }

            getButton().embedIn(parent)
        }
        
        do {
            let parent = UIView()
            view.addSubview(parent)
            parent.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview()
                $0.width.equalTo(250)
                $0.height.equalTo(80)
            }

            getButton().embedIn(parent)
        }
    }
    
    func getButton() -> ButtonWidget {
        return maker.getWidget(ButtonWidget.self) {
            $0.text.text = "Button"
            $0.text.font = Settings.Font.with(size: 30, weight: .bold)
            $0.text.color = UIColor.white
            $0.padding.vertical = Settings.Offset.basic
            $0.cornerRadius = 1.0
            $0.buttonColor = UIColor.randomDarkColor
            $0.disabledTextColor = UIColor.black
            $0.separator.enabled = false
            $0.tap = { _ in
                print("Button tapped")
            }
        }
    }
}

