import Foundation

enum AuthProviderOption: String, CaseIterable {
    case byPassword = "password"
    case byGoogle = "google.com"
    case byApple = "apple.com"

    var priority: Int {
        switch self {
        case .byApple: return 2
        case .byGoogle: return 1
        case .byPassword: return 0
        }
    }
}
