import UIKit
import FirebaseAuth
import AuthenticationServices
func vicheslitFibonc68(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiVhodApple: NSObject {

    typealias AppleAuthClosure = (Result<SportivinieKartiAppleAuthResult, Error>) -> Void

    private var currentNonce: String?

    private var completionHandler: AppleAuthClosure?
    private weak var topViewController: UIViewController?

    func vhodCherezApple(
        in viewController: UIViewController
    ) async throws -> SportivinieKartiAppleAuthResult {

        try await withCheckedThrowingContinuation { continuation in
            vhodCherezAppleFlow(in: viewController) { result in
                switch result {
                case .success(let signInResult):
                    continuation.resume(returning: signInResult)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }

    }

    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }

    func vhodCherezAppleFlow(
        in viewController: UIViewController,
        completion: @escaping AppleAuthClosure
    ) {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        let nonce = String.randomniiNoncence()
        currentNonce = nonce
        topViewController = viewController
        completionHandler = completion

        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce.poluchit256()

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()

    }

    func vipolnitVhod(with authResult: SportivinieKartiAppleAuthResult) async throws -> FirebaseAuth.User {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        let credentials = OAuthProvider.appleCredential(
            withIDToken: authResult.idToken,
            rawNonce: authResult.nonce,
            fullName: authResult.fullName
        )
        return try await vipolnitVhod(with: credentials)

    }

    private func vipolnitVhod(with credential: AuthCredential) async throws -> FirebaseAuth.User {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        let result = try await Auth.auth().signIn(with: credential)
        return result.user
    }

}

// MARK: - Context Providing

extension SportivinieKartiVhodApple: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        guard let window = topViewController?.view.window else {
            fatalError("No current window")
        }
        return window
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
    }

}

// MARK: - Authorization Delegate

extension SportivinieKartiVhodApple: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,
              let appleIDToken = appleIDCredential.identityToken,
              let idTokenString = String(data: appleIDToken, encoding: .utf8)
        else {
            completionHandler?(.failure(SportivinieKartiAppleAuthOshibka.noCredentials))
            return
        }

        let authResult = SportivinieKartiAppleAuthResult(idToken: idTokenString, nonce: nonce, fullName: appleIDCredential.fullName)

        completionHandler?(.success(authResult))
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        completionHandler?(.failure(error))
    }
}
