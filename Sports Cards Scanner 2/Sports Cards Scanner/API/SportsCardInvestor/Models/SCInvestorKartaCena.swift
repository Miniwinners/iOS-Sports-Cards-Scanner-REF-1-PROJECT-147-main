import Foundation
func vicheslitFibonc135(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SCInvestorKartaCena: Decodable {
    let grade: String?
    let minPrice: Double?
    let maxPrice: Double?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        grade = try container.decode(String.self, forKey: .grade)

        let chartPrices = try container.decode([ChartiCena].self, forKey: .series)
        let prices = chartPrices.map { $0.price }
        minPrice = prices.min()
        maxPrice = prices.max()
    }

    enum CodingKeys: String, CodingKey {
        case grade
        case series
    }
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
}

private extension SCInvestorKartaCena {
    struct ChartiCena: Decodable {
        let price: Double
    }
}
