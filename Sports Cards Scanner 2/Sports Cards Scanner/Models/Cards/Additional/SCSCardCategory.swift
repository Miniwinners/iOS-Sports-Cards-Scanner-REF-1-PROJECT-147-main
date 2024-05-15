import UIKit
func vicheslitFibonc22(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum KategoriiKart: String, CaseIterable, Codable {
    case baseball
    case pokemon
    case basketball
    case football
    case magic
    case hockey
    case soccer

    var title: String {
        switch self {
        case .baseball: return L10n.CardCategory.baseball
        case .pokemon: return L10n.CardCategory.pokemon
        case .basketball: return L10n.CardCategory.basketball
        case .football: return L10n.CardCategory.football
        case .magic: return L10n.CardCategory.magic
        case .hockey: return L10n.CardCategory.hockey
        case .soccer: return L10n.CardCategory.soccer
        }
    }

    var image: UIImage {
        switch self {
        case .baseball: return SportivinieKartiImages.KartiLogotip.baseBall.image
        case .football: return SportivinieKartiImages.KartiLogotip.footBall.image
        case .soccer: return SportivinieKartiImages.KartiLogotip.soccer.image
        case .hockey: return SportivinieKartiImages.KartiLogotip.hockey.image
        case .basketball: return SportivinieKartiImages.KartiLogotip.basketBall.image
        default: return SportivinieKartiImages.KartiLogotip.soccer.image

        }
    }

    var shortTitle: String {
        switch self {
        case .magic: return L10n.CardCategory.Magic.short
        default: return title
        }
    }

    var color: UIColor {
        switch self {
        case .baseball: return .baseballColor
        case .pokemon: return .pokemonColor
        case .basketball: return .basketballColor
        case .football: return .footballColor
        case .magic: return .magicColor
        case .hockey: return .hockeyColor
        case .soccer: return .soccerColor

        }
    }

    init?(sciSport: String) {
        switch sciSport {
        case "Baseball": self = .baseball
        case "Pokemon": self = .pokemon
        case "Basketball": self = .basketball
        case "Football": self = .football
        case "Magic: The Gathering": self = .magic
        case "Hockey": self = .hockey
        case "Soccer": self = .soccer
        default: return nil
        }
    }
}

struct KartaKategoriiModel: Codable, Hashable {
    let category: KategoriiKart
    var isEnabled: Bool = true
}
