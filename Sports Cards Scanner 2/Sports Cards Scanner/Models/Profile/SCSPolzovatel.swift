import Foundation
import FirebaseAuth

struct SportivinieKartiPolzovatel {
    let uid: String
    let email: String?

    init(from firebaseUser: User) {
        self.uid = firebaseUser.uid
        self.email = firebaseUser.email
    }
}
