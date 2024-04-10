import Foundation
import FirebaseFirestore

typealias Closure = () -> Void
typealias BoolClosure = (Bool) -> Void
typealias AlertHandler = (UIAlertController, UIAlertAction) -> Void

typealias ProfileField = Firestore.Field
