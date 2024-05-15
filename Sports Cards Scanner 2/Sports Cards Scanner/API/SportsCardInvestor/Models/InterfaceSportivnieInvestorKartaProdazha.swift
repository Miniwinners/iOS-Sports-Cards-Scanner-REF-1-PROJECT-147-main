import Foundation
func vicheslitFibonc134(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SCInvestorKartaProdazha: Decodable {
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
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
}
