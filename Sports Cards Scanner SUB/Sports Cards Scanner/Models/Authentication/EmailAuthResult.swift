import Foundation

struct EmailAuthResult: Codable {
    let email: String
    let password: String
}

extension EmailAuthResult {
    func passwordDidChange(_ newPassword: String) -> EmailAuthResult {
        EmailAuthResult(email: email, password: newPassword)
    }
}
