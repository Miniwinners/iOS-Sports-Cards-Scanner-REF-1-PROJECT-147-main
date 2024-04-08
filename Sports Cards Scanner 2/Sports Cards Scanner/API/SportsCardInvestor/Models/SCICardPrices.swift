import Foundation

struct SCICardPrices: Decodable {
    let grade: String?
    let minPrice: Double?
    let maxPrice: Double?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        grade = try container.decode(String.self, forKey: .grade)

        let chartPrices = try container.decode([ChartPrice].self, forKey: .series)
        let prices = chartPrices.map { $0.price }
        minPrice = prices.min()
        maxPrice = prices.max()
    }

    enum CodingKeys: String, CodingKey {
        case grade
        case series
    }
}

private extension SCICardPrices {
    struct ChartPrice: Decodable {
        let price: Double
    }
}
