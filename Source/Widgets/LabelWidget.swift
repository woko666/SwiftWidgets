//
//  LabelWidget.swift
//  Example
//
//  Created by woko on 08/12/2019.
//

import Foundation
import UIKit
import Nantes

open class LabelWidget: Widget, WidgetInstantiable {
    public typealias Model = LabelWidgetModel
    
    public lazy var mainLabel: NantesLabel = {
        let view = NantesLabel.init(frame: .zero)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open override func build() {
        let contentView = UIView()
        contentView.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainLabel.delegate = self
        mainLabel.isUserInteractionEnabled = true
        addContentView(contentView)
        
        forceInteractible = true
    }
    
    open override func load() {
        super.load()
        
        LabelComponent().setup(target: mainLabel, model: model.text, widgetModel: model)
    }
}

extension LabelWidget: NantesLabelDelegate {
    public func attributedLabel(_ label: NantesLabel, didSelectLink link: URL) {
        if let onLinkSelected = model.onLinkSelected, onLinkSelected(link) {
            // link already handled
        } else {
            UIApplication.shared.open(link, options: [:], completionHandler: nil)
        }
    }
}

open class LabelWidgetModel: WidgetModel {
    public var text = LabelComponentModel()
    public var onLinkSelected: ((URL) -> Bool)?
}
