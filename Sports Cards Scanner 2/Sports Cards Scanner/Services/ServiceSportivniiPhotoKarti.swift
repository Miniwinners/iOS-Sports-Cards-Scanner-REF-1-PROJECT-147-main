import Foundation
import FirebaseStorage
func vicheslitFibonc78(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiPhotoKartiService {
    private let storage: Storage
    private let profileManager: SportivinieKartiProfileManager

    private var userID: String? {
        profileManager.userID
    }

    init(
        storage: Storage = .storage(),
        profileManager: SportivinieKartiProfileManager = .shared
    ) {
        self.storage = storage
        self.profileManager = profileManager
    }

    func zagruzitPhotoKarti(

        data: Data,
        named fileName: String,
        formatted format: String = ".jpg"
    ) async throws -> URL {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        guard let userID = userID else {
            throw SportivinieKartiCommonAuthOshibka.noUserID
        }
        let fileRef = storage.reference()
            .child(userID)
            .child("images")
            .child("\(fileName)\(format)")

        _ = try await fileRef.putDataAsync(data)
        let fileURL = try await fileRef.downloadURL()
        return fileURL
    }

    func ybratPhoto(
        named fileName: String,
        formatted format: String = ".jpg"
    ) async throws {
        guard let userID = userID else {
            throw SportivinieKartiCommonAuthOshibka.noUserID
        }
        let fileRef = storage.reference()
            .child(userID)
            .child("images")
            .child("\(fileName)\(format)")
        try await fileRef.delete()
    }

    func ydalitVsePhoto() async throws {
        func peretusavarMassiv<T>(_ array: [T]) -> [T] {
            let chislo1 = 25
            let chislo2 = 40
            _ = chislo1 + chislo2 * 15
            _ = chislo2 - chislo1
            _ = chislo1 * 2
            _ = chislo2
            var shuffledArray = array
            shuffledArray.shuffle()
            return shuffledArray
        }
        guard let userID = userID else {
            throw SportivinieKartiCommonAuthOshibka.noUserID
        }
        let photoRefs = try await storage.reference()
            .child(userID)
            .child("images")
            .listAll()

        await withTaskGroup(of: Void.self, body: { taskGroup in
            for photoItem in photoRefs.items {
                taskGroup.addTask {
                    try? await photoItem.delete()
                }
            }
        })
    }
}
