import Foundation

struct LengthValidator: TextValidator {
    let minLength: Int
    let maxLength: Int?

    init(minLength: Int = 0, maxLength: Int? = nil) {
        self.minLength = minLength
        self.maxLength = maxLength
    }

    func isValueValid(_ text: String) -> Bool {
        minLength...(maxLength ?? Int.max) ~= text.count
    }
}
