import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
func vicheslitFibonc159(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCardCategoriesManager {
    static let shared: SportivinieKartiCardCategoriesManager = .init()

    static func postavitProfilManager(_ profileManager: SportivinieKartiProfileManager) {
        shared.profileManager = profileManager
    }

    init() { }

    private var profileManager: SportivinieKartiProfileManager!

    private var serverCardCategories: [KartaKategoriiModel]? {
        profileManager.profileInfo?.cardCategories
    }
    private lazy var defaultCardCategories: [KartaKategoriiModel] = KategoriiKart.allCases
        .map { KartaKategoriiModel(category: $0) }

    var switchableCardCategories: [KartaKategoriiModel] {
        serverCardCategories ?? defaultCardCategories
    }

    var allCardCategories: [KategoriiKart] {
        switchableCardCategories
            .map { $0.category }
    }

    var enabledCardCategories: [KategoriiKart] {
        switchableCardCategories
            .filter { $0.isEnabled }
            .map { $0.category }
    }

    var lastEnabledCategoryIndex: Int {
        switchableCardCategories.lastIndex { $0.isEnabled } ?? -1
    }
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    var isAvailableToSwitchOff: Bool {
        enabledCardCategories.count > 1
    }

    func postavitKategoriu(
        _ category: KategoriiKart,
        enabled: Bool,
        movedFrom sourceIndex: inout Int?,
        to destinationIndex: inout Int?
    ) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        var cardCategories = switchableCardCategories

        guard let indexedCategory = indeksirovannayaKategoria(category) else { return }

        var switchableCategory = indexedCategory.element
        switchableCategory.isEnabled = enabled

        cardCategories[indexedCategory.offset] = switchableCategory

        let fromIndex: Int = indexedCategory.offset
        let toIndex: Int = enabled ? (lastEnabledCategoryIndex + 1) : (cardCategories.count - 1)

        cardCategories.moveElement(from: fromIndex, to: toIndex)

        sourceIndex = fromIndex
        destinationIndex = toIndex

        profileManager.obnovitKategorii(cardCategories)
    }

    func dvigatKategoriu(from sourceIndex: Int, to destinationIndex: Int) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        var cardCategories = switchableCardCategories
        cardCategories.moveElement(from: sourceIndex, to: destinationIndex)
        profileManager.obnovitKategorii(cardCategories)
    }

    func sohranitKategorii() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        profileManager.sohranitDatyProfil()
    }

    private func indeksirovannayaKategoria(_ category: KategoriiKart) -> EnumeratedSequence<[KartaKategoriiModel]>.Element? {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        return switchableCardCategories
            .enumerated()
            .first(where: { $1.category == category })
    }

}
