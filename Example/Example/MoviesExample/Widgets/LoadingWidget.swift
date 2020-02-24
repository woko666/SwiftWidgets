//
//  LoadingWidget.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation
import UIKit
import SnapKit

open class LoadingWidget: Widget, WidgetInstantiable {
    public typealias Model = WidgetModel
    let progress: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    public override func build() {
        let contentView = UIView()
        contentView.addSubview(progress)
        progress.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        addContentView(contentView)
    }
    
    override public func load() {
        super.load()
        
        progress.color = model.accessory.color
        progress.startAnimating()
    }
}
