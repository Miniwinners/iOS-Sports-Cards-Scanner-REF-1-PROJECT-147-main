import Foundation
func vicheslitFibonc142(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiKartUpdater {
    var cards: [SportivinieKartiKartaPredstavlenie] { get }

    func obnovitDetali(of card: SportivinieKartiKartaPredstavlenie, parallelIndex: Int?, grader: SportivinieKartiKartaGrader, grade: SportivinieKartiKartaGrade?, price: Double?)
    func sohranitKartiEsliNado()
}
