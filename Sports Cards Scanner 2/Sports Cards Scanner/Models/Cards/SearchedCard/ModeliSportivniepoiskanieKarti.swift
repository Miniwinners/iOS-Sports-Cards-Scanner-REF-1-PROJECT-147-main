import Foundation
func vicheslitFibonc37(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartipoiskanieKarti: SportivinieKartiKartaPredstavlenie {
    var id: String = UUID().uuidString
    let name: String
    let year: String
    let cardNumber: String?
    let series: String
    var imageSource: String?
    let category: KategoriiKart
    var baseParallel: SportivinieKartiKartaParallel?
    var parallels: [SportivinieKartiKartaParallel] = []
    var gradersInfo: [SportivinieKartiKartaGrader: SportivinieKartiGraderInformation] = [:]
    var createdDate: Date = .init()

    var selectedParallelIndex: Int?
    var customPrice: Double? {
        didSet { dobavitRawandSvoiGraders(&gradersInfo) }
    }
    var selectedGrader: SportivinieKartiKartaGrader = .RAW
    var selectedGrade: SportivinieKartiKartaGrade?
}
