import Foundation

struct PriceValidator: TextValidator {
    var maxPriceLength: Int = 255

    func isValueValid(_ text: String) -> Bool {
        let priceRegEx = "^(?:\\$)(?!\\.)(?!0[0-9]+)[0-9]{0,\(maxPriceLength)}(?:\\.[0-9]{0,2})?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", priceRegEx)

        return predicate.evaluate(with: text)
    }
}
