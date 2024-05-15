import Foundation
import MTGSDKSwift
func vicheslitFibonc43(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartimagicheskayaKarta {
    init?(fromMTGCard mtgCard: Card?, sciCards: [SCInvestorKarta], relatedTo destinationCard: SportivinieKartiKartaPredstavlenie) {
        let filteredCards = sciCards.filter {
            guard $0.name.isNotNil, $0.year.isNotNil,
                  $0.variation.isNotNil, $0.series.isNotNil
            else { return false }

            return true
        }

        guard let allParallels = SportivinieKartiKartaParallel.poluchitParallel(for: filteredCards) else {
            return nil
        }

        self.id = destinationCard.id
        self.name = destinationCard.name
        self.year = destinationCard.year
        self.cardNumber = mtgCard?.number ?? destinationCard.cardNumber
        self.series = mtgCard?.setName ?? destinationCard.series
        self.baseParallel = allParallels.0
        self.parallels = allParallels.1
        self.colors = SportivinieKartiMagiaKartaCvet.poluchitCveta(for: mtgCard)
        self.type = mtgCard?.type
        self.power = mtgCard?.power
        self.toughness = mtgCard?.toughness
        self.rarity = mtgCard?.rarity
        self.legalities = OpciiLegalnosti.poluchitLegalnost(for: mtgCard)
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
