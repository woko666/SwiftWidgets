//
//  ImageWidget.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import Foundation
import UIKit

open class ImageWidget: Widget, WidgetInstantiable {
    public typealias Model = ImageWidgetModel
    
    public lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let comp = ImageComponent()
    public var heightConstraint: NSLayoutConstraint?
    
    open override func build() {
        addContentView(imageView)
    }
    
    open override func load() {
        super.load()
        
        heightConstraint?.isActive = false
        
        comp.imageLoaded = nil
        if model.height == nil && model.width == nil {
            if heightConstraint == nil {
                let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
                imageView.addConstraint(heightConstraint)
                self.heightConstraint = heightConstraint
            }
            heightConstraint?.isActive = true
            heightConstraint?.constant = model.image.placeholder?.size.height ?? CGFloat(model.defaultHeight)
            
            if let url = model.image.imageUrl, let size = ImageMetadataCache.instance.get(url: url) {
                heightConstraint?.constant = getImageHeight(size)
            }
            
            // no forced height is defined, update height
            comp.imageLoaded = { [weak self] in
                guard let self = self, let image = self.imageView.image else { return }
                self.updateImageHeight(image)
            }
        }
        comp.setup(target: imageView, model: model.image, widgetModel: model)
        
    }
    
    open func getImageHeight(_ size: CGSize) -> CGFloat {
        switch model.image.contentMode {
        case .scaleAspectFit, .scaleAspectFill, .scaleToFill:
            return CGFloat(fullscreenInnerWidth) / size.width * size.height
        default:
            return size.height
        }
    }
    
    open func updateImageHeight(_ image: UIImage) {
        let height = getImageHeight(image.size)
    
        if let url = model.image.imageUrl {
            ImageMetadataCache.instance.set(url: url, value: image.size)
        }
        
        let existingHeight: CGFloat = heightConstraint?.constant ?? -1
        heightConstraint?.constant = height
        if existingHeight != height {
            if Thread.isMainThread {
                updateHeight()
            } else {
                DispatchQueue.main.sync {
                    self.updateHeight()
                }
            }
        }
    }
}

open class ImageWidgetModel: WidgetModel {
    public var image = ImageComponentModel()
    public var defaultHeight: Float = 300
}
