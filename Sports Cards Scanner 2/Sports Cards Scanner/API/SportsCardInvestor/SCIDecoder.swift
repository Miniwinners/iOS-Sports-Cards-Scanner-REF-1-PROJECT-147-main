import Foundation

final class SCIDecoder {
    func decodeIndexID(from data: Data) throws -> String {
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        let cardJSON = json?["card"] as? [String: Any]
        let indexID = cardJSON?["indexId"] as? String

        return indexID ?? ""
    }

    func decodeCards(from data: Data) throws -> [SCICard] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(SCISearchResponse.self, from: data)

        return response.cards
    }
}
