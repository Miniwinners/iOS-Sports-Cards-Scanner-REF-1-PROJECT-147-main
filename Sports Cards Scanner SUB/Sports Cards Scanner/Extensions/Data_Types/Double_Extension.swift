import Foundation

extension Double {
    var formattedAsPrice: String {
        let formatter: NumberFormatter = .priceFormatter
        let nsNumber = self as NSNumber
        let price = formatter.string(from: nsNumber) ?? ""
        return "$\(price)"
    }
}
