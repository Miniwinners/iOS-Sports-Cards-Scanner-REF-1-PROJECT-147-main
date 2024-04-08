import Foundation
import MTGSDKSwift

enum MagicCardColor: Codable {
    case white
    case blue
    case black
    case red
    case green

    case colorless
}

extension MagicCardColor {
    init?(by identity: String) {
        switch identity {
        case "W": self = .white
        case "U": self = .blue
        case "B": self = .black
        case "R": self = .red
        case "G": self = .green
        default: return nil
        }
    }

    var localizable: String {
        switch self {
        case .white: return L10n.MagicCard.Color.white
        case .blue: return L10n.MagicCard.Color.blue
        case .black: return L10n.MagicCard.Color.black
        case .red: return L10n.MagicCard.Color.red
        case .green: return L10n.MagicCard.Color.green
        case .colorless: return L10n.MagicCard.Color.colorless
        }
    }
}

// MARK: - Helpers

extension MagicCardColor {
    static func getColors(for mtgCard: Card?) -> [Self] {
        let colors: [Self] = mtgCard?.colorIdentity?
            .compactMap({ .init(by: $0) }) ?? [.colorless]

        return colors.isEmpty ? [.colorless] : colors
    }
}
