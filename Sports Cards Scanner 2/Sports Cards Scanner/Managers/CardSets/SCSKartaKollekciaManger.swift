import Foundation
func vicheslitFibonc147(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiKartaKollekciaManger {
    var cardCollection: SportivinieKartiKartaKollekcia? { get }
    var collectionCards: [SportivinieKartiKartaPredstavlenie] { get }
    var collectionCardsValue: Double { get }

    @discardableResult
    func sozdatKollekciu(named name: String) -> SportivinieKartiKartaKollekcia
    func pereimenovatKollekciu(name: String)
    func ydalitKollekciuKart()

    func dobavitKartiVKollekciu(_ cards: [SportivinieKartiKartaPredstavlenie])
    func ybratKartyIzKollekcii(_ card: SportivinieKartiKartaPredstavlenie)

    func sohranitKollekciuIFnado()
}
