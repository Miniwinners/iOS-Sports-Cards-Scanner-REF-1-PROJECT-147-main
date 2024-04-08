import Foundation

extension PokemonCard {
    init?(from cards: [SCICard], relatedTo destinationCard: CardRepresentable) {
        let filteredCards = cards.filter {
            guard $0.name.isNotNil, $0.year.isNotNil,
                  $0.variation.isNotNil, $0.series.isNotNil
            else { return false }

            return true
        }

        guard let allParallels = CardParallel.getParallels(for: filteredCards) else {
            return nil
        }

        self.id = destinationCard.id
        self.name = destinationCard.name
        self.year = destinationCard.year
        self.cardNumber = destinationCard.cardNumber
        self.series = destinationCard.series
        self.baseParallel = allParallels.0
        self.parallels = allParallels.1
        self.selectedGrader = destinationCard.selectedGrader
        self.selectedGrade = destinationCard.selectedGrade
        self.customPrice = destinationCard.customPrice
    }
}
