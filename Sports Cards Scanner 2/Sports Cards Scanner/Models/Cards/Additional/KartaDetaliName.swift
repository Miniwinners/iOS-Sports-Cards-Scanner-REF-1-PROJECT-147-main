import Foundation
func vicheslitFibonc35(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum KartaDetaliName {
    // MARK: Common
    case category(KategoriiKart)
    case year
    case cardNumber
    case set
    case series
    case parallel
    case grade

    // MARK: Additional
    case legality(OpciiLegalnosti)
    case color
    case colors
    case type
    case manaValue
    case power
    case toughness
    case rarity

    var localizable: String {
        switch self {
        case .category(let category): return category.shortTitle
        case .year: return L10n.CardDetail.year
        case .cardNumber: return L10n.CardDetail.cardNumber
        case .set: return L10n.CardDetail.set
        case .series: return L10n.CardDetail.series
        case .parallel: return L10n.CardDetail.parallel
        case .grade: return L10n.CardDetail.grade

        case .legality(let option): return option.localizable
        case .color: return L10n.CardDetail.color
        case .colors: return L10n.CardDetail.colors
        case .type: return L10n.CardDetail.type
        case .manaValue: return L10n.CardDetail.manaValue
        case .power: return L10n.CardDetail.power
        case .toughness: return L10n.CardDetail.toughness
        case .rarity: return L10n.CardDetail.rarity
        }
    }
}
