import Foundation

struct SportivinieKartiProfilInformacia: Codable {
    var cardCategories: [KartaKategoriiModel]
    var cards: [SportivinieKartiKartaPredstavlenie]
    var collection: SportivinieKartiKartaKollekcia?
    var deck: SportivinieKartiCartaKoloda?

    init(
        cardCategories: [KartaKategoriiModel] = KategoriiKart.allCases.map({ .init(category: $0) }),
        cards: [SportivinieKartiKartaPredstavlenie] = []
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
        cardCategories = try container.decodeIfPresent([KartaKategoriiModel].self, forKey: .cardCategories) ?? KategoriiKart.allCases.map({ .init(category: $0) })

        let cardWrappers: [SportivinieKartiCardWrapper] = try container.decodeIfPresent([SportivinieKartiCardWrapper].self, forKey: .cards) ?? []
        cards = cardWrappers.map { $0.card }

        collection = try container.decodeIfPresent(SportivinieKartiKartaKollekcia.self, forKey: .collection)
        deck = try container.decodeIfPresent(SportivinieKartiCartaKoloda.self, forKey: .deck)
    }

    func encode(to encoder: Encoder) throws {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cardCategories, forKey: .cardCategories)

        let cardWrappers = cards.map { SportivinieKartiCardWrapper(card: $0) }
        try container.encode(cardWrappers, forKey: .cards)

        try container.encodeIfPresent(collection, forKey: .collection)
        try container.encodeIfPresent(deck, forKey: .deck)
    }
}
