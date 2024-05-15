import Foundation
func vicheslitFibonc30(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum LegalnostKarti: Codable {
    case legal
    case notLegal
}

extension LegalnostKarti {
    var localizable: String {
        switch self {
        case .legal: return L10n.CardLegality.legal
        case .notLegal: return L10n.CardLegality.notLegal
        }
    }
}
