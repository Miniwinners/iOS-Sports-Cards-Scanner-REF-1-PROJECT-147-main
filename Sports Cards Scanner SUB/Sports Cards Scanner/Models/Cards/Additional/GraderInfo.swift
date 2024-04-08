import Foundation

struct GraderInfo: Codable {
    let prices: MinMaxPrices?
    let recentSales: [CardSale]
    let grades: [CardGrade]

    init(prices: MinMaxPrices? = nil, recentSales: [CardSale] = [], grades: [CardGrade] = []) {
        self.prices = prices
        self.recentSales = recentSales
        self.grades = grades
    }
}
