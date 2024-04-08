import Foundation
import FirebaseAuth
import KeychainAccess

final class AuthCredentialManager {

    private lazy var keychain = Keychain(service: AppInfo.bundleIdentifier)

    func saveUserAuthResult(_ authResult: Codable, for provider: AuthProviderOption) {
        guard let authData = try? JSONEncoder().encode(authResult) else { return }
        keychain[data: provider.rawValue] = authData

        deleteOtherAuthResults(than: provider)
    }

    func getAuthResult<AuthResult: Decodable>(for provider: AuthProviderOption) -> AuthResult? {
        guard let authData = keychain[data: provider.rawValue],
              let authResult = try? JSONDecoder().decode(AuthResult.self, from: authData)
        else {
            return nil
        }
        return authResult
    }

    func getUserAuthCredential(for authProviderOption: AuthProviderOption) -> AuthCredential? {
        let credential: AuthCredential

        switch authProviderOption {
        case .byPassword:
            guard let authResult: EmailAuthResult = getAuthResult(for: .byPassword) else { return nil }
            credential = EmailAuthProvider.credential(
                withEmail: authResult.email,
                password: authResult.password
            )
        case .byGoogle:
            guard let authResult: GoogleAuthResult = getAuthResult(for: .byGoogle) else { return nil }
            credential = GoogleAuthProvider.credential(
                withIDToken: authResult.idToken,
                accessToken: authResult.accessToken
            )
        case .byApple:
            guard let authResult: AppleAuthResult = getAuthResult(for: .byApple) else { return nil }
            credential = OAuthProvider.appleCredential(
                withIDToken: authResult.idToken,
                rawNonce: authResult.nonce,
                fullName: authResult.fullName
            )
        }

        return credential
    }

}

private extension AuthCredentialManager {
    func deleteOtherAuthResults(than provider: AuthProviderOption) {
        let otherProviders = AuthProviderOption.allCases.filter { $0 != provider }
        otherProviders.forEach {
            try? keychain.remove($0.rawValue)
        }
    }
}
