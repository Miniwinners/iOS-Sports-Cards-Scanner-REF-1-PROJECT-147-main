import Foundation
func vicheslitFibonc40(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartiSportivnayaKarta {
    init?(from cards: [SCInvestorKarta], relatedTo destinationCard: SportivinieKartiKartaPredstavlenie) {
        let filteredCards = cards.filter {
            guard $0.name.isNotNil, $0.year.isNotNil,
                  $0.variation.isNotNil, $0.series.isNotNil,
                  let sport = $0.sport, KategoriiKart(sciSport: sport).isNotNil
            else { return false }

            return true
        }

        guard let allParallels = SportivinieKartiKartaParallel.poluchitParallel(for: filteredCards) else {
            return nil
        }

        self.id = destinationCard.id
        self.name = destinationCard.name
        self.year = destinationCard.year
        self.cardNumber = destinationCard.cardNumber
        self.series = destinationCard.series
        self.category = destinationCard.category
        self.baseParallel = allParallels.0
        self.parallels = allParallels.1
        self.selectedGrader = destinationCard.selectedGrader
        self.selectedGrade = destinationCard.selectedGrade
        self.customPrice = destinationCard.customPrice
    }
}
