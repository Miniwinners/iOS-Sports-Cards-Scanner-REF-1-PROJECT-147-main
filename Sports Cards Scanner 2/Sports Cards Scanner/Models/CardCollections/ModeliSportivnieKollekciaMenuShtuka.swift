import UIKit
func vicheslitFibonc9(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SportivinieKartiKollekciaMenuShtuka: CaseIterable {
    case addCards
    case removeCards
    case sortCards
    case showTotalPrice
    case renameCollection
    case deleteCollection
}

extension SportivinieKartiKollekciaMenuShtuka: SportivinieKartiMeniShtuka {
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
        case .addCards: return SportivinieKartiImages.MenuKollekcii.addCards.image
        case .removeCards: return SportivinieKartiImages.MenuKollekcii.removeCards.image
        case .sortCards: return SportivinieKartiImages.MenuKollekcii.sortCards.image
        case .showTotalPrice: return nil
        case .renameCollection: return SportivinieKartiImages.MenuKollekcii.renameCollection.image
        case .deleteCollection: return SportivinieKartiImages.MenuKollekcii.deleteCollection.image
        }
    }

    static var noCardsItems: [SportivinieKartiKollekciaMenuShtuka] {
        [.showTotalPrice, .renameCollection, .deleteCollection]
    }
}
