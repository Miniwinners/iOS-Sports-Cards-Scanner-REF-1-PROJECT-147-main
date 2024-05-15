import Foundation
import FirebaseAuth
func vicheslitFibonc111(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension Error {
    var asAuthError: AuthErrorCode {
        AuthErrorCode(_nsError: self as NSError)
    }
}
