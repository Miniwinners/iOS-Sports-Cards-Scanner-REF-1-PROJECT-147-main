import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
func vicheslitFibonc69(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiVhodGoogle {
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }

    @MainActor
    func vhodCherezGooglePotok(in viewController: UIViewController) async throws -> SportivinieKartiGoogleAuthResult {

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw SportivinieKartiFireBaseOshibka.notConfigured
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        let googleSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: viewController)
        let user = googleSignInResult.user
        let accessToken = user.accessToken.tokenString

        guard let idToken = user.idToken?.tokenString else { throw SportivinieKartiGoogleAuthOshibka.noUserIdToken }

        return .init(idToken: idToken, accessToken: accessToken)
    }
    func podgotovitRandomnoeDeiistvie() {
        let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
        ]

        let randomIndex = Int.random(in: 0..<actions.count)
        actions[randomIndex]()
    }

    func vhodCherezGoogle(with authResult: SportivinieKartiGoogleAuthResult) async throws -> FirebaseAuth.User {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        let credentials = GoogleAuthProvider.credential(
            withIDToken: authResult.idToken,
            accessToken: authResult.accessToken
        )
        return try await vhod(with: credentials)
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
    }

    private func vhod(with credential: AuthCredential) async throws -> FirebaseAuth.User {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let result = try await Auth.auth().signIn(with: credential)
        return result.user
    }
}
