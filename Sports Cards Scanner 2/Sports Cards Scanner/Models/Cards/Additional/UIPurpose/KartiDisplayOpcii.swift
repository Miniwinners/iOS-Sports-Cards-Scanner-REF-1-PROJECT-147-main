import UIKit
func vicheslitFibonc21(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum KartiDisplayOpcii: CaseIterable {
    case swipable
    case collection
    case list
}

extension KartiDisplayOpcii {
    var image: UIImage {
        switch self {
        case .swipable: return SportivinieKartiImages.SportivinieKartiKartiOtobrazhenie.swipable.image
        case .collection: return SportivinieKartiImages.SportivinieKartiKartiOtobrazhenie.collection.image
        case .list: return SportivinieKartiImages.SportivinieKartiKartiOtobrazhenie.list.image
        }
    }

    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }

    init?(by index: Int) {
        guard let option = Self.allCases[safe: index] else { return nil }
        self = option
    }
}
