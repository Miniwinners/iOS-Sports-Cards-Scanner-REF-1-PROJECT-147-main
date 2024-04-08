import Foundation
import MTGSDKSwift

final class SearchCardService: CardSearchable {
    let urlSession: URLSession

    private let sciAPI: SportsCardInvestoreAPI
    private lazy var magicAPI = Magic()

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
        sciAPI = .init(urlSession: urlSession)
    }

    func searchCards(query: String, category: CardCategory) async throws -> [CardRepresentable] {
        let sciCards = try await sciAPI.searchCards(query: query)

        return sciCards
            .compactMap(SearchedCard.init(sciCard:))
            .filter { $0.category == category }
    }

    func searchUnique(query: String, category: CardCategory) async throws -> [CardRepresentable] {
        let cards = try await searchCards(query: query, category: category)

        return cards.uniqueElements { card in
            "\(card.name)\(card.cardNumber ?? "")\(card.year)\(card.series)"
        }
    }

    func getFullInfo(of card: CardRepresentable) async throws -> CardRepresentable {
        switch card.category {
        case .magic:
            let magicCard = try await getMagicCard(relatedTo: card)
            return magicCard
        case .pokemon:
            let pokemonCard = try await getPokemonCard(relatedTo: card)
            return pokemonCard
        default:
            let sportCard = try await getSportCard(relatedTo: card)
            return sportCard
        }
    }
}

private extension SearchCardService {
    func getSportCard(relatedTo card: CardRepresentable) async throws -> CardRepresentable {
        let query = setupQuery(for: card)
        let sciCards = try await sciAPI.searchCards(query: query)
        let filteredCards = sciCards.filter { setupQuery(for: $0) == query }

        guard let sportCard = SportCard(from: filteredCards, relatedTo: card) else {
            throw SearchCardError.cardNotFound
        }

        return sportCard
    }

    func getMagicCard(relatedTo card: CardRepresentable) async throws -> CardRepresentable {
        let query = setupQuery(for: card)
        let sciCards = try await sciAPI.searchCards(query: query)
        let filteredCards = sciCards.filter { setupQuery(for: $0) == query }

        let params: [CardSearchParameter] = [
            .init(parameterType: .name, value: card.name)
        ]
        let cards: [Card] = try await withCheckedThrowingContinuation { continuation in
            magicAPI.fetchCards(params) { result in
                switch result {
                case .success(let cards):
                    continuation.resume(returning: cards)
                case .error(let error):
                    continuation.resume(throwing: error)
                }
            }
        }

        let mtgCard = cards.first(where: { $0.number == card.cardNumber })

        guard let magicCard = MagicCard(fromMTGCard: mtgCard, sciCards: filteredCards, relatedTo: card) else {
            throw SearchCardError.cardNotFound
        }

        return magicCard
    }

    func getPokemonCard(relatedTo card: CardRepresentable) async throws -> CardRepresentable {
        let query = setupQuery(for: card)
        let sciCards = try await sciAPI.searchCards(query: query)
        let filteredCards = sciCards.filter { setupQuery(for: $0) == query }

        guard let pokemonCard = PokemonCard(from: filteredCards, relatedTo: card) else {
            throw SearchCardError.cardNotFound
        }

        return pokemonCard
    }

    func setupQuery(for card: SCICard) -> String {
        let queryParams: [String] = [
            card.name,
            card.year,
            card.cardNumber,
            card.series
        ].compactMap { $0 }
        let query = queryParams.joined(separator: " ")

        return query
    }

    func setupQuery(for card: CardRepresentable) -> String {
        var queryParams: [String] = []
        queryParams.append(card.name)
        queryParams.append(card.year)
        if let cardNumber = card.cardNumber {
            queryParams.append("#\(cardNumber)")
        }
        queryParams.append(card.series)

        let query = queryParams.joined(separator: " ")
        return query
    }
}
