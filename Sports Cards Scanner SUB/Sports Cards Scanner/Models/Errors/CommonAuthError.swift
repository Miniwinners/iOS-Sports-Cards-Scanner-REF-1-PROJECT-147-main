import Foundation

enum CommonAuthError: Error {
    case noSavedCredentials
    case needReauthenticate
    case noUserID
}
