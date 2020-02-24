//
//  ShowHideInsertRemoveWidgets.swift
//  Example
//
//  Created by woko on 05/02/2020.
//

import Foundation

class ShowHideInsertRemoveWidgets: ExampleBase {
    let numWidgets = 3
    var removedWidgets: [Int: Widget] = [:]
    var widgetsToRemove: [Int: Widget] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        loadWidgets()
    }
    
    func loadWidgets() {
        addReusableWidget(SwitchWidget.self) {
            $0.text.text = "Animate updates"
            $0.toggle.isOn = animateUpdates
            $0.toggle.stateChanged = { [weak self] (widget, state) in
                self?.animateUpdates = state
            }
        }
        
        // widgets to manipulate
        (1...numWidgets).forEach { index in
            widgetsToRemove[index] = addWidget(LabelWidget.self) {
                $0.color.background = Settings.Color.lightGray
                $0.text.text = "Label \(index)"
                $0.text.font = Settings.Font.with(size: 30)
                $0.padding.vertical = Settings.Offset.basic
            }
        }
        
        (1...numWidgets).forEach { index in
            addButton("Hide label \(index)") {
                if self.removedWidgets[index] == nil {
                    self.hideWidget(at: self.getIndexToInsert(index))
                }
            }
        }
        
        (1...numWidgets).forEach { index in
            addButton("Show label \(index)") {
                if self.removedWidgets[index] == nil {
                    self.showWidget(at: self.getIndexToInsert(index))
                }
            }
        }
        
        (1...numWidgets).forEach { index in
            addButton("Remove label \(index)") {
                if self.removedWidgets[index] == nil, let widget = self.widgetsToRemove[index] {
                    self.removeWidget(widget)
                    self.removedWidgets[index] = widget
                }
            }
        }
        
        (1...numWidgets).forEach { index in
            addButton("Insert label \(index)") {
                if let widget = self.removedWidgets[index] {
                    self.insertWidget(widget, index: self.getIndexToInsert(index))
                    self.removedWidgets[index] = nil
                }
            }
        }
    }
    
    func getIndexToInsert(_ index: Int) -> Int {
        var offset = 0
        for i in 1...numWidgets {
            if i < index && removedWidgets[i] != nil {
                offset -= 1
            } else if i == index {
                return index + offset
            }
        }
        return index
    }
    
    func addButton(_ text: String, _ callback: @escaping () -> Void) {
        addReusableWidget(LabelWidget.self) {
            $0.text.text = text
            $0.tap = { _ in
                callback()
            }
        }
    }

}
