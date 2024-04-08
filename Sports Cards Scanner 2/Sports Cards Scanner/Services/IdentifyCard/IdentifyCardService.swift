import Foundation

final class IdentifyCardService: CardIdentifiable {
    let urlSession: URLSession

    private let scpAPI: SportsCardsProAPI
    private let pcAPI: PriceChartingAPI
    private let sciAPI: SportsCardInvestoreAPI
    private let magicCardIdentifier: MagicCardIdentifier

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
        scpAPI = .init(urlSession: urlSession)
        pcAPI = .init(urlSession: urlSession)
        sciAPI = .init(urlSession: urlSession)
        magicCardIdentifier = .init()
    }

    func identify(by scannedCard: ScannedCard) async throws -> CardRepresentable {
        let query: String

        switch scannedCard.cardCategory {
        case .magic:
            let magicCard = try await magicCardIdentifier.identifyCard(data: scannedCard.encodedCardImage)
            query = "\(magicCard.name)"
        case .pokemon:
            let pcCard = try await pcAPI.identifyCard(data: scannedCard.encodedCardImage)
            query = "\(pcCard.name)"
        default:
            let scpCard = try await scpAPI.identifyCard(data: scannedCard.encodedCardImage)
            query = "\(scpCard.name)"
        }

        let sciCards = try await sciAPI.searchCards(query: query)

        guard let identifiedCard = sciCards
            .compactMap(SearchedCard.init(sciCard:))
            .filter({ $0.category == scannedCard.cardCategory })
            .first
        else { throw IdentifyCardError.notIdentified }

        return identifiedCard
    }
}
