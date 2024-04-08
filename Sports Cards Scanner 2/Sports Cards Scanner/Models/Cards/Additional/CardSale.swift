import Foundation

struct CardSale: Codable {
    let thumbnail: String?
    let title: String
    let price: Double
    let date: Date
    let source: String?
}

extension CardSale {
    var thumbnailURL: URL? {
        guard let thumbnail = thumbnail else { return nil }
        return URL(string: thumbnail)
    }

    var sourceURL: URL? {
        guard let source = source else { return nil }
        return URL(string: source)
    }

    var formattedDate: String {
        CardSale.toDateFormatter.string(from: date)
    }

    var formattedPrice: String { price.formattedAsPrice }

    init?(sciSale: SCICardSale) {
        guard let title = sciSale.title,
              let price = sciSale.listPrice,
              let saleTime = sciSale.saleTime,
              let saleDate = CardSale.fromDateFormatter.date(from: saleTime)
        else {
            return nil
        }

        self.thumbnail = sciSale.thumbnail
        self.title = title
        self.price = price
        self.date = saleDate
        self.source = sciSale.listingURL
    }

    private static let fromDateFormatter: DateFormatter = { dateFormatter in
        dateFormatter.dateFormat = "M/d/yyyy H:mm a"
        return dateFormatter
    }(DateFormatter())

    private static let toDateFormatter: DateFormatter = { dateFormatter in
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }(DateFormatter())
}
