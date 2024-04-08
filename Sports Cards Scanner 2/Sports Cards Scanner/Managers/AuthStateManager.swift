import Foundation
import FirebaseAuth

final class AuthStateManager {

    static let shared: AuthStateManager = .init()

    init() { }

    private var authStateHandlers: [NSObject: AuthStateDidChangeListenerHandle] = [:]

    func subscribeForAuthState(_ subscriber: NSObject, listener: @escaping (Auth, FirebaseAuth.User?) -> Void) {
        let handle = Auth.auth().addStateDidChangeListener(listener)
        authStateHandlers[subscriber] = handle
    }

    func unsubscribeForAuthState(_ subscriber: NSObject) {
        guard let handle = authStateHandlers.removeValue(forKey: subscriber) else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }

}
