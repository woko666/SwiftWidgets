//
//  ImagesExample.swift
//  Example
//
//  Created by woko on 12/02/2020.
//

import Foundation
import UIKit

class ImagesExample: ExampleBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateUpdates = false
        loadWidgets()
    }
    
    func loadWidgets() {        
        addLabel("Static image")
        addWidget(ImageWidget.self) {
            $0.image.image = #imageLiteral(resourceName: "forest")
        }
        
        addLabel("Fixed height image")
        addWidget(ImageWidget.self) {
            $0.image.image = #imageLiteral(resourceName: "mountain")
            $0.height = 150
        }
                
        addLabel("Reusable images from http url")
        (0..<20).forEach { _ in addReusableImageView() }
    }
    
    func addReusableImageView() {
        addReusableWidget(ImageWidget.self) {
            $0.image.imageUrl = self.imageUrl()
            $0.image.placeholder = Bool.random() ? #imageLiteral(resourceName: "placeholder") : nil
            $0.image.activityIndicator = true
        }
    }
}

