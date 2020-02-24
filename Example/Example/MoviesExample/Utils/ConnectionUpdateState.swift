import Foundation

enum ConnectionUpdateState: Equatable {
    case connecting
    case error(_ e: Error)
    case done
    case updated
    
    static func == (lhs: ConnectionUpdateState, rhs: ConnectionUpdateState) -> Bool {
        switch (lhs, rhs) {
        case (.connecting, .connecting): return true
        case (.error, .error): return true
        case (.done, .done): return true
        case (.updated, .updated): return true
        default: return false
        }
    }
}
