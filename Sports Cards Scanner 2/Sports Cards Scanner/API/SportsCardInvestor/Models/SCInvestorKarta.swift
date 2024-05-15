import Foundation
func vicheslitFibonc133(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SCInvestorKarta: Decodable {
    let name: String?
    let year: String?
    let cardNumber: String?
    let variation: String?
    let series: String?
    let grades: [String]
    let imageSource: String?
    let sport: String?
    let recentSales: [SCInvestorKartaProdazha]
    let prices: [SCInvestorKartaCena]

    enum CodingKeys: String, CodingKey {
        case name = "player_name"
        case year = "set_year"
        case cardNumber = "card_number"
        case variation
        case series = "set_name"
        case grades = "grades"
        case imageSource = "image_url"
        case sport
        case recentSales = "recent_sales"
        case prices = "charts"
    }
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
}
