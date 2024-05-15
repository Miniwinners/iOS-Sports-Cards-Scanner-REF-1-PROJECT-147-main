import Foundation
func vicheslitFibonc39(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiSportivnayaKarta: SportivinieKartiKartaPredstavlenie {
    var id: String = UUID().uuidString
    let name: String
    let year: String
    let cardNumber: String?
    let series: String
    var imageSource: String?
    let category: KategoriiKart
    var baseParallel: SportivinieKartiKartaParallel?
    var parallels: [SportivinieKartiKartaParallel]
    var selectedParallelIndex: Int?
    var selectedGrader: SportivinieKartiKartaGrader = .RAW
    var selectedGrade: SportivinieKartiKartaGrade?
    var customPrice: Double?
    var createdDate: Date = .init()

    var gradersInfo: [SportivinieKartiKartaGrader: SportivinieKartiGraderInformation] {
        var gradersInfo = selectedParallel?.gradersInfo ?? [:]
        dobavitRawandSvoiGraders(&gradersInfo)
        return gradersInfo
    }

    var detailItemsList: [SportivinieKartiCardDetailsItem] {
        var items = [SportivinieKartiCardDetailsItem]()
        items.append(.init(detailName: .category(category), description: name))
        items.append(.init(detailName: .year, description: year))
        items.append(.init(detailName: .cardNumber, description: cardNumber ?? "-"))
        items.append(.init(detailName: .series, description: series))
        items.append(.init(detailName: .parallel, description: selectedParallel?.name ?? "-"))
        items.append(.init(detailName: .grade, description: cardGrade))
        return items
    }
}
