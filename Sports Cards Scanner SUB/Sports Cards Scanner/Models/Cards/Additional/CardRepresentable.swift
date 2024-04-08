import Foundation

protocol CardRepresentable: Codable {
    var id: String { get }
    var name: String { get }
    var year: String { get }
    var cardNumber: String? { get }
    var series: String { get }
    var imageSource: String? { get set }
    var category: CardCategory { get }
    var customPrice: Double? { get set }
    var createdDate: Date { get set }

    var baseParallel: CardParallel? { get set }
    var parallels: [CardParallel] { get set }
    var selectedParallelIndex: Int? { get set }

    var gradersInfo: [CardGrader: GraderInfo] { get }
    var selectedGrader: CardGrader { get set }
    var selectedGrade: CardGrade? { get set }

    var detailItemsList: [CardDetailsItem] { get }
}

extension CardRepresentable {
    var detailItemsList: [CardDetailsItem] { [] }

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

    var graders: [CardGrader] {
        gradersInfo.keys.sorted(by: { $0.index < $1.index })
    }

    var selectedParallel: CardParallel? {
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
            return prices(of: selectedGrader)?.averagePrice
        }
    }

    func prices(of grader: CardGrader) -> MinMaxPrices? {
        let graderInfo = gradersInfo[grader]
        return graderInfo?.prices
    }

    func priceRange(of grader: CardGrader) -> String? {
        let prices = prices(of: grader)
        return prices?.formattedPriceRange
    }

    func recentSales(of grader: CardGrader) -> [CardSale] {
        let graderInfo = gradersInfo[grader]
        let sales = graderInfo?.recentSales
        return sales ?? []
    }

    func lastSoldPrice(of grader: CardGrader) -> String? {
        recentSales(of: grader).first?.formattedPrice
    }

    func lastSoldDate(of grader: CardGrader) -> String? {
        recentSales(of: grader).first?.formattedDate
    }

    func addRawAndCustomGraders(_ gradersInfo: inout [CardGrader: GraderInfo]) {
        let rawGraderInfo = gradersInfo[.RAW] ?? .init()

        var prices: MinMaxPrices?
        if let price = customPrice {
            prices = .init(price: price)
        }

        let customGraderInfo = GraderInfo(prices: prices)

        gradersInfo[.RAW] = rawGraderInfo
        gradersInfo[.CUSTOM] = customGraderInfo
    }
}
