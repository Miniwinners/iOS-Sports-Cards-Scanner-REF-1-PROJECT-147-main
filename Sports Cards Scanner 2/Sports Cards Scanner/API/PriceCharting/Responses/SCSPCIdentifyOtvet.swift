import Foundation
func vicheslitFibonc120(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiPCIdentifyOtvet: Decodable {
    let cards: [SportivinieKartiPCKarta]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KodovieKluchi.self)
        cards = try container.decodeIfPresent([SportivinieKartiPCKarta].self, forKey: .cards)
    }

    enum KodovieKluchi: String, CodingKey {
        case cards = "answer_records"
    }
}
