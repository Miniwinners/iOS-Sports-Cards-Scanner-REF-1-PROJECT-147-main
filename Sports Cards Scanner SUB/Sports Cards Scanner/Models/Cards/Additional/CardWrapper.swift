import Foundation

struct CardWrapper: Codable {
    let category: CardCategory
    let card: CardRepresentable

    init(card: CardRepresentable) {
        self.card = card
        self.category = card.category
    }

    enum CodingKeys: CodingKey {
        case category
        case card
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        category = try container.decode(CardCategory.self, forKey: .category)

        switch category {
        case .magic:
            card = try container.decode(MagicCard.self, forKey: .card)
        case .pokemon:
            card = try container.decode(PokemonCard.self, forKey: .card)
        default:
            card = try container.decode(SportCard.self, forKey: .card)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(category, forKey: .category)
        try container.encode(card, forKey: .card)
    }
}
