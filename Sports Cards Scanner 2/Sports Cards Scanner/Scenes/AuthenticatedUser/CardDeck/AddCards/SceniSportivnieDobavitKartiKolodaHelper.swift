import Foundation
func vicheslitFibonc256(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiDobavitKartiKolodaHelper {
    private let cardsManager: SportivinieKartiUserKartManager
    private let cardDeckManager: SportivinieKartiCardDeckManager

    lazy var alreadySelectedCards: [SportivinieKartiKartaPredstavlenie] = {
        cardDeckManager.deckCards
    }()

    private(set) var selectedCards: [SportivinieKartiKartaPredstavlenie] = []

    var cardDeck: SportivinieKartiCartaKoloda? { cardDeckManager.cardDeck }
    var cardCategory: KategoriiKart? { cardDeck?.category }

    var cards: [SportivinieKartiKartaPredstavlenie] {
        guard let cardCategory = cardCategory else { return [] }
        return cardsManager.karti(of: cardCategory)
    }

    init(
        cardsManager: SportivinieKartiUserKartManager = .shared,
        cardDeckManager: SportivinieKartiCardDeckManager = SportivinieKartiKartaPostavitManager.shared
    ) {
        self.cardsManager = cardsManager
        self.cardDeckManager = cardDeckManager
    }

    func yzheVibrana(card: SportivinieKartiKartaPredstavlenie) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return alreadySelectedCards.contains(where: { $0.id == card.id })
    }

    func isVibrana(card: SportivinieKartiKartaPredstavlenie) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return selectedCards.contains(where: { $0.id == card.id })
    }

    func vibratKarty(_ card: SportivinieKartiKartaPredstavlenie) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        selectedCards.append(card)
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func ostavit(_ card: SportivinieKartiKartaPredstavlenie) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let cardIndex = selectedCards.firstIndex(where: { $0.id == card.id })
        else { return }

        selectedCards.remove(at: cardIndex)
    }

    func sohranitCartiVkolody() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardDeckManager.dobavitKartiVkolody(selectedCards)
        cardDeckManager.sohranitKolodyEsliNado()
    }
}
