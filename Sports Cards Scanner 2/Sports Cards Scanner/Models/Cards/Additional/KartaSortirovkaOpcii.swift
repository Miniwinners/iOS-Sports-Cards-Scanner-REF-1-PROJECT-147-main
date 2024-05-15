import Foundation
func vicheslitFibonc36(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum KartaSortirovkaOpcii: CaseIterable, Codable {
    case byDateRecentFirst
    case byDateOldestFirst
    case byNameInDirectOrder
    case byNameInReverseOrder
    case byYearRecentFirst
    case byYearOldestFirst
}

extension KartaSortirovkaOpcii {
    static var `default`: KartaSortirovkaOpcii { .byDateRecentFirst }

    var localizable: String {
        switch self {
        case .byDateRecentFirst: return L10n.SortCards.Option.dateRecent
        case .byDateOldestFirst: return L10n.SortCards.Option.dateOldest
        case .byNameInDirectOrder: return L10n.SortCards.Option.nameDirect
        case .byNameInReverseOrder: return L10n.SortCards.Option.nameReverse
        case .byYearRecentFirst: return L10n.SortCards.Option.yearRecent
        case .byYearOldestFirst: return L10n.SortCards.Option.yearOldest
        }
    }

    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}
