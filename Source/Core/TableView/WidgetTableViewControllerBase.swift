//
//  WidgetTableViewControllerBase.swift
//  Example
//
//  Created by woko on 08/12/2019.
//

import Foundation
import UIKit

public protocol WidgetTableViewControllerBase: WidgetContainer, UITableViewDataSource, UITableViewDelegate {
    var animateUpdates: Bool { get set }
    var hiddenWidgets: [Widget] { get set }
    var managedIndices: [WidgetIndex] { get set }
    
    var tableView: UITableView! { get set }
}

public extension WidgetTableViewControllerBase {    
    func replaceWidgets(_ callback: () -> Void) {
        removeAllWidgets()
        callback()
        reloadWidgets()
    }
    
    func reloadWidgets() {
        animateBlock {
            self.tableView.reloadData()
        }
    }
    
    func refreshTable() {
        animateBlock {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    func refreshTable(_ animate: Bool) {
        animateBlock(animate) {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    /*func executeAnimation(callback: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            callback()
        })
    }*/
    
    func animateBlock(_ animate: Bool, callback: @escaping () -> Void) {
        if animateUpdates {
            //executeAnimation(callback: callback)
            callback()
        } else {
            UIView.performWithoutAnimation(callback)
        }
    }
    
    func animateBlock(_ callback: @escaping () -> Void) {
        animateBlock(animateUpdates, callback: callback)
    }
    
    func resolveWidget(_ row: Int) -> Widget? {
        guard let widget = widgets[safe: row], !hiddenWidgets.contains(widget) else { return nil }
        
        return widget
    }
    
    func tableViewCellWithWidget(_ widget: Widget, isReusable: Bool) -> WidgetTableViewCell {
        let cell = WidgetTableViewCell(style: .default, reuseIdentifier: type(of: widget).className + (isReusable ? "Reusable" : "Static"))
        cell.widget = widget
        return cell
    }
    
    func getWidget(at index: Int) -> Widget? {
        return widgets[safe: index]
    }
    
    func getWidgetIndex(_ widget: Widget) -> Int? {
        return widgets.firstIndex(of: widget)
    }
    
    // MARK: Show widgets
    func showWidgets(at indices: [Int], animation: UITableView.RowAnimation = .automatic) {
        var changedIndices: [Int] = []
        indices.forEach { index in
            guard let widget = widgets[safe: index], hiddenWidgets.contains(widget) else { return }
        
            hiddenWidgets.removeAll(where: { $0 == widget })
            widget.isHidden = false
            changedIndices.append(index)
        }
        
        tableView.reloadRows(at: changedIndices.map { IndexPath(row: $0, section: 0) }, with: animateUpdates ? animation : .none)
    }
    
    func showWidget(at index: WidgetIndex, animation: UITableView.RowAnimation = .automatic) {
        if let index = index.index {
            showWidget(at: index, animation: animation)
        }
    }
    
    func showWidget(at index: Int, animation: UITableView.RowAnimation = .automatic) {
        showWidgets(at: [index], animation: animation)
    }
    
    func showWidgets(_ widgets: [Widget], animation: UITableView.RowAnimation = .automatic) {
        var indices: [Int] = []
        widgets.forEach { widget in
            if hiddenWidgets.contains(widget), let index = self.widgets.firstIndex(of: widget) {
                indices.append(index)
            }
        }
        showWidgets(at: indices, animation: animation)
    }
    
    func showWidget(_ widget: Widget, animation: UITableView.RowAnimation = .automatic) {
        if let index = widgets.firstIndex(of: widget) {
            showWidget(at: index, animation: animation)
        }
    }
    
    // MARK: Hide widgets
    func hideWidgets(at indices: [Int], animation: UITableView.RowAnimation = .automatic) {
        indices.forEach { index in
            guard let widget = widgets[safe: index], !hiddenWidgets.contains(widget) else { return }
        
            hiddenWidgets.append(widget)
            widget.isHidden = true
        }
        
        // reload shown indices to force redraw (necessary when widgets were hidden before being viewed for the first time)
        let indexPaths = Set(indices).map { IndexPath(row: $0, section: 0) }
        animateBlock {
            self.tableView.reloadRows(at: indexPaths, with: animation)
        }
    }
    
    func hideWidget(at index: WidgetIndex, animation: UITableView.RowAnimation = .automatic) {
        if let index = index.index {
            hideWidgets(at: [index], animation: animation)
        }
    }
    
    func hideWidget(at index: Int, animation: UITableView.RowAnimation = .automatic) {
        hideWidgets(at: [index], animation: animation)
    }
    
    func hideWidgets(_ widgets: [Widget], animation: UITableView.RowAnimation = .automatic) {
        var indices: [Int] = []
        widgets.forEach { widget in
            if !hiddenWidgets.contains(widget), let index = self.widgets.firstIndex(of: widget) {
                indices.append(index)
            }
        }
        hideWidgets(at: indices, animation: animation)
    }
    
    func hideWidget(_ widget: Widget, animation: UITableView.RowAnimation = .automatic) {
        if let index = widgets.firstIndex(of: widget) {
            hideWidget(at: index, animation: animation)
        }
    }
    
    // MARK: Insert / remove widgets
    func insertWidget(_ widget: Widget, index: WidgetIndex, animation: UITableView.RowAnimation = .bottom) {
        if let index = index.index {
            insertWidget(widget, index: index, animation: animation)
        }
    }
    
    func insertWidget(_ widget: Widget, index: Int, animation: UITableView.RowAnimation = .bottom) {
        if index >= widgets.count {
            widgets.append(widget)
            reloadWidgets()
        } else {
            let finalIndex = max(0, index)
            widgets.insert(widget, at: finalIndex)
            
            managedIndices.forEach { widgetIndex in
                if let index = widgetIndex.index, finalIndex < index {
                    widgetIndex.index = index + 1
                }
            }

            animateBlock {
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath(row: finalIndex, section: 0)], with: animation)
                self.tableView.endUpdates()
            }
        }
    }

    func removeAllWidgets() {
        widgets.removeAll()
    }

    func removeWidget(at index: WidgetIndex, animation: UITableView.RowAnimation = .bottom) {
        if let index = index.index {
            removeWidget(at: index, animation: animation)
        }
    }
    
    func removeWidget(at index: Int, animation: UITableView.RowAnimation = .bottom) {
        widgets.remove(at: index)

        animateBlock {
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: animation)
            self.tableView.endUpdates()
        }
    }

    func removeWidgets(at indices: [Int], animation: UITableView.RowAnimation = .bottom) {
        widgets.remove(at: indices)

        let filteredIndices = Array(Set(indices).sorted(by: >))
        let indexPaths = filteredIndices.map { IndexPath(row: $0, section: 0) }
        
        removeIndicesWithValues(filteredIndices)
        managedIndices.forEach { widgetIndex in
            filteredIndices.forEach {
                if let index = widgetIndex.index, $0 < index {
                    widgetIndex.index = index - 1
                }
            }
        }

        self.animateBlock({
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: indexPaths, with: animation)
            self.tableView.endUpdates()
        })
    }

