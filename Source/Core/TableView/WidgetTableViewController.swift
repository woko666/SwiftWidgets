//
//  WidgetTableViewController.swift
//  Example
//
//  Created by woko on 08/12/2019.
//

import Foundation
import UIKit

open class WidgetTableViewController: UIViewController, WidgetTableViewControllerBase {
    public var animateUpdates: Bool = true
    public var widgets: [Widget]  = []
    public var hiddenWidgets: [Widget] = []
    public var managedIndices: [WidgetIndex] = []
    
    public var containerWidth: Float {
        return Float(tableView.frame.width)
    }
    
    public var tableView: UITableView!
 
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // dark mode compatible color
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = UIColor.white
        }
    
        if tableView == nil {
            tableView = UITableView()
            tableView.backgroundColor = UIColor.clear
            tableView.addWithConstraintsTo(view)
        }
    
        if tableView.delegate == nil {
            tableView.delegate = self
        }
        
        if tableView.dataSource == nil {
            tableView.dataSource = self
        }
    
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
    }
    
    open func widgetHeightUpdated(_ animate: Bool?) {
        if let animate = animate {
            refreshTable(animate)
        } else {
            refreshTable()
        }
    }
}

// MARK: UITableViewDelegate
extension WidgetTableViewController: UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return widgets.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let widget = resolveWidget(indexPath.row) else {
            return WidgetTableViewCell()
        }
        
        if widget.imodel.isReusable {
            if let reusedCell = tableView.dequeueReusableCell(withIdentifier: type(of: widget).className + "Reusable") as? WidgetTableViewCell, let widgetWithView = reusedCell.widget {
                widgetWithView.imodel = widget.imodel
                widgetWithView.parentContainer = self
                widgetWithView.load()
                widgetWithView.attachedToCell()
                return reusedCell
            } else {
                let widgetWithView = getWidgetWithModel(widget)
                let cell = tableViewCellWithWidget(widgetWithView, isReusable: true)
                widgetWithView.parentContainer = self
                widgetWithView.load()
                widgetWithView.attachedToCell()
                return cell
            }
        } else {
            let cell = tableViewCellWithWidget(widget, isReusable: false)
            widget.parentContainer = self
            widget.ensureLoad()
            widget.attachedToCell()
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear // https://developer.apple.com/documentation/uikit/uitableviewdelegate/1614883-tableview
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let widget = resolveWidget(indexPath.row) else {
            return 0
        }
        
        return widget.heightOrAuto
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let widget = resolveWidget(indexPath.row) else {
            return 0
        }
        
        return widget.heightOrAuto
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let widget = resolveWidget(indexPath.row) else { return }
        
        if widget.imodel.isReusable {
            if let cell = tableView.cellForRow(at: indexPath) as? WidgetTableViewCell, let widgetInstance = cell.widget {
                widgetInstance.onTap()
            }
        } else {
            widget.onTap()
        }
        
        if let index = getWidgetIndex(widget) {
            tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: false)
        }
    }
}
