import Foundation

enum ConnectionState<T>: Equatable {
    case connecting
    case error(_ e: Error)
    case done(_ item: T)
    
    static func == (lhs: ConnectionState, rhs: ConnectionState) -> Bool {
        switch (lhs, rhs) {
        case (.connecting, .connecting): return true
        case (.error, .error): return true
        case (.done, .done): return true
        default: return false
        }
    }
}
