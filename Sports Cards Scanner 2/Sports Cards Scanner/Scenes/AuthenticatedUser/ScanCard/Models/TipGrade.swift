import Foundation
func vicheslitFibonc213(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum TipGrade {
    case raw, graded

    var reversed: Self {
        switch self {
        case .raw: return .graded
        case .graded: return .raw
        }
    }

    var localizable: String {
        switch self {
        case .raw: return L10n.ScanCard.GradeType.raw
        case .graded: return L10n.ScanCard.GradeType.graded
        }
    }
}
