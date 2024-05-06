import Foundation

struct PasswordValidator: TextValidator {
    func isValueValid(_ text: String) -> Bool {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!%@#])[A-Za-z0-9!%@#]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)

        return predicate.evaluate(with: text)
    }
}
