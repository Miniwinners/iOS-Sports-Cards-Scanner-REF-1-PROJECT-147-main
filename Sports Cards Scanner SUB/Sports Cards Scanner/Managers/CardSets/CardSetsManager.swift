import Foundation

final class CardSetsManager {
    static let shared: CardSetsManager = .init()

    static func setProfileManager(_ profileManager: ProfileManager) {
        shared.profileManager = profileManager
    }
    static func setCardsManager(_ cardsManager: UserCardsManager) {
        shared.cardsManager = cardsManager
    }

    init() { }

    private var profileManager: ProfileManager!
    private var cardsManager: UserCardsManager!
}

// MARK: - Collection Manager

extension CardSetsManager: CardCollectionManager {
    var cardCollection: CardCollection? {
        profileManager.profileInfo?.collection
    }

    var collectionCards: [CardRepresentable] {
        cardCollection?.cardIDs.compactMap {
            cardsManager.card(by: $0)
        } ?? []
    }

    var collectionCardsValue: Double {
        collectionCards.reduce(0) { partialResult, card in
            partialResult + (card.averagePrice ?? 0)
        }
    }

    @discardableResult
    func createCollection(named name: String) -> CardCollection {
        let collection = CardCollection(name: name)
        profileManager.updateCardCollection(collection)
        return collection
    }

    func renameCollectionTo(name: String) {
        guard var mutableCollection = cardCollection else { return }
        mutableCollection.name = name
        profileManager.updateCardCollection(mutableCollection)
    }

    func removeCardCollection() {
        profileManager.updateCardCollection(nil)
    }

    func addCardsToCollection(_ cards: [CardRepresentable]) {
        guard var mutableCollection = cardCollection else { return }
        mutableCollection.addCards(cards)
        profileManager.updateCardCollection(mutableCollection)
    }

    func removeCardFromCollection(_ card: CardRepresentable) {
        guard var mutableCollection = cardCollection else { return }
        mutableCollection.removeCard(card)
        profileManager.updateCardCollection(mutableCollection)
    }

    func saveCollectionIfNeeded() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        profileManager.saveProfileIfNeeded()
    }
}

// MARK: - Deck Manager

extension CardSetsManager: CardDeckManager {
    var cardDeck: CardDeck? {
        profileManager.profileInfo?.deck
    }

    var deckCards: [CardRepresentable] {
        cardDeck?.cardIDs.compactMap {
            cardsManager.card(by: $0)
        } ?? []
    }

    var deckCardsValue: Double {
        deckCards.reduce(0) { partialResult, card in
            partialResult + (card.averagePrice ?? 0)
        }
    }

    @discardableResult
    func createDeck(named name: String, description: String, category: CardCategory) -> CardDeck {
        let deck = CardDeck(name: name, description: description, category: category)
        profileManager.updateCardDeck(deck)
        return deck
    }

    func renameDeckTo(name: String, description: String) {
        guard var mutableDeck = cardDeck else { return }
        mutableDeck.name = name
        mutableDeck.description = description
        profileManager.updateCardDeck(mutableDeck)
    }

    func removeCardDeck() {
        profileManager.updateCardDeck(nil)
    }

    func addCardsToDeck(_ cards: [CardRepresentable]) {
        guard var mutableDeck = cardDeck else { return }
        mutableDeck.addCards(cards)
        profileManager.updateCardDeck(mutableDeck)
    }

    func removeCardFromDeck(_ card: CardRepresentable) {
        guard var mutableDeck = cardDeck else { return }
        mutableDeck.removeCard(card)
        profileManager.updateCardDeck(mutableDeck)
    }

    func saveDeckIfNeeded() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        profileManager.saveProfileIfNeeded()
    }
}
