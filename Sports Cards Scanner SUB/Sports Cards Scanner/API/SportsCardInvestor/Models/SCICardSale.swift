import Foundation

struct SCICardSale: Decodable {
    let grade: String?
    let thumbnail: String?
    let title: String?
    let platform: String?
    let listPrice: Double?
    let saleTime: String?
    let listingURL: String?

    enum CodingKeys: String, CodingKey {
        case grade
        case thumbnail
        case title
        case platform
        case listPrice = "list_price"
        case saleTime = "end_time"
        case listingURL = "auction_url"
    }
}