    func removeWidget(_ widget: Widget, animation: UITableView.RowAnimation = .bottom) {
        if let index = widgets.firstIndex(of: widget) {
            removeWidget(at: index, animation: animation)
        }
    }
    
    func replaceWidget(_ widget: Widget, at index: WidgetIndex, animation: UITableView.RowAnimation = .fade) {
        guard let index = index.index else { return }
        
        replaceWidget(widget, at: index, animation: animation)
    }
    
    func replaceWidget(_ widget: Widget, at index: Int, animation: UITableView.RowAnimation = .fade) {
        if index < widgets.count {
            let finalIndex = max(0, index)
            widgets[finalIndex] = widget

            animateBlock {
                self.tableView.reloadRows(at: [IndexPath(row: finalIndex, section: 0)], with: animation)
            }
        }
    }
    
    func replaceWidget(_ widget: Widget, with: Widget, animation: UITableView.RowAnimation = .fade) {
        if let index = widgets.firstIndex(of: widget) {
            replaceWidget(with, at: index, animation: animation)
        }
    }

    // MARK: Indices
    var currentIndex: WidgetIndex? {
        return getIndex(widgets.count - 1)
    }
    
    func getIndex(_ index: Int) -> WidgetIndex? {
        guard index >= 0 && index < widgets.count else { return nil }
        
        let widgetIndex = WidgetIndex(index)
        managedIndices.append(widgetIndex)
        return widgetIndex
    }
    
    func removeIndex(_ index: WidgetIndex) {
        managedIndices.removeAll(where: { $0 == index })
    }
    
    func removeIndicesWithValues(_ values: [Int]) {
        managedIndices = managedIndices.filter { !values.contains($0.index ?? -1)  }
    }
}
