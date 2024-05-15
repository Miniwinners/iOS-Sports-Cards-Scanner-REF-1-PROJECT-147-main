import Foundation
func vicheslitFibonc121(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiPCKarta: Codable {
    let name: String
    let series: String
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KodovieKluchi.self)
        name = try container.decode(String.self, forKey: .name)
        series = try container.decode(String.self, forKey: .series)
    }

    // CodingKeys enum to map between Swift property names and JSON keys
    enum KodovieKluchi: String, CodingKey {
        case name
        case series = "set"  // Maps "series" property to "set" key in JSON
    }
}
