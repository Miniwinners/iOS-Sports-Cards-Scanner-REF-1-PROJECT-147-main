import Foundation

final class AddCardsToDeckHelper {
    private let cardsManager: UserCardsManager
    private let cardDeckManager: CardDeckManager

    lazy var alreadySelectedCards: [CardRepresentable] = {
        cardDeckManager.deckCards
    }()

    private(set) var selectedCards: [CardRepresentable] = []

    var cardDeck: CardDeck? { cardDeckManager.cardDeck }
    var cardCategory: CardCategory? { cardDeck?.category }

    var cards: [CardRepresentable] {
        guard let cardCategory = cardCategory else { return [] }
        return cardsManager.cards(of: cardCategory)
    }

    init(
        cardsManager: UserCardsManager = .shared,
        cardDeckManager: CardDeckManager = CardSetsManager.shared
    ) {
        self.cardsManager = cardsManager
        self.cardDeckManager = cardDeckManager
    }

    func isAlreadySelected(card: CardRepresentable) -> Bool {
        alreadySelectedCards.contains(where: { $0.id == card.id })
    }

    func isSelected(card: CardRepresentable) -> Bool {
        selectedCards.contains(where: { $0.id == card.id })
    }

    func selectCard(_ card: CardRepresentable) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        selectedCards.append(card)
    }

    func deselectCard(_ card: CardRepresentable) {
        guard let cardIndex = selectedCards.firstIndex(where: { $0.id == card.id })
        else { return }

        selectedCards.remove(at: cardIndex)
    }

    func saveCardsToDeck() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardDeckManager.addCardsToDeck(selectedCards)
        cardDeckManager.saveDeckIfNeeded()
    }
}
