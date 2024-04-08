import Foundation

protocol CardDeckManager {
    var cardDeck: CardDeck? { get }
    var deckCards: [CardRepresentable] { get }
    var deckCardsValue: Double { get }

    @discardableResult
    func createDeck(named name: String, description: String, category: CardCategory) -> CardDeck
    func renameDeckTo(name: String, description: String)
    func removeCardDeck()

    func addCardsToDeck(_ cards: [CardRepresentable])
    func removeCardFromDeck(_ card: CardRepresentable)

    func saveDeckIfNeeded()
}
