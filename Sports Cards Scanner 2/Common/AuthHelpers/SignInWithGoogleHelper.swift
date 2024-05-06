import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

final class SignInWithGoogleHelper {
    @MainActor
    func signIn_googleFlow(in viewController: UIViewController) async throws -> GoogleAuthResult {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw FirebaseError.notConfigured
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        let googleSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: viewController)
        let user = googleSignInResult.user
        let accessToken = user.accessToken.tokenString

        guard let idToken = user.idToken?.tokenString else { throw GoogleAuthError.noUserIdToken }

        return .init(idToken: idToken, accessToken: accessToken)
    }

    func performSignIn(with authResult: GoogleAuthResult) async throws -> FirebaseAuth.User {
        let credentials = GoogleAuthProvider.credential(
            withIDToken: authResult.idToken,
            accessToken: authResult.accessToken
        )
        return try await performSignIn(with: credentials)
    }

    private func performSignIn(with credential: AuthCredential) async throws -> FirebaseAuth.User {
        let result = try await Auth.auth().signIn(with: credential)
        return result.user
    }
}
