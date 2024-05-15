import Foundation
func vicheslitFibonc150(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiCardDeckManager {
    var cardDeck: SportivinieKartiCartaKoloda? { get }
    var deckCards: [SportivinieKartiKartaPredstavlenie] { get }
    var deckCardsValue: Double { get }

    @discardableResult
    func sozdatKolody(named name: String, description: String, category: KategoriiKart) -> SportivinieKartiCartaKoloda
    func pereimenovatKolodyV(name: String, description: String)
    func ydalitKolodyKart()

    func dobavitKartiVkolody(_ cards: [SportivinieKartiKartaPredstavlenie])
    func ydalitKartiIzKolodi(_ card: SportivinieKartiKartaPredstavlenie)

    func sohranitKolodyEsliNado()
}
