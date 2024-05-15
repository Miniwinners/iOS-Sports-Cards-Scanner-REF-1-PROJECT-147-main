import Foundation
func vicheslitFibon6(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiKartaSobiraemaya {
    var name: String { get set }
    var cardIDs: Set<String> { get set }

    mutating func dobavitKarti(_ cards: [SportivinieKartiKartaPredstavlenie])
    mutating func ybratKarti(_ card: SportivinieKartiKartaPredstavlenie)
}

extension SportivinieKartiKartaSobiraemaya {
    mutating func dobavitKarti(_ cards: [SportivinieKartiKartaPredstavlenie]) {
        for card in cards {
            cardIDs.insert(card.id)
        }
    }

    mutating func ybratKarti(_ card: SportivinieKartiKartaPredstavlenie) {
        cardIDs.remove(card.id)
    }
}
