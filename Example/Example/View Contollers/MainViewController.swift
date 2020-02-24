//
//  MainViewController.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import UIKit

class MainViewController: WidgetTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SwiftWidgets Example"
        
        loadWidgets()
    }
    
    func loadWidgets() {
        addHeader("Core Widgets")
        addButton("Quick start", QuickstartExample.self)
        addButton("Images", ImagesExample.self) // image
        addButton("Text", TextsExample.self) // label
        addButton("Input", InputExample.self) // text field, area, toggle
        addButton("Buttons", ButtonsExample.self)
        addButton("Accessory views", AccessoryViewExample.self)
        addButton("Reusable widgets", ReuseableWidgetsExample.self) // text field, area, toggle
        
        addHeader("Table View")
        addButton("Show, hide, insert, remove widgets", ShowHideInsertRemoveWidgets.self)
        addButton("Skinning widgets", SkinningExample.self)
        
        addHeader("Widget Containers")
        addButton("Widgets in a view container", WidgetViewContainerExample.self)
        addButton("Widgets embedded in a view", EmbeddedWidgetsExample.self)
        addButton("Widgets in another widget", ContainerWidgetExample.self)
        addButton("Horizontal scroll & stack container", HorizontalContainersExample.self)
        
        addHeader("Custom Widgets")
        addButton("Image & text", CustomWidgetExample.self)
        
        addHeader("Example Apps")
        addButton("Movie list", MovieListViewController.self)
    }
    
    func addHeader(_ text: String) {
        addReusableWidget(LabelWidget.self) {
            $0.text.text = text
            $0.text.font = Settings.Font.with(size: 25)
            $0.text.color = UIColor.white
            $0.text.alignment = .center
            $0.color.background = Settings.Color.primary
            $0.padding.vertical = Settings.Offset.basic
            $0.separator.enabled = false
        }
    }
    
    func addButton(_ text: String, _ vcType: UIViewController.Type) {        
        addReusableWidget(LabelWidget.self) {
            $0.text.text = text
            $0.padding.vertical = Settings.Offset.basic
            $0.tap = { _ in
                let vc = vcType.init()
                vc.title = self.title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

