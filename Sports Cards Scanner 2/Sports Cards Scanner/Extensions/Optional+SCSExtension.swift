import Foundation

extension Optional {
    var isNil: Bool {
        switch self {
        case .some: return false
        case .none: return true
        }
    }

    var isNotNil: Bool {
        !isNil
    }
}
