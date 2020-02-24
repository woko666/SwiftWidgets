//
//  WidgetAccessory.swift
//  Example
//
//  Created by woko on 03/02/2020.
//

import Foundation
import UIKit

public extension Widget {
    func updateAccessory() {
        removeAccessory()
        
        switch imodel.accessory.type {
        case .disclosureIndicator, .checkmark:
            if let image = UIImage(podAssetName: imodel.accessory.type == .checkmark ? "checkmark" : "disclosureIndicator") {
                addAcessoryImage(image)
            }
        case .activityIndicator:
            let progress: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
            progress.color = imodel.accessory.color
            progress.startAnimating()
            
            addAccessoryView(progress)
        case .image:
            if let image = imodel.accessory.image {
                addAcessoryImage(image)
            }
        case .view:
            if let view = imodel.accessory.view {
                addAccessoryView(view)
            }
        default:
            break
        }
    }
    
    func removeAccessory() {
        accessoryView?.removeFromSuperview()
        accessoryView = nil
    }
    
    func addAcessoryImage(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = imodel.accessory.color
        addAccessoryView(imageView)
    }
    
    func addAccessoryView(_ view: UIView) {
        view.removeFromSuperview()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -CGFloat(imodel.accessory.rightPadding)))
        addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: imodel.accessory.size.width))
        addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: imodel.accessory.size.height))
        
        accessoryView = view
    }
}
