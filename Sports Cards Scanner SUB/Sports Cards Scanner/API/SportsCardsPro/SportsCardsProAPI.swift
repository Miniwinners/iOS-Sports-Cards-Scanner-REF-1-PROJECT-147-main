import Foundation

final class SportsCardsProAPI {
    private let decoder: SCPDecoder = .init()
    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func identifyCard(data: Data) async throws -> SCPCard {
        let route = SCPRoute.identify(data)
        let request = route.prepareURLRequest()

        let (data, _) = try await urlSession.data(for: request)
        let cards = try decoder.decodeCards(from: data)

        guard let scpCard = cards.first else {
            throw SCPIdentificationError.noCardFound
        }

        return scpCard
    }
}
