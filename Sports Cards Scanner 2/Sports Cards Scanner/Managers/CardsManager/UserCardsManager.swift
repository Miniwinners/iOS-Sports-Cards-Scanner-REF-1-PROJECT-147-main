import Foundation

final class UserCardsManager: CardsUpdater {
    static let shared: UserCardsManager = .init()

    static func setProfileManager(_ profileManager: ProfileManager) {
        shared.profileManager = profileManager
    }
    static func setCardSetsManager(_ cardSetsManager: CardCollectionManager & CardDeckManager) {
        shared.cardSetsManager = cardSetsManager
    }
    static func setCategoriesManager(_ categoriesManager: CardCategoriesManager) {
        shared.categoriesManager = categoriesManager
    }

    init() { }

    private var profileManager: ProfileManager!
    private var cardSetsManager: (CardCollectionManager & CardDeckManager)!
    private var categoriesManager: CardCategoriesManager!

    var cards: [CardRepresentable] {
        profileManager.profileInfo?.cards ?? []
    }

    var sortedCards: [CardRepresentable] {
        cards.sortedElements(by: .byDateRecentFirst)
    }

    var currentCardsValue: Double {
        cards
            .reduce(0) { partialResult, card in
                partialResult + (card.averagePrice ?? 0)
            }
    }

    var enabledCategories: [CardCategory] {
        categoriesManager.enabledCardCategories
    }

    var maxCardsNumber: Int { 60 }

    var isScanEnabled: Bool { cards.count < maxCardsNumber }

    func card(by id: String) -> CardRepresentable? {
        cards.first(where: { $0.id == id })
    }

    func cards(of category: CardCategory) -> [CardRepresentable] {
        sortedCards.filter { $0.category == category }
    }

    func cardsValue(of category: CardCategory) -> Double {
        cards
            .filter { $0.category == category }
            .reduce(0) { partialResult, card in
                partialResult + (card.averagePrice ?? 0)
            }
    }

    func cardsNumber(of category: CardCategory) -> Int {
        cards
            .filter { $0.category == category }
            .count
    }

    func recentlyAddedCards(count: Int? = nil) -> [CardRepresentable] {
        let sortedCards = self.sortedCards
        if let count = count {
            return Array(sortedCards.prefix(count))
        } else {
            return sortedCards
        }
    }

    func highestValuedCards(count: Int? = nil) -> [CardRepresentable] {
        let highestValueCards = cards
            .filter { $0.averagePrice != nil }
            .sorted { ($0.averagePrice ?? 0) > ($1.averagePrice ?? 0) }

        if let count = count {
            return Array(highestValueCards.prefix(count))
        } else {
            return highestValueCards
        }
    }

    func addNewCard(_ card: CardRepresentable) {
        var mutableCards = cards
        mutableCards.append(card)
        profileManager.updateCards(mutableCards)
    }

    func removeUserCard(_ card: CardRepresentable) {
        var mutableCards = cards
        guard let cardIndex = mutableCards.firstIndex(where: { card.id == $0.id }) else {
            return
        }
        mutableCards.remove(at: cardIndex)
        profileManager.updateCards(mutableCards)

        cardSetsManager.removeCardFromCollection(card)
        cardSetsManager.removeCardFromDeck(card)
    }

    func updateDetails(
        of card: CardRepresentable,
        parallelIndex: Int?,
        grader: CardGrader,
        grade: CardGrade?,
        price: Double?
    ) {
        var mutableCards = cards
        guard let cardIndex = mutableCards.firstIndex(where: { card.id == $0.id }) else {
            return
        }
        var mutableCard = card
        mutableCard.selectedParallelIndex = parallelIndex
        mutableCard.selectedGrader = grader
        mutableCard.selectedGrade = grade
        mutableCard.customPrice = price
        mutableCards[cardIndex] = mutableCard
        profileManager.updateCards(mutableCards)
    }

    func actualizeInfo(with updatedCard: CardRepresentable, of card: CardRepresentable) {
        var mutableCards = cards
        guard let cardIndex = mutableCards.firstIndex(where: { card.id == $0.id }),
              var mutableCard = mutableCards[safe: cardIndex]
        else { return }

        if mutableCard.selectedParallelIndex.isNotNil, let selectedParallel = mutableCard.selectedParallel {
            let updatedIndex = updatedCard.parallels.firstIndex(of: selectedParallel)
            mutableCard.selectedParallelIndex = updatedIndex
        }

        mutableCard.baseParallel = updatedCard.baseParallel
        mutableCard.parallels = updatedCard.parallels

        mutableCards[cardIndex] = mutableCard
        profileManager.updateCards(mutableCards)
    }

    func saveCardsIfNeeded() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        profileManager.saveProfileIfNeeded()
    }
}

private extension UserCardsManager {
    func isCategoryEnabled(_ category: CardCategory) -> Bool {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return enabledCategories.contains(category)
    }
}
