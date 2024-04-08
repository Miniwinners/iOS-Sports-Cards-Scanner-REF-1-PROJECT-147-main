import Foundation

struct CardDeck: CardCollectible, Codable {
    var name: String
    var description: String = ""
    var cardIDs: Set<String> = []
    let category: CardCategory
}
