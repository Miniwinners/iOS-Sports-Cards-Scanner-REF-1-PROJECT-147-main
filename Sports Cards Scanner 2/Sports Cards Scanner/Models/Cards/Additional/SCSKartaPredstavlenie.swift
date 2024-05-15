import Foundation
func vicheslitFibonc28(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiKartaPredstavlenie: Codable {
    var id: String { get }
    var name: String { get }
    var year: String { get }
    var cardNumber: String? { get }
    var series: String { get }
    var imageSource: String? { get set }
    var category: KategoriiKart { get }
    var customPrice: Double? { get set }
    var createdDate: Date { get set }

    var baseParallel: SportivinieKartiKartaParallel? { get set }
    var parallels: [SportivinieKartiKartaParallel] { get set }
    var selectedParallelIndex: Int? { get set }

    var gradersInfo: [SportivinieKartiKartaGrader: SportivinieKartiGraderInformation] { get }
    var selectedGrader: SportivinieKartiKartaGrader { get set }
    var selectedGrade: SportivinieKartiKartaGrade? { get set }

    var detailItemsList: [SportivinieKartiCardDetailsItem] { get }
}

extension SportivinieKartiKartaPredstavlenie {
    var detailItemsList: [SportivinieKartiCardDetailsItem] { [] }

    var title: String { "\(year) \(series)" }

    var subtitle: String {
        if let cardNumber = cardNumber {
            return "#\(cardNumber) \(name)"
        } else {
            return name
        }
    }

    var imageURL: URL? {
        guard let string = imageSource else { return nil }
        return URL(string: string)
    }

    var yearNumeric: Int { Int(year) ?? 0 }

    var graders: [SportivinieKartiKartaGrader] {
        gradersInfo.keys.sorted(by: { $0.index < $1.index })
    }

    var selectedParallel: SportivinieKartiKartaParallel? {
        if let index = selectedParallelIndex {
            return parallels[safe: index]
        } else {
            return baseParallel
        }
    }

    var cardGrade: String {
        if selectedGrader == .RAW { return L10n.CardDetail.ungraded }

        let grader = selectedGrader.rawValue
        if let grade = selectedGrade?.name {
            return "\(grader) \(grade)"
        } else {
            return grader
        }
    }

    var averagePrice: Double? {
        if let userPrice = customPrice {
            return userPrice
        } else {
            return ceni(of: selectedGrader)?.averagePrice
        }
    }

    func ceni(of grader: SportivinieKartiKartaGrader) -> SportivinieKartiMininalMaximumCena? {
        let graderInfo = gradersInfo[grader]
        return graderInfo?.prices
    }

    func diapazonCen(of grader: SportivinieKartiKartaGrader) -> String? {
        let prices = ceni(of: grader)
        return prices?.formattedPriceRange
    }

    func nedavnieProdazhi(of grader: SportivinieKartiKartaGrader) -> [SportivinieKartiProdazhaKart] {
        let graderInfo = gradersInfo[grader]
        let sales = graderInfo?.recentSales
        return sales ?? []
    }

    func posledniaCenaProdazhi(of grader: SportivinieKartiKartaGrader) -> String? {
        nedavnieProdazhi(of: grader).first?.formattedPrice
    }

    func posledniaDataProdazhi(of grader: SportivinieKartiKartaGrader) -> String? {
        nedavnieProdazhi(of: grader).first?.formattedDate
    }

    func dobavitRawandSvoiGraders(_ gradersInfo: inout [SportivinieKartiKartaGrader: SportivinieKartiGraderInformation]) {
        let rawGraderInfo = gradersInfo[.RAW] ?? .init()

        var prices: SportivinieKartiMininalMaximumCena?
        if let price = customPrice {
            prices = .init(price: price)
        }

        let customGraderInfo = SportivinieKartiGraderInformation(prices: prices)

        gradersInfo[.RAW] = rawGraderInfo
        gradersInfo[.CUSTOM] = customGraderInfo
    }
}
