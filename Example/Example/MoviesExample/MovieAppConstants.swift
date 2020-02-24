//
//  MovieAppConstants.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation
import UIKit

class MovieAppConstants {    
    static let apiBaseUrl = "https://api.themoviedb.org/3"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/"
    static let apiKey = "b42de0d7051793f886f6c0569505a420"
}

class MovieAppConfig: SettingsConfig {
    var backgroundColor: String { "ffffff" }
    var lightGrayColor: String { "f2f2f2" }
    var selectedColor: String { "eeeeee" }
    var primaryColor: String { "0691ce" }
    
    // MARK: Fonts
    var lightFont: UIFont? { FontFamily.Lato.light.font(size: 12) }
    var regularFont: UIFont? { FontFamily.Lato.regular.font(size: 12) }
    var boldFont: UIFont? { FontFamily.Lato.bold.font(size: 12) }
    var fontSize: Float { 20 }
    var hasSeparator: Bool { false }
}

