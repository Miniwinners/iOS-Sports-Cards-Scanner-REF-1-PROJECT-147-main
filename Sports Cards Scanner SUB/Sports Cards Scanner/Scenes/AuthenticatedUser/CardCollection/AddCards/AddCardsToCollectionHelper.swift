import Foundation

final class AddCardToCollectionHelper {

    private let cardsManager: UserCardsManager
    private let cardCollectionManager: CardCollectionManager

    private lazy var alreadySelectedCards: [CardRepresentable] = {
        cardCollectionManager.collectionCards
    }()

    private var selectedCardsByCategory: [CardCategory: [CardRepresentable]] = [:]

    var allSelectedCards: [CardRepresentable] {
        selectedCardsByCategory.flatMap { $0.value }
    }

    var cardCollection: CardCollection? {
        cardCollectionManager.cardCollection
    }

    var categoriesCardsInfo: [CategoryCards] {
        cardsManager.enabledCategories
            .map {
                CategoryCards(
                    category: $0,
                    cardsValue: 0,
                    cardsNumber: cardsManager.cardsNumber(of: $0)
                )
            }
            .filter { $0.cardsNumber != 0 }
    }

    init(
        cardsManager: UserCardsManager = .shared,
        cardCollectionManager: CardCollectionManager = CardSetsManager.shared
    ) {
        self.cardsManager = cardsManager
        self.cardCollectionManager = cardCollectionManager
    }

    func cards(of category: CardCategory) -> [CardRepresentable] {
        cardsManager.cards(of: category)
    }

    func alreadySelectedCards(of category: CardCategory) -> [CardRepresentable] {
        alreadySelectedCards.filter { $0.category == category }
    }

    func availableCardsToSelect(of category: CardCategory) -> [CardRepresentable] {
        let alreadySelectedCards = alreadySelectedCards(of: category)
        return cards(of: category).filter { card in
            !alreadySelectedCards.contains(where: { $0.id == card.id })
        }
    }

    func isAlreadySelected(card: CardRepresentable) -> Bool {
        alreadySelectedCards.contains(where: { $0.id == card.id })
    }

    func isSelected(card: CardRepresentable) -> Bool {
        allSelectedCards.contains(where: { $0.id == card.id })
    }

    func selectCard(_ card: CardRepresentable) {
        var selectedCards = selectedCardsByCategory[card.category] ?? []
        selectedCards.append(card)
        selectedCardsByCategory[card.category] = selectedCards
    }

    func selectCards(_ cards: [CardRepresentable]) {
        for card in cards {
            if isSelected(card: card) || isAlreadySelected(card: card) { continue }
            selectCard(card)
        }
    }

    func selectCards(of category: CardCategory) {
        selectedCardsByCategory[category] = availableCardsToSelect(of: category)
    }

    func deselectCard(_ card: CardRepresentable) {
        guard var selectedCards = selectedCardsByCategory[card.category],
              let cardIndex = selectedCards.firstIndex(where: { $0.id == card.id })
        else { return }

        selectedCards.remove(at: cardIndex)
        selectedCardsByCategory[card.category] = selectedCards
    }

    func saveCardsToCollection() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardCollectionManager.addCardsToCollection(allSelectedCards)
        cardCollectionManager.saveCollectionIfNeeded()
    }

}
