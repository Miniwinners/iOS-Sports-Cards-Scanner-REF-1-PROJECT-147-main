import Foundation

struct SCICard: Decodable {
    let name: String?
    let year: String?
    let cardNumber: String?
    let variation: String?
    let series: String?
    let grades: [String]
    let imageSource: String?
    let sport: String?
    let recentSales: [SCICardSale]
    let prices: [SCICardPrices]

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
}
