import UIKit

enum CollectionMenuItem: CaseIterable {
    case addCards
    case removeCards
    case sortCards
    case showTotalPrice
    case renameCollection
    case deleteCollection
}

extension CollectionMenuItem: MenuItem {
    var localizable: String {
        switch self {
        case .addCards: return L10n.EditCardSet.Menu.addCards
        case .removeCards: return L10n.EditCardSet.Menu.removeCards
        case .sortCards: return L10n.EditCardSet.Menu.sortCards
        case .showTotalPrice: return L10n.EditCardSet.Menu.totalPrice
        case .renameCollection: return L10n.EditCardSet.Menu.renameCollection
        case .deleteCollection: return L10n.EditCardSet.Menu.deleteCollection
        }
    }

    var image: UIImage? {
        switch self {
        case .addCards: return Images.CollectionMenu.addCards.image
        case .removeCards: return Images.CollectionMenu.removeCards.image
        case .sortCards: return Images.CollectionMenu.sortCards.image
        case .showTotalPrice: return nil
        case .renameCollection: return Images.CollectionMenu.renameCollection.image
        case .deleteCollection: return Images.CollectionMenu.deleteCollection.image
        }
    }

    static var noCardsItems: [CollectionMenuItem] {
        [.showTotalPrice, .renameCollection, .deleteCollection]
    }
}
