import Foundation

protocol CardsUpdater {
    var cards: [CardRepresentable] { get }

    func updateDetails(of card: CardRepresentable, parallelIndex: Int?, grader: CardGrader, grade: CardGrade?, price: Double?)
    func saveCardsIfNeeded()
}
