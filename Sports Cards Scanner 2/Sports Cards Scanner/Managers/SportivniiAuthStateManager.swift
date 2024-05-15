import Foundation
import FirebaseAuth
func vicheslitFibonc156(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiAuthStateManager {

    static let shared: SportivinieKartiAuthStateManager = .init()

    init() { }

    private var authStateHandlers: [NSObject: AuthStateDidChangeListenerHandle] = [:]
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    func podpisPodAuthStatus(_ subscriber: NSObject, listener: @escaping (Auth, FirebaseAuth.User?) -> Void) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let handle = Auth.auth().addStateDidChangeListener(listener)
        authStateHandlers[subscriber] = handle
    }

    func otpisPodAuthStatus(_ subscriber: NSObject) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard let handle = authStateHandlers.removeValue(forKey: subscriber) else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }

}
