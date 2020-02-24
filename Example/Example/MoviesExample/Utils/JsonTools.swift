//
//  JsonTools.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation

class JsonTools {
    static func getFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    static func getReverseFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }
    
    public static func decodeStringWithDateFormatter<T: Decodable>(_ type: T.Type, from: Data, formatter: DateFormatter? = nil) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter ?? JsonTools.getFormatter())
        return try decoder.decode(type, from: from)
    }
}
