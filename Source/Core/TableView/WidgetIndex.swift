//
//  WidgetIndex.swift
//  Example
//
//  Created by woko on 18/02/2020.
//

import Foundation
import UIKit

open class WidgetIndex: Equatable {
    public var id: String = UUID().uuidString
    public var index: Int?
    
    public init() {        
    }
    
    public init(_ index: Int?) {
        self.index = index
    }
    
    public static func == (lhs: WidgetIndex, rhs: WidgetIndex) -> Bool {
        return lhs.id == rhs.id
    }
}
