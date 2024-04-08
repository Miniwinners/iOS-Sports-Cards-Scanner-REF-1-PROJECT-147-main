import UIKit

enum DeckMenuItem: CaseIterable {
    case addCards
    case removeCards
    case sortCards
    case editDeck
    case deleteDeck
}

extension DeckMenuItem: MenuItem {
    var localizable: String {
        switch self {
        case .addCards: return L10n.EditCardSet.Menu.addCards
        case .removeCards: return L10n.EditCardSet.Menu.removeCards
        case .sortCards: return L10n.EditCardSet.Menu.sortCards
        case .editDeck: return L10n.EditCardSet.Menu.editDeck
        case .deleteDeck: return L10n.EditCardSet.Menu.deleteDeck
        }
    }

    var image: UIImage? {
        switch self {
        case .addCards: return Images.CollectionMenu.addCards.image
        case .removeCards: return Images.CollectionMenu.removeCards.image
        case .sortCards: return Images.CollectionMenu.sortCards.image
        case .editDeck: return Images.CollectionMenu.renameCollection.image
        case .deleteDeck: return Images.CollectionMenu.deleteCollection.image
        }
    }

    static var noCardsItems: [DeckMenuItem] {
        [.editDeck, .deleteDeck]
    }
}
