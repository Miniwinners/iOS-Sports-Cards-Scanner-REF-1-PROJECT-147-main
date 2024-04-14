import UIKit

enum CardCategory: String, CaseIterable, Codable {
    case baseball
//    case pokemon
    case basketball
    case football
//    case magic
    case hockey
    case soccer

    var title: String {
        switch self {
        case .baseball: return L10n.CardCategory.baseball
//        case .pokemon: return L10n.CardCategory.pokemon
        case .basketball: return L10n.CardCategory.basketball
        case .football: return L10n.CardCategory.football
//        case .magic: return L10n.CardCategory.magic
        case .hockey: return L10n.CardCategory.hockey
        case .soccer: return L10n.CardCategory.soccer
        }
    }

    var image: UIImage {
        switch self {
        case .baseball: return Images.CardsLogo.baseBall.image
        case .football: return Images.CardsLogo.footBall.image
        case .soccer: return Images.CardsLogo.soccer.image
        case .hockey: return Images.CardsLogo.hockey.image
        case .basketball: return Images.CardsLogo.basketBall.image
        }
    }

    var shortTitle: String {
        switch self {
//        case .magic: return L10n.CardCategory.Magic.short
        default: return title
        }
    }

    var color: UIColor {
        switch self {
        case .baseball: return .baseballColor
//        case .pokemon: return .pokemonColor
        case .basketball: return .basketballColor
        case .football: return .footballColor
//        case .magic: return .magicColor
        case .hockey: return .hockeyColor
        case .soccer: return .soccerColor
        }
    }

    init?(sciSport: String) {
        switch sciSport {
        case "Baseball": self = .baseball
//        case "Pokemon": self = .pokemon
        case "Basketball": self = .basketball
        case "Football": self = .football
//        case "Magic: The Gathering": self = .magic
        case "Hockey": self = .hockey
        case "Soccer": self = .soccer
        default: return nil
        }
    }
}

struct CardCategoryModel: Codable, Hashable {
    let category: CardCategory
    var isEnabled: Bool = true
}
