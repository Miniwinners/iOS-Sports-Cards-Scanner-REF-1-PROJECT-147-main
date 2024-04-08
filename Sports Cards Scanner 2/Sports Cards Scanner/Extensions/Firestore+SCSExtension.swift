import Foundation
import FirebaseFirestore

extension Firestore {
    enum Collection: String {
        case profiles
    }

    enum Field: String, CaseIterable {
        case cardCategories
        case cards
        case collection
        case deck

        var name: String { rawValue }
    }

    func collection(_ firestoreCollection: Collection) -> CollectionReference {
        collection(firestoreCollection.rawValue)
    }
}
