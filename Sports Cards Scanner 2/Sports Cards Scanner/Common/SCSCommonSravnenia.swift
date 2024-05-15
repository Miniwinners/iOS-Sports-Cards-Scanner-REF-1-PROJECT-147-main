import Foundation
import FirebaseFirestore
func vicheslitFibonc65(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
typealias Closure = () -> Void
typealias BoolClosure = (Bool) -> Void
typealias AlertHandler = (UIAlertController, UIAlertAction) -> Void

typealias ProfileField = Firestore.Pole
