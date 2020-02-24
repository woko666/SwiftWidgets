//
//  ImageComponent.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import Foundation
import UIKit
import Kingfisher

open class ImageComponent: WidgetComponent {
    public typealias Target = UIImageView
    public typealias VM = ImageComponentModel
    public typealias WM = WidgetModel
    
    public var imageLoaded: (() -> Void)?
    
    public init() { }
    
    func onImageLoaded(target: Target, model: VM) {
        if let image = target.image {
            target.image = image.withRenderingMode(model.tintColor != nil ? .alwaysTemplate : .alwaysOriginal)
        }
        imageLoaded?()
    }
    
    public func setup(target: Target, model: VM, widgetModel: WM) {
        target.kf.cancelDownloadTask()
        
        target.tintColor = model.tintColor
        target.clipsToBounds = true
        target.contentMode = model.contentMode
        model.setup?(target)
        if let image = model.image {
            target.image = image
            onImageLoaded(target: target, model: model)
        } else if let url = model.imageUrl {            
            target.image = model.placeholder
            
            target.kf.indicatorType = model.activityIndicator ? .activity : .none
            target.kf.setImage(with: url, placeholder: model.placeholder) { [weak self] result in
                switch result {
                case .success:
                    self?.onImageLoaded(target: target, model: model)
                case .failure:
                    target.image = model.error
                }
            }
        } else {
            target.image = UIImage()
        }
    }
}

open class ImageComponentModel {
    public var contentMode: UIView.ContentMode = .scaleAspectFill
    public var image: UIImage?
    public var imageUrl: URL?
    public var placeholder: UIImage?
    public var error: UIImage?
    public var activityIndicator: Bool = false
    public var tintColor: UIColor?
    public var setup: ((UIImageView) -> Void)?
    
    public init() { }
}
