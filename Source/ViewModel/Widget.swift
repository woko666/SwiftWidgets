//
//  SW.swift
//  Example
//
//  Created by woko on 07/12/2019.
//

import Foundation
import UIKit

open class Widget: UIView {
    public var imodel: WidgetModel!
    
    // MARK: References to parent objects
    public weak var parentCell: WidgetTableViewCell?
    public weak var parentContainer: WidgetContainer?
    
    // MARK: Core properties
    public var paddingView: UIView?
    public var contentView: UIView?
    @IBOutlet public var leftMarginConstraint: NSLayoutConstraint?
    @IBOutlet public var rightMarginConstraint: NSLayoutConstraint?
    @IBOutlet public var topMarginConstraint: NSLayoutConstraint?
    @IBOutlet public var botMarginConstraint: NSLayoutConstraint?
    @IBOutlet public var leftPaddingConstraint: NSLayoutConstraint?
    @IBOutlet public var rightPaddingConstraint: NSLayoutConstraint?
    @IBOutlet public var topPaddingConstraint: NSLayoutConstraint?
    @IBOutlet public var botPaddingConstraint: NSLayoutConstraint?
    public var separator: UIView?
    public var accessoryView: UIView?
    public var tapRecognizer: UITapGestureRecognizer?
    
    public var forceClickable: Bool = false
    public var forceInteractible: Bool = false
    public var isInteractible: Bool {
        @available(*, unavailable)
        get {
            fatalError("This property is set-only (sets isUserInteractionEnabled on widget and parent cell")
        }
        set {
            isUserInteractionEnabled = newValue
            parentCell?.isUserInteractionEnabled = newValue
        }
    }
    
    // MARK: Dimensions
    public var heightOrAuto: CGFloat {
        if let height = imodel.height {
            return CGFloat(height)
        }
        return UITableView.automaticDimension
    }
    
    public var fullscreenInnerHeight: Float {
        if let height = imodel.height {
            return height - imodel.padding.top - imodel.margin.top - imodel.padding.bottom - imodel.margin.bottom
        }
        return 0
    }

    public var fullscreenInnerWidth: Float {
        var res: Float = parentContainer?.containerWidth ?? Float(frame.width)
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            res -= Float(window.safeAreaInsets.left + window.safeAreaInsets.right)
        }
        
        return res
    }
    
    // MARK: Dimensions changed
    open func updateHeight() {
        parentContainer?.widgetHeightUpdated()
        //parentContainer?.refreshTable()
    }
    
    open func updateHeight(_ animate: Bool) {
        parentContainer?.widgetHeightUpdated(animate)
        //parentContainer?.refreshTable(animate)
    }
    
    // MARK: Embed in view
    open func embedIn(_ view: UIView) {
        ensureLoad()
        removeFromSuperview()
        view.addSubview(self)
        snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Init from model
    open func initFromModel() {
        translatesAutoresizingMaskIntoConstraints = false
        
        updateCoreProperties()
        updateSeparator()
        updateAccessory()
    }
    
    // MARK: Creation
    public class var className: String {
        //return NSStringFromClass(self).components(separatedBy: ".").last!
        return "\(self)"
    }
    
    public var instanceName: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    public class var xibName: String? {
        return hasXib(className)
    }
    
    public var xibInstanceName: String? {
        return instanceHasXib(instanceName)
    }
    
    public func instanceHasXib(_ name: String) -> String? {
        if Bundle(for: type(of: self)).path(forResource: name, ofType: "nib") != nil {
            return name
        }
        return nil
    }
    
    public class func hasXib(_ name: String) -> String? {
        if Bundle(for: self).path(forResource: name, ofType: "nib") != nil {
            return name
        }
        return nil
    }
    
    public class func create() -> Widget {
        if let xib = xibName {
            if let widgets = Bundle(for: self).loadNibNamed(xib, owner: nil, options: nil), let widget = widgets.last as? Widget {
                widget.afterXibLoaded()
                return widget
            }
        }
        
        let obj = self.init()
        obj.build()
        return obj
    }
    
    open func createInstance() -> Widget {
        if let xib = xibInstanceName {
            if let widgets = Bundle(for: type(of: self)).loadNibNamed(xib, owner: nil, options: nil), let widget = widgets.last as? Widget {
                widget.afterXibLoaded()
                return widget
            }
        }
        
        let obj = type(of: self).init()
        obj.build()
        return obj
    }
    
    // build if loading from code
    open func build() {
        assert(Self.xibName != nil, String(format: "Widget %@ has no xib file and no view definition in build method! Try to implement a build method (don't call super.build()) or add a xib file named %@.", Self.className, Self.xibName ?? ""))
    }
    
    // setup constraints when loading from a xib
    open func afterXibLoaded() {
        guard subviews.count == 1, let subview = subviews.first else { return }

        subview.removeFromSuperview()
        addContentView(subview)
    }
        
    // MARK: Lifecycle
    // Load data from model to widget
    public var wasLoaded = false
    open func ensureLoad() {
        if !wasLoaded {
            load()
        }
    }
    
    public var isClickable: Bool {
        return imodel.tap != nil || forceClickable
    }
    
    // Load the widget from model. Is only called once in the widget lifecycle.
    open func load() {
        let clickable = isClickable
        
        // selected color is only applicable when in a parent cell (table view)
        if clickable && imodel.color.selected.alpha > 0 {
            let selectedBackground = UIView(frame: self.bounds)
            selectedBackground.backgroundColor = imodel.color.selected
            parentCell?.selectedBackgroundView = selectedBackground
            parentCell?.selectionStyle = .default
        } else {
            parentCell?.selectedBackgroundView = nil
            parentCell?.selectionStyle = .none
        }
        
        // if standalone - install a gesture recognizer
        if clickable && parentCell == nil {
            addTapGestureRecognizer()
        }
        
        isInteractible = clickable || forceInteractible
        
        initFromModel()
        
        wasLoaded = true
    }
    
    // Widget was attached to a WidgetTableViewCell. Update cell properties here. Can be called multiple times (attached to multiple cells).
    open func attachedToCell() {
        isInteractible = isClickable || forceInteractible
        botMarginConstraint?.priority = .defaultHigh // if tableview controller computes UIView-Encapsulated-Layout-Height we need one lower priority constraint
    }
    
    // MARK: Actions
    open func addTapGestureRecognizer() {
        guard tapRecognizer == nil else { return }
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(run))
        singleTap.cancelsTouchesInView = false
        //singleTap.delegate = self
        addGestureRecognizer(singleTap)
        
        isInteractible = true
        
        tapRecognizer = singleTap
    }
    
    @objc open func run() {
        onTap()
    }
    
    open func onTap() {
        imodel.tap?(self)
    }
    
    open func sizeUpdated() {
        
    }
    
    // MARK: Misc
    override open func action(for layer: CALayer, forKey event: String) -> CAAction? {
        class MyAction: CAAction {
            init(view: Widget, nextAction: CAAction?, callback: (() -> Void)?) {
                self.view = view
                self.nextAction = nextAction
                self.callback = callback
            }
            let view: Widget
            let nextAction: CAAction?
            let callback: (() -> Void)?
            
            func run(forKey event: String, object: Any, arguments: [AnyHashable : Any]?) {
                callback?()
                nextAction?.run(forKey: event, object: object, arguments: arguments)
            }
        }

        let action = super.action(for: layer, forKey: event)
        if event == "position" {
            return MyAction(view: self, nextAction: action, callback: { [weak self] in
                self?.sizeUpdated()
            })
        } else {
            return action
        }
    }
}
