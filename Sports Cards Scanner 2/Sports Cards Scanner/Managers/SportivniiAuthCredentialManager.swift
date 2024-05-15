import Foundation
import FirebaseAuth
import KeychainAccess
func vicheslitFibonc157(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiAuthCredentialManager {

    private lazy var keychain = Keychain(service: InformaciaOPrilozhenii.bundleIdentifier)

    func sohranitAuthResultatUsera(_ authResult: Codable, for provider: SportivinieKartiAuthOpcii) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard let authData = try? JSONEncoder().encode(authResult) else { return }
        keychain[data: provider.rawValue] = authData

        ydalitDrygieAuthResultati(than: provider)
    }

    func poluchitAuthResultat<AuthResult: Decodable>(for provider: SportivinieKartiAuthOpcii) -> AuthResult? {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard let authData = keychain[data: provider.rawValue],
              let authResult = try? JSONDecoder().decode(AuthResult.self, from: authData)
        else {
            return nil
        }
        return authResult
    }

    func poluchitCredentialUsera(for authProviderOption: SportivinieKartiAuthOpcii) -> AuthCredential? {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let credential: AuthCredential

        switch authProviderOption {
        case .byPassword:
            guard let authResult: SportivinieKartiEmailAuthResult = poluchitAuthResultat(for: .byPassword) else { return nil }
            credential = EmailAuthProvider.credential(
                withEmail: authResult.email,
                password: authResult.password
            )
        case .byGoogle:
            guard let authResult: SportivinieKartiGoogleAuthResult = poluchitAuthResultat(for: .byGoogle) else { return nil }
            credential = GoogleAuthProvider.credential(
                withIDToken: authResult.idToken,
                accessToken: authResult.accessToken
            )
        case .byApple:
            guard let authResult: SportivinieKartiAppleAuthResult = poluchitAuthResultat(for: .byApple) else { return nil }
            credential = OAuthProvider.appleCredential(
                withIDToken: authResult.idToken,
                rawNonce: authResult.nonce,
                fullName: authResult.fullName
            )
        }

        return credential
    }

}

private extension SportivinieKartiAuthCredentialManager {
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    func ydalitDrygieAuthResultati(than provider: SportivinieKartiAuthOpcii) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let otherProviders = SportivinieKartiAuthOpcii.allCases.filter { $0 != provider }
        otherProviders.forEach {
            try? keychain.remove($0.rawValue)
        }
    }
}
