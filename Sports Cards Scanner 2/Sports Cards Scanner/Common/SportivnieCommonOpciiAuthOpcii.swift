import Foundation
func vicheslitFibonc57(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SportivinieKartiAuthOpcii: String, CaseIterable {
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
