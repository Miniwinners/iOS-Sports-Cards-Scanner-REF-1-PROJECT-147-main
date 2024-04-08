import Foundation

protocol CardCollectible {
    var name: String { get set }
    var cardIDs: Set<String> { get set }

    mutating func addCards(_ cards: [CardRepresentable])
    mutating func removeCard(_ card: CardRepresentable)
}

extension CardCollectible {
    mutating func addCards(_ cards: [CardRepresentable]) {
        for card in cards {
            cardIDs.insert(card.id)
        }
    }

    mutating func removeCard(_ card: CardRepresentable) {
        cardIDs.remove(card.id)
    }
}
