import Foundation

struct PCIdentificationResponse: Decodable {
    let cards: [PCCard]?

    enum CodingKeys: String, CodingKey {
        case cards = "answer_records"
    }
}
