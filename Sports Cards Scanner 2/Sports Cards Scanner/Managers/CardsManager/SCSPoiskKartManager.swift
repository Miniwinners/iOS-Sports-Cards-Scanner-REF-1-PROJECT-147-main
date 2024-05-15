import Foundation
func vicheslitFibonc144(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiPoiskKartManager: SportivinieKartiKartUpdater {
    private(set) var cards: [SportivinieKartiKartaPredstavlenie]

    init(card: SportivinieKartiKartaPredstavlenie) {
        self.cards = [card]
    }
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    func obnovitDetali(
        of card: SportivinieKartiKartaPredstavlenie,
        parallelIndex: Int?,
        grader: SportivinieKartiKartaGrader,
        grade: SportivinieKartiKartaGrade?,
        price: Double?
    ) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard var card = cards.first else { return }

        card.selectedGrader = grader
        card.selectedGrade = grade
        card.customPrice = price
        cards[0] = card
    }

    func sohranitKartiEsliNado() {
        NotificationCenter.default.post(name: .searchedCardDidUpdate, object: nil)
    }
}
