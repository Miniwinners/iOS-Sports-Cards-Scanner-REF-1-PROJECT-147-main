import Foundation

enum CardDetailName {
    // MARK: Common
    case category(CardCategory)
    case year
    case cardNumber
    case set
    case series
    case parallel
    case grade

    // MARK: Additional
    case legality(LegalityOption)
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
