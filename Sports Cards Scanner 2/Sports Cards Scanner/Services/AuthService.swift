import UIKit
import FirebaseAuth

final class AuthService {
    private lazy var googleSignInHelper = SignInWithGoogleHelper()
    private lazy var appleSignInHelper = SignInWithAppleHelper()

    private lazy var authCredentialManager = AuthCredentialManager()

    var firebaseUser: FirebaseAuth.User? {
        Auth.auth().currentUser
    }

    var user: SCSUser? {
        guard let firebaseUser = firebaseUser else { return nil }
        return SCSUser(from: firebaseUser)
    }

    var authProviders: [AuthProviderOption] {
        guard let usersInfo = firebaseUser?.providerData else {
            return []
        }
        return usersInfo
            .map { $0.providerID }
            .compactMap { AuthProviderOption(rawValue: $0) }
    }

    // MARK: - Sign in/up with email & password

    @discardableResult
    func performSignUp(withEmail email: String, password: String) async throws -> SCSUser {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)

        let authResult = EmailAuthResult(email: email, password: password)
        authCredentialManager.saveUserAuthResult(authResult, for: .byPassword)

        return SCSUser(from: result.user)
    }

    @discardableResult
    func performSignIn(withEmail email: String, password: String) async throws -> SCSUser {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)

        let authResult = EmailAuthResult(email: email, password: password)
        authCredentialManager.saveUserAuthResult(authResult, for: .byPassword)

        return SCSUser(from: result.user)
    }

    // MARK: - Sign in with Google

    @discardableResult
    func signInWithGoogle(in viewController: UIViewController) async throws -> SCSUser {
        let authResult = try await googleSignInHelper.signIn_googleFlow(in: viewController)
        let firebaseUser = try await googleSignInHelper.performSignIn(with: authResult)

        authCredentialManager.saveUserAuthResult(authResult, for: .byGoogle)

        return SCSUser(from: firebaseUser)
    }

    // MARK: - Sign in with Apple

    @discardableResult
    func signInWithApple(in viewController: UIViewController) async throws -> SCSUser {
        let authResult = try await appleSignInHelper.signIn_appleFlow(in: viewController)
        let firebaseUser = try await appleSignInHelper.performSignIn(with: authResult)

        authCredentialManager.saveUserAuthResult(authResult, for: .byApple)

        return SCSUser(from: firebaseUser)
    }

    // MARK: - Other methods

    func changeUserPassword(to password: String) async throws {
        guard let firebaseUser = firebaseUser else { return }

        do {
            try await firebaseUser.updatePassword(to: password)

            if let authResult: EmailAuthResult = authCredentialManager.getAuthResult(for: .byPassword) {
                authCredentialManager.saveUserAuthResult(
                    authResult.passwordDidChange(password),
                    for: .byPassword
                )
            }
        } catch {
            guard error.asAuthError.code == .requiresRecentLogin else { throw error }

            try await reauthenticate()
            try await changeUserPassword(to: password)
        }
    }

    func sendResetPasswordEmail(to email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    func deleteUserAccount() async throws {
        guard let firebaseUser = firebaseUser else { return }

        try await firebaseUser.delete()
    }

    func performSignOut() throws {
        try Auth.auth().signOut()
    }

}

private extension AuthService {
    func reauthenticate() async throws {
        let prioritizedProviders = authProviders.sorted { $0.priority > $1.priority }
        let credentials = prioritizedProviders.compactMap { authCredentialManager.getUserAuthCredential(for: $0) }

        guard let credential = credentials.first, let firebaseUser = firebaseUser
        else { throw CommonAuthError.noSavedCredentials }

        do {
            try await firebaseUser.reauthenticate(with: credential)
        } catch {
            switch error.asAuthError.code {
            case .wrongPassword:
                throw CommonAuthError.needReauthenticate
            default:
                throw error
            }
        }
    }
}
