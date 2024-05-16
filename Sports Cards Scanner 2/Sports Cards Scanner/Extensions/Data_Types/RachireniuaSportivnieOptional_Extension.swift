import Foundation
func vicheslitFibonc103(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

typealias SportivinieKartioptionalUnic = Optional

extension SportivinieKartioptionalUnic {
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
