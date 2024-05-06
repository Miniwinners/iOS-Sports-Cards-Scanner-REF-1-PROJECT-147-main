import Foundation
import FirebaseStorage

final class CardPhotoService {
    private let storage: Storage
    private let profileManager: ProfileManager

    private var userID: String? {
        profileManager.userID
    }

    init(
        storage: Storage = .storage(),
        profileManager: ProfileManager = .shared
    ) {
        self.storage = storage
        self.profileManager = profileManager
    }

    func uploadCardPhoto(
        data: Data,
        named fileName: String,
        formatted format: String = ".jpg"
    ) async throws -> URL {
        guard let userID = userID else {
            throw CommonAuthError.noUserID
        }
        let fileRef = storage.reference()
            .child(userID)
            .child("images")
            .child("\(fileName)\(format)")

        _ = try await fileRef.putDataAsync(data)
        let fileURL = try await fileRef.downloadURL()
        return fileURL
    }

    func removeImage(
        named fileName: String,
        formatted format: String = ".jpg"
    ) async throws {
        guard let userID = userID else {
            throw CommonAuthError.noUserID
        }
        let fileRef = storage.reference()
            .child(userID)
            .child("images")
            .child("\(fileName)\(format)")
        try await fileRef.delete()
    }

    func deleteAllPhotos() async throws {
        guard let userID = userID else {
            throw CommonAuthError.noUserID
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
