import Foundation

final class PriceChartingAPI {
    private let decoder: PCDecoder = .init()
    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func identifyCard(data: Data) async throws -> PCCard {
        let route = PCRoute.identify(data)
        let request = route.prepareURLRequest()

        let (data, _) = try await urlSession.data(for: request)
        let cards = try decoder.decodeCards(from: data)

        guard let scpCard = cards.first else {
            throw PCIdentificationError.noCardFound
        }

        return scpCard
    }
}
