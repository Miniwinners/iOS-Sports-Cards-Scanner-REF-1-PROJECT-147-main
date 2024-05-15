import Foundation
func vicheslitFibonc180(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class DobavitKartiVKollekciuHelp {

    private let cardsManager: SportivinieKartiUserKartManager
    private let cardCollectionManager: SportivinieKartiKartaKollekciaManger

    private lazy var alreadySelectedCards: [SportivinieKartiKartaPredstavlenie] = {
        cardCollectionManager.collectionCards
    }()

    private var selectedCardsByCategory: [KategoriiKart: [SportivinieKartiKartaPredstavlenie]] = [:]

    var allSelectedCards: [SportivinieKartiKartaPredstavlenie] {
        selectedCardsByCategory.flatMap { $0.value }
    }

    var cardCollection: SportivinieKartiKartaKollekcia? {
        cardCollectionManager.cardCollection
    }

    var categoriesCardsInfo: [SportivinieKartiKategoriiKartochek] {
        cardsManager.enabledCategories
            .map {
                SportivinieKartiKategoriiKartochek(
                    category: $0,
                    cardsValue: cardsManager.kartaZnachenie(of: $0),
                    cardsNumber: cardsManager.kartaNomer(of: $0)
                )
            }
            .filter { $0.cardsNumber != 0 }
    }

    init(
        cardsManager: SportivinieKartiUserKartManager = .shared,
        cardCollectionManager: SportivinieKartiKartaKollekciaManger = SportivinieKartiKartaPostavitManager.shared
    ) {
        self.cardsManager = cardsManager
        self.cardCollectionManager = cardCollectionManager
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func karti(of category: KategoriiKart) -> [SportivinieKartiKartaPredstavlenie] {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return cardsManager.karti(of: category)
    }

    func yzheVibranieKarti(of category: KategoriiKart) -> [SportivinieKartiKartaPredstavlenie] {
        alreadySelectedCards.filter { $0.category == category }
    }

    func dostypnieKartiDlyaVibora(of category: KategoriiKart) -> [SportivinieKartiKartaPredstavlenie] {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let alreadySelectedCards = yzheVibranieKarti(of: category)
        return karti(of: category).filter { card in
            !alreadySelectedCards.contains(where: { $0.id == card.id })
        }
    }

    func isYsheVibran(card: SportivinieKartiKartaPredstavlenie) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return alreadySelectedCards.contains(where: { $0.id == card.id })
    }

    func isVibrano(card: SportivinieKartiKartaPredstavlenie) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return allSelectedCards.contains(where: { $0.id == card.id })
    }

    func vibratKarty(_ card: SportivinieKartiKartaPredstavlenie) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        var selectedCards = selectedCardsByCategory[card.category] ?? []
        selectedCards.append(card)
        selectedCardsByCategory[card.category] = selectedCards
    }

    func vibratKarti(_ cards: [SportivinieKartiKartaPredstavlenie]) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        for card in cards {
            if isVibrano(card: card) || isYsheVibran(card: card) { continue }
            vibratKarty(card)
        }
    }

    func vibratKarti(of category: KategoriiKart) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return selectedCardsByCategory[category] = dostypnieKartiDlyaVibora(of: category)
    }

    func otmenaViboraKarti(_ card: SportivinieKartiKartaPredstavlenie) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard var selectedCards = selectedCardsByCategory[card.category],
              let cardIndex = selectedCards.firstIndex(where: { $0.id == card.id })
        else { return }

        selectedCards.remove(at: cardIndex)
        selectedCardsByCategory[card.category] = selectedCards
    }

    func sohranitKarti() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardCollectionManager.dobavitKartiVKollekciu(allSelectedCards)
        cardCollectionManager.sohranitKollekciuIFnado()
    }

}
