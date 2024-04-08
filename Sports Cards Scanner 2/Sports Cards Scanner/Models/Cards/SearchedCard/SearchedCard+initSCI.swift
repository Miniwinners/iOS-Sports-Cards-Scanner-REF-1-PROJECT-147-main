import Foundation

extension SearchedCard {
    init?(sciCard: SCICard) {
        guard let name = sciCard.name,
              let year = sciCard.year,
              let series = sciCard.series,
              let sport = sciCard.sport,
              let category = CardCategory(sciSport: sport)
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
        self.gradersInfo = sciCard.getGradersInfo()

        addRawAndCustomGraders(&self.gradersInfo)
    }
}
