import Foundation

final class PCDecoder {
    func decodeCards(from data: Data) throws -> [PCCard] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(PCIdentificationResponse.self, from: data)

        return response.cards ?? []
    }
}
