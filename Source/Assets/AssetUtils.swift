//
//  AssetUtils.swift
//  Example
//
//  Created by woko on 26/09/2019.
//

import Foundation
import UIKit

private class AssetUtilsSW {
    static let bundleName = "SW"
}

extension UIImage {
    convenience init?(podAssetName: String) {
        let podBundle = Bundle(for: AssetUtilsSW.self)
        // A given class within your Pod framework
        if let url = podBundle.url(forResource: AssetUtilsSW.bundleName, withExtension: "bundle") {
            self.init(named: podAssetName, in: Bundle(url: url), compatibleWith: nil)
        } else {
            self.init(named: podAssetName) // not found - try to find in the current asset catalog
        }
    }
}
