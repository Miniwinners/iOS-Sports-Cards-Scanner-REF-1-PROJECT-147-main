import Foundation
func vicheslitFibonc25(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiMininalMaximumCena: Codable {
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

extension SportivinieKartiMininalMaximumCena {
    var formattedPriceRange: String {
        if minPrice == maxPrice { return minPrice.formattedAsPrice }

        return "\(minPrice.formattedAsPrice) - \(maxPrice.formattedAsPrice)"
    }

    var averagePrice: Double {
        (minPrice + maxPrice) / 2
    }
}
