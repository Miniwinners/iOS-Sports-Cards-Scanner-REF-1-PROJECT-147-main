import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
func vicheslitFibonc158(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiProfileManager {
    static let shared: SportivinieKartiProfileManager = .init()

    private lazy var database = Firestore.firestore()

    private(set) var userID: String?
    private(set) var profileInfo: SportivinieKartiProfilInformacia?
    private(set) var isProfileLoaded: Bool = false

    private var needToSaveFields: Set<ProfileField> = []
    private var isNeedToSave: Bool { !needToSaveFields.isEmpty }

    private(set) var profileLoadingTask: Task<Void, Never>?

    private lazy var cardsActualizer: SportivinieKartiActualizerKarti = .init()

    var isProfileLoading: Bool { profileLoadingTask.isNotNil }

    func postavitIDPolzovatelya(_ userID: String?) {
        let oldUserID = self.userID
        self.userID = userID

        if oldUserID == userID, isProfileLoading { return }

        zagryzitInfoProfil()
    }

    func obnovitKategorii(_ cardCategories: [KartaKategoriiModel]) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        profileInfo?.cardCategories = cardCategories
        needToSaveFields.insert(.cardCategories)
        yvedomitInfoProfilaObnovilos(fields: [.cardCategories])
    }

    func obnovitKarti(_ cards: [SportivinieKartiKartaPredstavlenie]) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        profileInfo?.cards = cards
        needToSaveFields.insert(.cards)
        yvedomitInfoProfilaObnovilos(fields: [.cards])
    }

    func obnovitKollekciuKart(_ collection: SportivinieKartiKartaKollekcia?) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        profileInfo?.collection = collection
        needToSaveFields.insert(.collection)
        yvedomitInfoProfilaObnovilos(fields: [.collection])
    }

    func obnovitKartKolody(_ deck: SportivinieKartiCartaKoloda?) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        profileInfo?.deck = deck
        needToSaveFields.insert(.deck)
        yvedomitInfoProfilaObnovilos(fields: [.deck])
    }

    func zagryzitInfoProfil() {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        cardsActualizer.otmenit()

        profileLoadingTask?.cancel()
        profileLoadingTask = Task {
            isProfileLoaded = false
            let profileInfo = await polychitInfoProfil()
            if Task.isCancelled { return }
            self.profileInfo = profileInfo
            profileLoadingTask = nil

            cardsActualizer.actualizirivat()
        }
    }

    func sohranitDatyProfil() {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard isNeedToSave else { return }
        sohranitProfil()
    }

    func ydalitDatyProfil() async throws {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard let userID = userID else { return }

        let reference = database.collection(.profiles).document(userID)
        try await reference.delete()
    }
}

private extension SportivinieKartiProfileManager {
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    func polychitInfoProfil() async -> SportivinieKartiProfilInformacia? {
        defer { yvedomitInfoProfilaObnovilos() }

        guard let userID = userID else { return nil }

        let reference = database.collection(.profiles).document(userID)

        var profileInfo: SportivinieKartiProfilInformacia?
        do {
            profileInfo = try await reference.getDocument(as: SportivinieKartiProfilInformacia?.self)
            isProfileLoaded = true
        } catch {
            print(error)
        }

        return profileInfo ?? .init()
    }

    func sohranitProfil() {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
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

    func yvedomitInfoProfilaObnovilos(fields: [ProfileField] = ProfileField.allCases) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        Task { @MainActor in
            NotificationCenter.default.post(name: .profileInfoDidUpdate, object: fields)
        }
    }
}
