import Foundation

struct PokemonCard: CardRepresentable {
    var id: String = UUID().uuidString
    let name: String
    let year: String
    let cardNumber: String?
    let series: String
    var imageSource: String?
    var baseParallel: CardParallel?
    var parallels: [CardParallel]
    var selectedParallelIndex: Int?
    var customPrice: Double?
    var selectedGrader: CardGrader = .RAW
    var selectedGrade: CardGrade?
    var createdDate: Date = .init()

    var gradersInfo: [CardGrader: GraderInfo] {
        var gradersInfo = selectedParallel?.gradersInfo ?? [:]
        addRawAndCustomGraders(&gradersInfo)
        return gradersInfo
    }

    var category: CardCategory { .pokemon }

    var detailItemsList: [CardDetailsItem] {
        var items = [CardDetailsItem]()
        items.append(.init(detailName: .category(category), description: name))
        items.append(.init(detailName: .year, description: year))
        items.append(.init(detailName: .cardNumber, description: cardNumber ?? "-"))
        items.append(.init(detailName: .series, description: series))
        items.append(.init(detailName: .parallel, description: selectedParallel?.name ?? "-"))
        items.append(.init(detailName: .grade, description: cardGrade))
        return items
    }
}
