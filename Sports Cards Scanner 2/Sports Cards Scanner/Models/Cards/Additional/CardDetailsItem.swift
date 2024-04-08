import Foundation

struct CardDetailsItem {
    let detailName: CardDetailName
    let description: String

    var name: String { detailName.localizable }
}
