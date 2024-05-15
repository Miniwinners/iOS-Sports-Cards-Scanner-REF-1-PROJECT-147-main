import Foundation
func vicheslitFibonc42(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartimagicheskayaKarta: SportivinieKartiKartaPredstavlenie {
    var id: String = UUID().uuidString
    let name: String
    let year: String
    let cardNumber: String?
    let series: String
    var imageSource: String?
    var selectedGrader: SportivinieKartiKartaGrader = .RAW
    var selectedGrade: SportivinieKartiKartaGrade?
    var customPrice: Double?
    var baseParallel: SportivinieKartiKartaParallel?
    var parallels: [SportivinieKartiKartaParallel]
    var selectedParallelIndex: Int?
    var createdDate: Date = .init()

    let colors: [SportivinieKartiMagiaKartaCvet]
    let type: String?
    let manaValue: String?
    let power: String?
    let toughness: String?
    let rarity: String?
    let legalities: [OpciiLegalnosti: LegalnostKarti]

    var gradersInfo: [SportivinieKartiKartaGrader: SportivinieKartiGraderInformation] {
        var gradersInfo = selectedParallel?.gradersInfo ?? [:]
        dobavitRawandSvoiGraders(&gradersInfo)
        return gradersInfo
    }

    var category: KategoriiKart { .soccer }

    var detailItemsList: [SportivinieKartiCardDetailsItem] {
        var items = [SportivinieKartiCardDetailsItem]()

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
