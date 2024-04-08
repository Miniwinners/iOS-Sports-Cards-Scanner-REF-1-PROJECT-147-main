import Foundation

struct MinMaxPrices: Codable {
    let minPrice: Double
    let maxPrice: Double

    init(minPrice: Double, maxPrice: Double) {
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }

    init(price: Double) {
        self.minPrice = price
        self.maxPrice = price
    }
}

extension MinMaxPrices {
    var formattedPriceRange: String {
        if minPrice == maxPrice { return minPrice.formattedAsPrice }

        return "\(minPrice.formattedAsPrice) - \(maxPrice.formattedAsPrice)"
    }

    var averagePrice: Double {
        (minPrice + maxPrice) / 2
    }
}
