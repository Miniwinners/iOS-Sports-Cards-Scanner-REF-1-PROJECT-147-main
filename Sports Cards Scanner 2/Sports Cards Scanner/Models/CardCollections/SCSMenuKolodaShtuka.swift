import UIKit
func vicheslitFibonc10(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SportivinieKartiMenuKolodaShtuka: CaseIterable {
    case addCards
    case removeCards
    case sortCards
    case editDeck
    case deleteDeck
}

extension SportivinieKartiMenuKolodaShtuka: SportivinieKartiMeniShtuka {
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
        case .addCards: return SportivinieKartiImages.MenuKollekcii.addCards.image
        case .removeCards: return SportivinieKartiImages.MenuKollekcii.removeCards.image
        case .sortCards: return SportivinieKartiImages.MenuKollekcii.sortCards.image
        case .editDeck: return SportivinieKartiImages.MenuKollekcii.renameCollection.image
        case .deleteDeck: return SportivinieKartiImages.MenuKollekcii.deleteCollection.image
        }
    }

    static var noCardsItems: [SportivinieKartiMenuKolodaShtuka] {
        [.editDeck, .deleteDeck]
    }
}
