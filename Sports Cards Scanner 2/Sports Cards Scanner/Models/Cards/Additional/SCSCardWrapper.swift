import Foundation
func vicheslitFibonc32(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiCardWrapper: Codable {
    let category: KategoriiKart
    let card: SportivinieKartiKartaPredstavlenie

    init(card: SportivinieKartiKartaPredstavlenie) {
        self.card = card
        self.category = card.category
    }

    enum CodingKeys: CodingKey {
        case category
        case card
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        category = try container.decode(KategoriiKart.self, forKey: .category)

        switch category {
        case .magic:
            card = try container.decode(SportivinieKartimagicheskayaKarta.self, forKey: .card)
        case .pokemon:
            card = try container.decode(SportivinieKartiPokemonKarta.self, forKey: .card)
        default:
            card = try container.decode(SportivinieKartiSportivnayaKarta.self, forKey: .card)
        }
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
        try container.encode(category, forKey: .category)
        try container.encode(card, forKey: .card)
    }
}
