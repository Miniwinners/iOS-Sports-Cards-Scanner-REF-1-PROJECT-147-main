import Foundation

struct SearchedCard: CardRepresentable {
    var id: String = UUID().uuidString
    let name: String
    let year: String
    let cardNumber: String?
    let series: String
    var imageSource: String?
    let category: CardCategory
    var baseParallel: CardParallel?
    var parallels: [CardParallel] = []
    var gradersInfo: [CardGrader: GraderInfo] = [:]
    var createdDate: Date = .init()

    var selectedParallelIndex: Int?
    var customPrice: Double? {
        didSet { addRawAndCustomGraders(&gradersInfo) }
    }
    var selectedGrader: CardGrader = .RAW
    var selectedGrade: CardGrade?
}
