import Foundation

struct ProfileInfo: Codable {
    var cardCategories: [CardCategoryModel]
    var cards: [CardRepresentable]
    var collection: CardCollection?
    var deck: CardDeck?

    init(
        cardCategories: [CardCategoryModel] = CardCategory.allCases.map({ .init(category: $0) }),
        cards: [CardRepresentable] = []
    ) {
        self.cardCategories = cardCategories
        self.cards = cards
    }

    enum CodingKeys: CodingKey {
        case cardCategories
        case cards
        case collection
        case deck
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cardCategories = try container.decodeIfPresent([CardCategoryModel].self, forKey: .cardCategories) ?? CardCategory.allCases.map({ .init(category: $0) })

        let cardWrappers: [CardWrapper] = try container.decodeIfPresent([CardWrapper].self, forKey: .cards) ?? []
        cards = cardWrappers.map { $0.card }

        collection = try container.decodeIfPresent(CardCollection.self, forKey: .collection)
        deck = try container.decodeIfPresent(CardDeck.self, forKey: .deck)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cardCategories, forKey: .cardCategories)

        let cardWrappers = cards.map { CardWrapper(card: $0) }
        try container.encode(cardWrappers, forKey: .cards)

        try container.encodeIfPresent(collection, forKey: .collection)
        try container.encodeIfPresent(deck, forKey: .deck)
    }
}
