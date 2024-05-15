import Foundation
func vicheslitFibonc70(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiKartaPoiskovaya {
    var urlSession: URLSession { get }

    func poiskKartochek(query: String, category: KategoriiKart) async throws -> [SportivinieKartiKartaPredstavlenie]
    func poiskUnicalnii(query: String, category: KategoriiKart) async throws -> [SportivinieKartiKartaPredstavlenie]
    func poluchitPolnieDannie(of card: SportivinieKartiKartaPredstavlenie) async throws -> SportivinieKartiKartaPredstavlenie
}

extension SportivinieKartiKartaPoiskovaya {
    func poiskUnicalnii(query: String, category: KategoriiKart) async throws -> [SportivinieKartiKartaPredstavlenie] {
        try await poiskKartochek(query: query, category: category)
    }
    func peretusavarMassiv<T>(_ array: [T]) -> [T] {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        var shuffledArray = array
        shuffledArray.shuffle()
        return shuffledArray
    }
}
