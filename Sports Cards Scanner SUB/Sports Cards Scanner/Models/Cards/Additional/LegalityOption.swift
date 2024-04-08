import Foundation
import MTGSDKSwift

enum LegalityOption: Codable, CaseIterable {
    case standard
    case pioneer
    case modern
    case legacy
    case vintage
    case commander
    case oathbreaker
    case alchemy
    case explorer
    case brawl
    case historic
    case pauper
    case penny
}

extension LegalityOption {
    var localizable: String {
        typealias Option = L10n.LegalityOption

        switch self {
        case .standard: return Option.standard
        case .pioneer: return Option.pioneer
        case .modern: return Option.modern
        case .legacy: return Option.legacy
        case .vintage: return Option.vintage
        case .commander: return Option.commander
        case .oathbreaker: return Option.oathbreaker
        case .alchemy: return Option.alchemy
        case .explorer: return Option.explorer
        case .brawl: return Option.brawl
        case .historic: return Option.historic
        case .pauper: return Option.pauper
        case .penny: return Option.penny
        }
    }
}

// MARK: - MTG Cards

extension LegalityOption {
    static var magicCases: [Self] {
        [
            .standard, .brawl, .commander, .modern,
            .pauper, .vintage, .pioneer, .legacy
        ]
    }

    static func getLegalities(for mtgCard: Card?) -> [Self: CardLegality] {
        let legalString = "Legal"
        var legalities: [Self: CardLegality] = [:]
        let mtgLegalities = mtgCard?.legalities

        for option in magicCases {
            guard let mtgLegality = mtgLegalities?.first(where: { $0.format == option.localizable }) else {
                legalities[option] = .notLegal
                continue
            }
            let isMTGLegal = mtgLegality.legality == legalString
            legalities[option] = isMTGLegal ? .legal : .notLegal
        }

        return legalities
    }
}
