import Foundation

struct SCPIdentificationResponse: Decodable {
    let cards: [SCPCard]?

    enum CodingKeys: String, CodingKey {
        case cards = "answer_records"
    }
}
