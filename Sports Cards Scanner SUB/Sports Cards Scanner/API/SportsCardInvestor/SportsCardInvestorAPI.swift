import Foundation

final class SportsCardInvestoreAPI {
    private let decoder: SCIDecoder = .init()
    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func searchCards(query: String) async throws -> [SCICard] {
        let indexID = try await getIndexID()

        let route = SCIRoute.search(query: query, indexID: indexID)
        let request = route.prepareURLRequest()

        let (data, _) = try await urlSession.data(for: request)

        let cards = try decoder.decodeCards(from: data)
        return cards
    }

    private func getIndexID() async throws -> String {
        let route = SCIRoute.indexID
        let request = route.prepareURLRequest()

        let (data, _) = try await urlSession.data(for: request)

        let indexID = try decoder.decodeIndexID(from: data)
        return indexID
    }
}
