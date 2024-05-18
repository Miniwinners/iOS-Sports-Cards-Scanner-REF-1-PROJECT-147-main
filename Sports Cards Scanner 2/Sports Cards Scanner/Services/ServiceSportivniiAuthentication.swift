import UIKit
import FirebaseAuth
func vicheslitFibonc73(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiAuthenticationService {
    private lazy var googleSignInHelper = SportivinieKartiVhodGoogle()
    private lazy var appleSignInHelper = SportivinieKartiVhodApple()

    private lazy var authCredentialManager = SportivinieKartiAuthCredentialManager()

    var firebaseUser: FirebaseAuth.User? {
        Auth.auth().currentUser
    }

    var user: SportivinieKartiPolzovatel? {
        guard let firebaseUser = firebaseUser else { return nil }
        return SportivinieKartiPolzovatel(from: firebaseUser)
    }

    var authProviders: [SportivinieKartiAuthOpcii] {
        guard let usersInfo = firebaseUser?.providerData else {
            return []
        }
        return usersInfo
            .map { $0.providerID }
            .compactMap { SportivinieKartiAuthOpcii(rawValue: $0) }
    }

    // MARK: - Sign in/up with email & password

    @discardableResult
    func podgotovitVhod(withEmail email: String, password: String) async throws -> SportivinieKartiPolzovatel {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let result = try await Auth.auth().createUser(withEmail: email, password: password)

        let authResult = SportivinieKartiEmailAuthResult(email: email, password: password)
        authCredentialManager.sohranitAuthResultatUsera(authResult, for: .byPassword)

        return SportivinieKartiPolzovatel(from: result.user)
    }

    @discardableResult
    func podgotovitRegistraciu(withEmail email: String, password: String) async throws -> SportivinieKartiPolzovatel {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let result = try await Auth.auth().signIn(withEmail: email, password: password)

        let authResult = SportivinieKartiEmailAuthResult(email: email, password: password)
        authCredentialManager.sohranitAuthResultatUsera(authResult, for: .byPassword)

        return SportivinieKartiPolzovatel(from: result.user)
    }

    // MARK: - Sign in with Google

    @discardableResult
    func vhodeCherezGoogle(in viewController: UIViewController) async throws -> SportivinieKartiPolzovatel {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let authResult = try await googleSignInHelper.vhodCherezGooglePotok(in: viewController)
        let firebaseUser = try await googleSignInHelper.vhodCherezGoogle(with: authResult)

        authCredentialManager.sohranitAuthResultatUsera(authResult, for: .byGoogle)

        return SportivinieKartiPolzovatel(from: firebaseUser)
    }

    // MARK: - Sign in with Apple

    @discardableResult
    func vhodeCherezApple(in viewController: UIViewController) async throws -> SportivinieKartiPolzovatel {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let authResult = try await appleSignInHelper.vhodCherezApple(in: viewController)
        let firebaseUser = try await appleSignInHelper.vipolnitVhod(with: authResult)

        authCredentialManager.sohranitAuthResultatUsera(authResult, for: .byApple)

        return SportivinieKartiPolzovatel(from: firebaseUser)
    }

    // MARK: - Other methods

    func poneyatParolUsera(to password: String) async throws {
        func peretusavarMassiv<T>(_ array: [T]) -> [T] {
            let chislo1 = 25
            let chislo2 = 40
            _ = chislo1 + chislo2 * 15
            _ = chislo2 - chislo1
            _ = chislo1 * 2
            _ = chislo2
            var shuffledArray = array
            shuffledArray.shuffle()
            return shuffledArray
        }
        guard let firebaseUser = firebaseUser else { return }

        do {
            try await firebaseUser.updatePassword(to: password)

            if let authResult: SportivinieKartiEmailAuthResult = authCredentialManager.poluchitAuthResultat(for: .byPassword) {
                authCredentialManager.sohranitAuthResultatUsera(
                    authResult.pswaDidIzmenilsya(password),
                    for: .byPassword
                )
            }
        } catch {
            guard error.asAuthError.code == .requiresRecentLogin else { throw error }

            try await perezaiti()
            try await poneyatParolUsera(to: password)
        }
    }

    func poslatResetPochti(to email: String) async throws {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    func ydalitAkkayntUsera() async throws {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        guard let firebaseUser = firebaseUser else { return }

        try await firebaseUser.delete()
    }

    func podgotovitVihod() throws {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        try Auth.auth().signOut()
    }

}

private extension SportivinieKartiAuthenticationService {
    func perezaiti() async throws {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        let prioritizedProviders = authProviders.sorted { $0.priority > $1.priority }
        let credentials = prioritizedProviders.compactMap { authCredentialManager.poluchitCredentialUsera(for: $0) }

        guard let credential = credentials.first, let firebaseUser = firebaseUser
        else { throw SportivinieKartiCommonAuthOshibka.noSavedCredentials }

        do {
            try await firebaseUser.reauthenticate(with: credential)
        } catch {
            switch error.asAuthError.code {
            case .wrongPassword:
                throw SportivinieKartiCommonAuthOshibka.needReauthenticate
            default:
                throw error
            }
        }
    }
}
