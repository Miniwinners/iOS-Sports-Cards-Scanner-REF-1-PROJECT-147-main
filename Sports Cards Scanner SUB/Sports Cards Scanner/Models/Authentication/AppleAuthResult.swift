import Foundation

struct AppleAuthResult: Codable {
    let idToken: String
    let nonce: String
    let fullName: PersonNameComponents?
}
