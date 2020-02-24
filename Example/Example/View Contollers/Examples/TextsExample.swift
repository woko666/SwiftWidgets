//
//  TextsExample.swift
//  Example
//
//  Created by woko on 14/02/2020.
//

import Foundation
import UIKit

class TextsExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWidgets()
    }
    
    func loadWidgets() {
        addReusableWidget(LabelWidget.self) {
            $0.text.text = "Label widget with a pretty long text that should auto grow. Two lines is really not enough, it has to be more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more and more ."
        }

        addReusableWidget(LabelWidget.self) {
            $0.text.text = "Different font and text color."
            $0.text.font = Settings.Font.with(size: 45)
            $0.text.color = Settings.Color.darkGray
            $0.text.alignment = .center
            $0.tap = { _ in
                print("Text tapped")
            }
        }
        
        addReusableWidget(LabelWidget.self) {
            $0.text.htmlText = "Different <i>font</i> <a href=\"https://google.com\">and</a> <span style='color: #ff0000;'>text</span> <b>HTML</b>."
            $0.text.font = Settings.Font.with(size: 45)
            $0.text.color = Settings.Color.darkGray
            $0.text.alignment = .center
            $0.tap = { _ in
                print("Text tapped")
            }
        }
        
        addWidget(LabelWidget.self) {
            $0.text.htmlText = "<strong>Strong formatting</strong><br/>And some regular text with more <b>bo</b>ld text with testing <i>italic</i> link <a href='https://google.com'>google.com</a>. More italics: <i>Elize Ryd</i> <i>Jes</i><i>per</i> Strömblad and also an e-mail <a href='mailto:random@gmail.com'>random@gmail.com</a> or CALL <a href='tel:+420777123456'>+420 777 123 456</a> and done. <span style='color: rgb(0, 0, 255);'>blue</span>, <font color='red'>red </font> and also some more text with an additional dose of <span style='color: #ff0000;'>red</span> color."
        }
        
        addWidget(LabelWidget.self) {
            $0.text.htmlText = "<strong>Handling links manually:</strong> <a href='https://google.com'>google.com</a> and e-mail <a href='mailto:random@gmail.com'>random@gmail.com</a> or phone <a href='tel:+420777123456'>+420 777 123 456</a>."
            $0.onLinkSelected = { url in
                print(url)
                return false
            }
        }
        
        addReusableWidget(LabelWidget.self) {
            $0.text.text = "Margin and padding."
            $0.text.font = Settings.Font.with(size: 25)
            $0.text.color = Settings.Color.primary
            $0.text.alignment = .center
            $0.margin.all = Settings.Offset.basic2
            $0.padding.all = Settings.Offset.basic2
            $0.color.background = UIColor.yellow
            $0.color.padding = UIColor.blue
            $0.color.content = UIColor.green
        }
    }
}

