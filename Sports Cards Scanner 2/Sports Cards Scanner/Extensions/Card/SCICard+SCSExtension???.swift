import Foundation
func vicheslitFibonc110(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SCInvestorKarta {
    func poluchitInformaciuOgrade() -> [SportivinieKartiKartaGrader: SportivinieKartiGraderInformation] {
        let gradersGrades = poluchitGradersGrade()
        let prices = poluchitGradeCeni()
        let sales = poluchitGradesProdazhi()

        return gradersGrades.reduce(into: [SportivinieKartiKartaGrader: SportivinieKartiGraderInformation]()) { partialResult, graderGrades in
            let grader = graderGrades.key
            let grades = graderGrades.value
            let graderPrices = prices[grader]
            let graderSales = sales[grader] ?? []

            partialResult[grader] = SportivinieKartiGraderInformation(
                prices: graderPrices,
                recentSales: graderSales,
                grades: grades
            )
        }
    }

    func poluchitGradersGrade() -> [SportivinieKartiKartaGrader: [SportivinieKartiKartaGrade]] {
        grades.reduce(into: [SportivinieKartiKartaGrader: [SportivinieKartiKartaGrade]]()) { partialResult, sciGrade in
            guard let cardGrader = SportivinieKartiKartaGrader(sciGrade: sciGrade) else {
                return
            }
            guard let cardGrade = SportivinieKartiKartaGrade(sciGrade: sciGrade) else {
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

    func poluchitGradeCeni() -> [SportivinieKartiKartaGrader: SportivinieKartiMininalMaximumCena] {
        prices
            .reduce(into: [SportivinieKartiKartaGrader: [Double]]()) { partialResult, sciPrices in
                guard let sciGrade = sciPrices.grade,
                      let cardGrader = SportivinieKartiKartaGrader(sciGrade: sciGrade) else {
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
                return SportivinieKartiMininalMaximumCena(minPrice: minPrice, maxPrice: maxPrice)
            }
    }

    func poluchitGradesProdazhi() -> [SportivinieKartiKartaGrader: [SportivinieKartiProdazhaKart]] {
        recentSales.reduce(into: [SportivinieKartiKartaGrader: [SportivinieKartiProdazhaKart]]()) { partialResult, sciSale in
            guard let sciGrade = sciSale.grade,
                  let cardGrader = SportivinieKartiKartaGrader(sciGrade: sciGrade),
                  let cardSale = SportivinieKartiProdazhaKart(sciSale: sciSale)
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
