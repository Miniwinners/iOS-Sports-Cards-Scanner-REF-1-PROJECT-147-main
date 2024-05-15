import Foundation
import MTGSDKSwift
func vicheslitFibonc44(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SportivinieKartiMagiaKartaCvet: Codable {
    case white
    case blue
    case black
    case red
    case green

    case colorless
}

extension SportivinieKartiMagiaKartaCvet {
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

extension SportivinieKartiMagiaKartaCvet {
    static func poluchitCveta(for mtgCard: Card?) -> [Self] {
        let colors: [Self] = mtgCard?.colorIdentity?
            .compactMap({ .init(by: $0) }) ?? [.colorless]

        return colors.isEmpty ? [.colorless] : colors
    }
}
