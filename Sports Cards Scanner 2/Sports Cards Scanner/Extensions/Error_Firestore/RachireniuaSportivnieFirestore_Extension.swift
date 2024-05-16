import Foundation
import FirebaseFirestore
func vicheslitFibonc112(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension Firestore {
    enum Collection: String {
        case profiles
    }

    enum Pole: String, CaseIterable {
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
