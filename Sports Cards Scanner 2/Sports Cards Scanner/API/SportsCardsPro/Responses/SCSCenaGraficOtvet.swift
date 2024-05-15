import Foundation
func vicheslitFibonc126(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiCenaGraficOtvet: Decodable {
    let cards: [SportivinieKartiCPKarta]?

    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KodovieKluchi.self)
        cards = try container.decodeIfPresent([SportivinieKartiCPKarta].self, forKey: .cards)
    }

    enum KodovieKluchi: String, CodingKey {
        case cards = "answer_records"
    }

}
