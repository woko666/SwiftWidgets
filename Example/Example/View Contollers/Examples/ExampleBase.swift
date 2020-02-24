//
//  ExampleBase.swift
//  Example
//
//  Created by woko on 19/02/2020.
//

import Foundation
import UIKit
import RxSwift

class ExampleBase: WidgetTableViewController {

    func imageUrl() -> URL {
        return URL(string: String(format: "https://picsum.photos/seed/%d/%d/%d", Int.random(in: 1...9999999), Int.random(in: 4...8) * 100, Int.random(in: 4...8) * 100))!
    }
    
    func addLabel(_ text: String) {
        addReusableWidget(LabelWidget.self) {
            $0.text.text = text
            $0.text.font = Settings.Font.with(size: 14)
        }
    }
}

