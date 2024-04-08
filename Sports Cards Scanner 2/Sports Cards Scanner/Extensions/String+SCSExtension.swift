import Foundation
import CryptoKit

extension String {
    static func randomNonce(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }

        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }

        return String(nonce)
    }

    var withGroupingSeparator: String {
        let integerPart: String
        let fractionalPart: String

        if let pointIndex = self.lastIndex(of: ".") {
            integerPart = String(self[..<pointIndex])
            fractionalPart = String(self[pointIndex...])
        } else {
            integerPart = self
            fractionalPart = ""
        }

        var groups: [String] = []
        var endIndex = integerPart.endIndex

        while integerPart.startIndex < endIndex {
            let startIndex = integerPart.index(endIndex, offsetBy: -3, limitedBy: integerPart.startIndex) ?? integerPart.startIndex
            let group = integerPart[startIndex..<endIndex]
            groups.append(String(group))
            endIndex = startIndex
        }

        let groupedIntegerPart = groups.reversed().joined(separator: ",")
        return groupedIntegerPart + fractionalPart
    }

    var asDoublePrice: Double? {
        let formatter: NumberFormatter = .priceFormatter
        guard let nsPrice = formatter.number(from: self) else { return nil }
        return Double(truncating: nsPrice)
    }

    func getSHA256() -> String {
        let inputData = Data(utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData
            .compactMap {
                String(format: "%02x", $0)
            }
            .joined()

        return hashString
    }
}
