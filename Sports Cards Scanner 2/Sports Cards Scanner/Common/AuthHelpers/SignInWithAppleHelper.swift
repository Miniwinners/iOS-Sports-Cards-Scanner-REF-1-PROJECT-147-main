import UIKit
import FirebaseAuth
import AuthenticationServices

final class SignInWithAppleHelper: NSObject {

    typealias AppleAuthClosure = (Result<AppleAuthResult, Error>) -> Void

    private var currentNonce: String?

    private var completionHandler: AppleAuthClosure?
    private weak var topViewController: UIViewController?

    func signIn_appleFlow(
        in viewController: UIViewController
    ) async throws -> AppleAuthResult {
        try await withCheckedThrowingContinuation { continuation in
            signIn_appleFlow(in: viewController) { result in
                switch result {
                case .success(let signInResult):
                    continuation.resume(returning: signInResult)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func signIn_appleFlow(
        in viewController: UIViewController,
        completion: @escaping AppleAuthClosure
    ) {
        let nonce = String.randomNonce()
        currentNonce = nonce
        topViewController = viewController
        completionHandler = completion

        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce.getSHA256()

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func performSignIn(with authResult: AppleAuthResult) async throws -> FirebaseAuth.User {
        let credentials = OAuthProvider.appleCredential(
            withIDToken: authResult.idToken,
            rawNonce: authResult.nonce,
            fullName: authResult.fullName
        )
        return try await performSignIn(with: credentials)
    }

    private func performSignIn(with credential: AuthCredential) async throws -> FirebaseAuth.User {
        let result = try await Auth.auth().signIn(with: credential)
        return result.user
    }

}

// MARK: - Context Providing

extension SignInWithAppleHelper: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = topViewController?.view.window else {
            fatalError("No current window")
        }
        return window
    }
}

// MARK: - Authorization Delegate

extension SignInWithAppleHelper: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,
              let appleIDToken = appleIDCredential.identityToken,
              let idTokenString = String(data: appleIDToken, encoding: .utf8)
        else {
            completionHandler?(.failure(AppleAuthError.noCredentials))
            return
        }

        let authResult = AppleAuthResult(idToken: idTokenString, nonce: nonce, fullName: appleIDCredential.fullName)

        completionHandler?(.success(authResult))
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        completionHandler?(.failure(error))
    }
}
