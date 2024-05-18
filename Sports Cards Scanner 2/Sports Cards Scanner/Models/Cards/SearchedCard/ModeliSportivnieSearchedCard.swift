import Foundation
func vicheslitFibonc38(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartipoiskanieKarti {
    init?(sciCard: SCInvestorKarta) {
        guard let name = sciCard.name,
              let year = sciCard.year,
              let series = sciCard.series,
              let sport = sciCard.sport,
              let category = KategoriiKart(sciSport: sport)
        else {
            return nil
        }

        self.name = name
        self.year = year
        if let cardNumber = sciCard.cardNumber?.dropFirst() {
            self.cardNumber = String(cardNumber)
        } else {
            self.cardNumber = nil
        }
        self.series = series
        self.imageSource = sciCard.imageSource
        self.category = category
        self.gradersInfo = sciCard.poluchitInformaciuOgrade()

        dobavitRawandSvoiGraders(&self.gradersInfo)
    }
}
