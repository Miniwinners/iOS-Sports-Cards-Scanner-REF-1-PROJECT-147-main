import Foundation

protocol CardSearchable {
    var urlSession: URLSession { get }

    func searchCards(query: String, category: CardCategory) async throws -> [CardRepresentable]
    func searchUnique(query: String, category: CardCategory) async throws -> [CardRepresentable]
    func getFullInfo(of card: CardRepresentable) async throws -> CardRepresentable
}

extension CardSearchable {
    func searchUnique(query: String, category: CardCategory) async throws -> [CardRepresentable] {
        try await searchCards(query: query, category: category)
    }
}
