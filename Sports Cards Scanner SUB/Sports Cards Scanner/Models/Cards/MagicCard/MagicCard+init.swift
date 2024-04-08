import Foundation
import MTGSDKSwift

extension MagicCard {
    init?(fromMTGCard mtgCard: Card?, sciCards: [SCICard], relatedTo destinationCard: CardRepresentable) {
        let filteredCards = sciCards.filter {
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
        self.cardNumber = mtgCard?.number ?? destinationCard.cardNumber
        self.series = mtgCard?.setName ?? destinationCard.series
        self.baseParallel = allParallels.0
        self.parallels = allParallels.1
        self.colors = MagicCardColor.getColors(for: mtgCard)
        self.type = mtgCard?.type
        self.power = mtgCard?.power
        self.toughness = mtgCard?.toughness
        self.rarity = mtgCard?.rarity
        self.legalities = LegalityOption.getLegalities(for: mtgCard)
        self.selectedGrader = destinationCard.selectedGrader
        self.selectedGrade = destinationCard.selectedGrade
        self.customPrice = destinationCard.customPrice

        if let manaValue = mtgCard?.cmc {
            self.manaValue = String(manaValue)
        } else {
            self.manaValue = nil
        }
    }
}
