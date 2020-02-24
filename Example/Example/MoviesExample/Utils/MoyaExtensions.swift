//
//  MoyaExtensions.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    /// Maps received data at key path into a Decodable object. If the conversion fails, the signal errors.
    public func mapJson<D: Decodable>(_ type: D.Type, method: String? = nil, dateFormatter: DateFormatter? = nil) -> Single<D> {
        return flatMap {
            do {
                let result = try JsonTools.decodeStringWithDateFormatter(type, from: $0.data, formatter: dateFormatter ?? JsonTools.getFormatter())
                
                return .just(result)
            } catch let error {
                return .error(JsonError.parseError(endpoint: method, data: String(data: $0.data, encoding: .utf8) ?? "", error: JsonError.formatValueHumanReadable(error)))
            }
        }
    }
    
    /// Filters out responses where `statusCode` falls within the range 200 - 299.
    public func checkStatusCode() -> Single<Element> {
        return flatMap {
            if $0.statusCode >= 200 && $0.statusCode < 300 {
                return .just($0)
            } else {
                return .error(NetworkError.statusCodeError(code: $0.statusCode))
            }
        }
    }
}

enum JsonError: Error {
    case parseError(endpoint: String?, data: String, error: String)
    
    static func formatValueHumanReadable(_ value: Any) -> String {
        var pieces: [String] = []
        
        if let custom = value as? CustomDebugStringConvertible {
            pieces.append(custom.debugDescription)
        } else if let custom = value as? CustomStringConvertible {
            pieces.append(custom.description)
        } else {
            pieces.append(String(describing: value))
        }
        
        return pieces.joined()
    }
}

enum NetworkError: Error {
    case statusCodeError(code: Int)
}
