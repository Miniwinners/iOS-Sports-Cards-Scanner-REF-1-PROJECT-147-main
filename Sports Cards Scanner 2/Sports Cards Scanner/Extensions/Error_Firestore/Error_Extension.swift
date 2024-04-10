import Foundation
import FirebaseAuth

extension Error {
    var asAuthError: AuthErrorCode {
        AuthErrorCode(_nsError: self as NSError)
    }
}
