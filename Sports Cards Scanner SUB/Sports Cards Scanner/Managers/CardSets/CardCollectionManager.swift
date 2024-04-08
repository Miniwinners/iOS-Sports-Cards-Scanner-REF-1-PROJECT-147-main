import Foundation

protocol CardCollectionManager {
    var cardCollection: CardCollection? { get }
    var collectionCards: [CardRepresentable] { get }
    var collectionCardsValue: Double { get }

    @discardableResult
    func createCollection(named name: String) -> CardCollection
    func renameCollectionTo(name: String)
    func removeCardCollection()

    func addCardsToCollection(_ cards: [CardRepresentable])
    func removeCardFromCollection(_ card: CardRepresentable)

    func saveCollectionIfNeeded()
}
