import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ProfileManager {
    static let shared: ProfileManager = .init()

    private lazy var database = Firestore.firestore()

    private(set) var userID: String?
    private(set) var profileInfo: ProfileInfo?
    private(set) var isProfileLoaded: Bool = false

    private var needToSaveFields: Set<ProfileField> = []
    private var isNeedToSave: Bool { !needToSaveFields.isEmpty }

    private(set) var profileLoadingTask: Task<Void, Never>?

    private lazy var cardsActualizer: CardsActualizer = .init()

    var isProfileLoading: Bool { profileLoadingTask.isNotNil }

    func setUserID(_ userID: String?) {
        let oldUserID = self.userID
        self.userID = userID

        if oldUserID == userID, isProfileLoading { return }

        loadProfileInfo()
    }

    func updateCategories(_ cardCategories: [CardCategoryModel]) {
        profileInfo?.cardCategories = cardCategories
        needToSaveFields.insert(.cardCategories)
        notifyProfileInfoDidUpdate(fields: [.cardCategories])
    }

    func updateCards(_ cards: [CardRepresentable]) {
        profileInfo?.cards = cards
        needToSaveFields.insert(.cards)
        notifyProfileInfoDidUpdate(fields: [.cards])
    }

    func updateCardCollection(_ collection: CardCollection?) {
        profileInfo?.collection = collection
        needToSaveFields.insert(.collection)
        notifyProfileInfoDidUpdate(fields: [.collection])
    }

    func updateCardDeck(_ deck: CardDeck?) {
        profileInfo?.deck = deck
        needToSaveFields.insert(.deck)
        notifyProfileInfoDidUpdate(fields: [.deck])
    }

    func loadProfileInfo() {
        cardsActualizer.cancel()

        profileLoadingTask?.cancel()
        profileLoadingTask = Task {
            isProfileLoaded = false
            let profileInfo = await getProfileInfo()
            if Task.isCancelled { return }
            self.profileInfo = profileInfo
            profileLoadingTask = nil

            cardsActualizer.actualize()
        }
    }

    func saveProfileIfNeeded() {
        guard isNeedToSave else { return }
        saveProfile()
    }

    func deleteProfileData() async throws {
        guard let userID = userID else { return }

        let reference = database.collection(.profiles).document(userID)
        try await reference.delete()
    }
}

private extension ProfileManager {
    func getProfileInfo() async -> ProfileInfo? {
        defer { notifyProfileInfoDidUpdate() }

        guard let userID = userID else { return nil }

        let reference = database.collection(.profiles).document(userID)

        var profileInfo: ProfileInfo?
        do {
            profileInfo = try await reference.getDocument(as: ProfileInfo?.self)
            isProfileLoaded = true
        } catch {
            print(error)
        }

        return profileInfo ?? .init()
    }

    func saveProfile() {
        defer { needToSaveFields.removeAll() }

        guard let userID = userID,
              let profileInfo = profileInfo,
              isProfileLoaded
        else { return }

        let reference = database.collection(.profiles).document(userID)
        database.collection(.profiles).document(userID)

        var needToDeleteFields: Set<ProfileField> = []
        if needToSaveFields.contains(.collection) && profileInfo.collection.isNil {
            needToSaveFields.remove(.collection)
            needToDeleteFields.insert(.collection)
        }
        if needToSaveFields.contains(.deck) && profileInfo.deck.isNil {
            needToSaveFields.remove(.deck)
            needToDeleteFields.insert(.deck)
        }
        if !needToDeleteFields.isEmpty {
            let deleteFields = needToDeleteFields.reduce(into: [String: FieldValue]()) { partialResult, field in
                partialResult[field.name] = .delete()
            }
            reference.updateData(deleteFields)
        }

        if needToSaveFields.isEmpty { return }

        let mergeFields = Array(needToSaveFields.map { $0.name })
        try? reference.setData(from: profileInfo, mergeFields: mergeFields)
    }

    func notifyProfileInfoDidUpdate(fields: [ProfileField] = ProfileField.allCases) {
        Task { @MainActor in
            NotificationCenter.default.post(name: .profileInfoDidUpdate, object: fields)
        }
    }
}
