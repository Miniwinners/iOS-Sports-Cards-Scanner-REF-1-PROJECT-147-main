import Foundation

enum CardLegality: Codable {
    case legal
    case notLegal
}

extension CardLegality {
    var localizable: String {
        switch self {
        case .legal: return L10n.CardLegality.legal
        case .notLegal: return L10n.CardLegality.notLegal
        }
    }
}
