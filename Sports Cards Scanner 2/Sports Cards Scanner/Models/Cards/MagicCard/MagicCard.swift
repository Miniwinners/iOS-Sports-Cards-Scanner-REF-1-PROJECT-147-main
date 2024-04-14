import Foundation

struct MagicCard: CardRepresentable {
    var id: String = UUID().uuidString
    let name: String
    let year: String
    let cardNumber: String?
    let series: String
    var imageSource: String?
    var selectedGrader: CardGrader = .RAW
    var selectedGrade: CardGrade?
    var customPrice: Double?
    var baseParallel: CardParallel?
    var parallels: [CardParallel]
    var selectedParallelIndex: Int?
    var createdDate: Date = .init()

    let colors: [MagicCardColor]
    let type: String?
    let manaValue: String?
    let power: String?
    let toughness: String?
    let rarity: String?
    let legalities: [LegalityOption: CardLegality]

    var gradersInfo: [CardGrader: GraderInfo] {
        var gradersInfo = selectedParallel?.gradersInfo ?? [:]
        addRawAndCustomGraders(&gradersInfo)
        return gradersInfo
    }

    var category: CardCategory { .soccer }

    var detailItemsList: [CardDetailsItem] {
        var items = [CardDetailsItem]()

//        items.append(.init(detailName: .category(category), description: name))
        items.append(.init(detailName: .year, description: year))
        items.append(.init(detailName: .cardNumber, description: cardNumber ?? "-"))
        items.append(.init(detailName: .series, description: series))
        items.append(.init(detailName: .parallel, description: selectedParallel?.name ?? "-"))
        items.append(.init(detailName: .grade, description: cardGrade))

        let colorsString = colors.map({ $0.localizable }).joined(separator: ", ")
        items.append(.init(detailName: colors.count == 1 ? .color : .colors, description: colorsString))

        items.append(.init(detailName: .type, description: type ?? "-"))
        items.append(.init(detailName: .manaValue, description: manaValue ?? "-"))
        items.append(.init(detailName: .power, description: power ?? "-"))
        items.append(.init(detailName: .toughness, description: toughness ?? "-"))
        items.append(.init(detailName: .rarity, description: rarity ?? "-"))

        for option in legalities.keys {
            items.append(.init(
                detailName: .legality(option),
                description: legalities[option]?.localizable ?? "-"
            ))
        }

        return items
    }
}
