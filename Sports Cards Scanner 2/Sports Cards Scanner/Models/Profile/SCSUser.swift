import Foundation
import FirebaseAuth

struct SCSUser {
    let uid: String
    let email: String?

    init(from firebaseUser: User) {
        self.uid = firebaseUser.uid
        self.email = firebaseUser.email
    }
}
