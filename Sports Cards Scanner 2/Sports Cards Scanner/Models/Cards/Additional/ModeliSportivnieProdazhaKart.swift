import Foundation
func vicheslitFibonc27(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiProdazhaKart: Codable {
    let thumbnail: String?
    let title: String
    let price: Double
    let date: Date
    let source: String?
}

extension SportivinieKartiProdazhaKart {
    var thumbnailURL: URL? {
        guard let thumbnail = thumbnail else { return nil }
        return URL(string: thumbnail)
    }

    var sourceURL: URL? {
        guard let source = source else { return nil }
        return URL(string: source)
    }

    var formattedDate: String {
        SportivinieKartiProdazhaKart.toDateFormatter.string(from: date)
    }

    var formattedPrice: String { price.formattedAsPrice }

    init?(sciSale: SCInvestorKartaProdazha) {
        guard let title = sciSale.title,
              let price = sciSale.listPrice,
              let saleTime = sciSale.saleTime,
              let saleDate = SportivinieKartiProdazhaKart.fromDateFormatter.date(from: saleTime)
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
