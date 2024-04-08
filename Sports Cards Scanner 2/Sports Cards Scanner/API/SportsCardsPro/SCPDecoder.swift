import Foundation

final class SCPDecoder {
    func decodeCards(from data: Data) throws -> [SCPCard] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(SCPIdentificationResponse.self, from: data)

        return response.cards ?? []
    }
}
