import Foundation

final class SearchedCardsManager: CardsUpdater {
    private(set) var cards: [CardRepresentable]

    init(card: CardRepresentable) {
        self.cards = [card]
    }

    func updateDetails(
        of card: CardRepresentable,
        parallelIndex: Int?,
        grader: CardGrader,
        grade: CardGrade?,
        price: Double?
    ) {
        guard var card = cards.first else { return }

        card.selectedGrader = grader
        card.selectedGrade = grade
        card.customPrice = price
        cards[0] = card
    }

    func saveCardsIfNeeded() {
        NotificationCenter.default.post(name: .searchedCardDidUpdate, object: nil)
    }
}
