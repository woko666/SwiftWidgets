//
//  ImageMetadataCache.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import Foundation
import UIKit

open class ImageMetadataCache {
    public static let instance = ImageMetadataCache()
    public var cache: [String: CGSize] = [:]
    
    open func set(key: String, value: CGSize) {
        cache[key] = value
    }
    
    open func get(key: String) -> CGSize? {
        return cache[key]
    }
}

public extension ImageMetadataCache {
    func set(url: URL, value: CGSize) {
        set(key: url.absoluteString, value: value)
    }
    
    func get(url: URL) -> CGSize? {
        return get(key: url.absoluteString)
    }
}
