//
//  HtmlParsing.swift
//  Example
//
//  Created by woko on 02/02/2020.
//

import Foundation
import UIKit
import CoreText
import DTCoreText

open class HtmlParsing {  
    public static func getAttributedStringFromHtml(text: String, font: UIFont?, textColor: UIColor, tintColor: UIColor, textAlignment: NSTextAlignment) -> NSAttributedString {
        let embeddedText = String(format:"<span style=\"font-family: "+(font?.fontName ?? "")+"\">%@</span>", text)
        var options: [String: Any] = [:]
        options[DTUseiOS6Attributes] = true
        if let font = font {
            options[DTDefaultFontName] = font.fontName
            options[DTDefaultFontSize] = font.pointSize
            options[DTDefaultFontFamily] = font.familyName
        }
        options[DTDefaultTextAlignment] = textAlignment.toCoreTextNumber

        options[DTDefaultTextColor] = textColor

        let css = DTCSSStylesheet(styleBlock: String(format:"a, b, strong {color: #%@;}", tintColor.hexString))
        options[DTDefaultStyleSheet] = css

        let attrStr: NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(htmlData: embeddedText.data(using: .utf8), options:options, documentAttributes:nil))
        attrStr.enumerateAttributes(in: NSRange(location: 0, length: attrStr.length), options: .reverse, using: { (attributes, range, stop) in
            if attributes[NSAttributedString.Key(rawValue: DTGUIDAttribute)] != nil {
                 // We need to remove this attribute or links are not colored right
                 // @see https://github.com/Cocoanetics/DTCoreText/issues/792
                 attrStr.removeAttribute(NSAttributedString.Key(rawValue: "CTForegroundColorFromContext"), range: range)
             }
        })
        
        if let font = font, font.isSystemFont {
            attrStr.enumerateAttribute(.font, in: NSRange(location: 0, length: attrStr.length)) { (value, range, stop) in
                if let f = value as? UIFont, let newFontDescriptor = f.fontDescriptor.withFamily(font.familyName).withSymbolicTraits(f.fontDescriptor.symbolicTraits) {
                    //print(f.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.face))
                    let newFont = UIFont(descriptor: newFontDescriptor, size: font.pointSize)
                    attrStr.removeAttribute(.font, range: range)
                    attrStr.addAttribute(.font, value: newFont, range: range)
                }
            }
        }
        
        /*attrStr.enumerateAttribute(.foregroundColor, in: NSRange(location: 0, length: attrStr.length)) { (value, range, stop) in
            print(value)
        }
        
        print(embeddedText, attrStr.plainTextString())*/
        
        return attrStr
    }
}

fileprivate extension UIFont {
    var isSystemFont: Bool {
        return UIFont.systemFont(ofSize: 12.0).fontName == self.fontName
    }
}

fileprivate extension NSTextAlignment {
    var toCoreTextNumber: NSNumber {
        return NSNumber(value: Int(toCoreText.rawValue))
    }
    
    var toCoreText: CTTextAlignment {
        switch self {
        case .left:
            return .left
        case .center:
            return .center
        case .right:
            return .right
        case .justified:
            return .justified
        case .natural:
            return .natural
        default:
            return .left
        }
    }
}
