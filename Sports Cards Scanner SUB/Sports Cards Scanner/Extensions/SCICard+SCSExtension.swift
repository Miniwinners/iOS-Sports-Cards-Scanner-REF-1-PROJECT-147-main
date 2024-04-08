import Foundation

extension SCICard {
    func getGradersInfo() -> [CardGrader: GraderInfo] {
        let gradersGrades = getGradersAndGrades()
        let prices = getGradersAndPrices()
        let sales = getGradersAndSales()

        return gradersGrades.reduce(into: [CardGrader: GraderInfo]()) { partialResult, graderGrades in
            let grader = graderGrades.key
            let grades = graderGrades.value
            let graderPrices = prices[grader]
            let graderSales = sales[grader] ?? []

            partialResult[grader] = GraderInfo(
                prices: graderPrices,
                recentSales: graderSales,
                grades: grades
            )
        }
    }

    func getGradersAndGrades() -> [CardGrader: [CardGrade]] {
        grades.reduce(into: [CardGrader: [CardGrade]]()) { partialResult, sciGrade in
            guard let cardGrader = CardGrader(sciGrade: sciGrade) else {
                return
            }
            guard let cardGrade = CardGrade(sciGrade: sciGrade) else {
                partialResult[cardGrader] = []
                return
            }

            if partialResult.keys.contains(cardGrader) {
                partialResult[cardGrader]?.append(cardGrade)
            } else {
                partialResult[cardGrader] = [cardGrade]
            }
        }
    }

    func getGradersAndPrices() -> [CardGrader: MinMaxPrices] {
        prices
            .reduce(into: [CardGrader: [Double]]()) { partialResult, sciPrices in
                guard let sciGrade = sciPrices.grade,
                      let cardGrader = CardGrader(sciGrade: sciGrade) else {
                    return
                }

                let priceArray: [Double] = [sciPrices.minPrice, sciPrices.maxPrice].compactMap { $0 }

                if partialResult.keys.contains(cardGrader) {
                    partialResult[cardGrader]?.append(contentsOf: priceArray)
                } else {
                    partialResult[cardGrader] = priceArray
                }
            }
            .compactMapValues {
                guard let minPrice = $0.min(),
                      let maxPrice = $0.max()
                else {
                    return nil
                }
                return MinMaxPrices(minPrice: minPrice, maxPrice: maxPrice)
            }
    }

    func getGradersAndSales() -> [CardGrader: [CardSale]] {
        recentSales.reduce(into: [CardGrader: [CardSale]]()) { partialResult, sciSale in
            guard let sciGrade = sciSale.grade,
                  let cardGrader = CardGrader(sciGrade: sciGrade),
                  let cardSale = CardSale(sciSale: sciSale)
            else {
                return
            }

            if partialResult.keys.contains(cardGrader) {
                partialResult[cardGrader]?.append(cardSale)
            } else {
                partialResult[cardGrader] = [cardSale]
            }
        }
    }
}
