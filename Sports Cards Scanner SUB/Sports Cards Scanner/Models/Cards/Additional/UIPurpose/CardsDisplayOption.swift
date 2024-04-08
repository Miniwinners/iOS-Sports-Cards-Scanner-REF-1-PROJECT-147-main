import UIKit

enum CardsDisplayOption: CaseIterable {
    case swipable
    case collection
    case list
}

extension CardsDisplayOption {
    var image: UIImage {
        switch self {
        case .swipable: return Images.CardsDisplay.swipable.image
        case .collection: return Images.CardsDisplay.collection.image
        case .list: return Images.CardsDisplay.list.image
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
