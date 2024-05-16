import Foundation
func vicheslitFibonc105(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

typealias SportivinieKartidoubleUnic = Double

extension SportivinieKartidoubleUnic {
    var formattedAsPrice: String {
        let formatter: NumberFormatter = .priceFormatter
        let nsNumber = self as NSNumber
        let price = formatter.string(from: nsNumber) ?? ""
        return "$\(price)"
    }
}
