//
//  SwitchWidget.swift
//  Example
//
//  Created by woko on 04/02/2020.
//

import Foundation
import UIKit
import SnapKit

open class SwitchWidget: Widget, WidgetInstantiable {
    public typealias Model = SwitchWidgetModel
    
    public lazy var mainLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        return view
    }()
    
    public lazy var switchView: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    public var toggle = ToggleComponent()
    
    open override func onTap() {
        toggle.toggle()
        super.onTap()
    }
    
    open override func build() {
        forceClickable = true
        
        let contentView = UIView()
        contentView.isUserInteractionEnabled = true
        contentView.addSubview(mainLabel)
        contentView.addSubview(switchView)
        
        mainLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.right.equalTo(switchView.snp.left)
        }
        
        switchView.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
        }
        
        addContentView(contentView)
    }
    
    open override func load() {
        super.load()
        
        paddingView?.isUserInteractionEnabled = true
        contentView?.isUserInteractionEnabled = true
        
        LabelComponent().setup(target: mainLabel, model: model.text, widgetModel: model)
        toggle.setup(target: switchView, model: model.toggle, widgetModel: model, widget: self)
    }
}

open class SwitchWidgetModel: WidgetModel {
    public var text = LabelComponentModel()
    public var toggle = ToggleComponentModel()
}
