import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class CardCategoriesManager {
    static let shared: CardCategoriesManager = .init()

    static func setProfileManager(_ profileManager: ProfileManager) {
        shared.profileManager = profileManager
    }

    init() { }

    private var profileManager: ProfileManager!

    private var serverCardCategories: [CardCategoryModel]? {
        profileManager.profileInfo?.cardCategories
    }
    private lazy var defaultCardCategories: [CardCategoryModel] = CardCategory.allCases
        .map { CardCategoryModel(category: $0) }

    var switchableCardCategories: [CardCategoryModel] {
        serverCardCategories ?? defaultCardCategories
    }

    var allCardCategories: [CardCategory] {
        switchableCardCategories
            .map { $0.category }
    }

    var enabledCardCategories: [CardCategory] {
        switchableCardCategories
            .filter { $0.isEnabled }
            .map { $0.category }
    }

    var lastEnabledCategoryIndex: Int {
        switchableCardCategories.lastIndex { $0.isEnabled } ?? -1
    }

    var isAvailableToSwitchOff: Bool {
        enabledCardCategories.count > 1
    }

    func setCategory(
        _ category: CardCategory,
        enabled: Bool,
        movedFrom sourceIndex: inout Int?,
        to destinationIndex: inout Int?
    ) {
        var cardCategories = switchableCardCategories

        guard let indexedCategory = indexedCategory(category) else { return }

        var switchableCategory = indexedCategory.element
        switchableCategory.isEnabled = enabled

        cardCategories[indexedCategory.offset] = switchableCategory

        let fromIndex: Int = indexedCategory.offset
        let toIndex: Int = enabled ? (lastEnabledCategoryIndex + 1) : (cardCategories.count - 1)

        cardCategories.moveElement(from: fromIndex, to: toIndex)

        sourceIndex = fromIndex
        destinationIndex = toIndex

        profileManager.updateCategories(cardCategories)
    }

    func moveCategory(from sourceIndex: Int, to destinationIndex: Int) {
        var cardCategories = switchableCardCategories
        cardCategories.moveElement(from: sourceIndex, to: destinationIndex)
        profileManager.updateCategories(cardCategories)
    }

    func saveCategoriesIfNeeded() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        profileManager.saveProfileIfNeeded()
    }

    private func indexedCategory(_ category: CardCategory) -> EnumeratedSequence<[CardCategoryModel]>.Element? {
        switchableCardCategories
            .enumerated()
            .first(where: { $1.category == category })
    }

}
