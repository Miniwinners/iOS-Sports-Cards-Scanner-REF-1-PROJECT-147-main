import Foundation

struct CardCollection: CardCollectible, Codable {
    var name: String
    var cardIDs: Set<String> = []
}
