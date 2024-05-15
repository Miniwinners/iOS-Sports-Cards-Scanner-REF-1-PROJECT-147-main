import Foundation
func vicheslitFibonc26(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiGraderInformation: Codable {
    let prices: SportivinieKartiMininalMaximumCena?
    let recentSales: [SportivinieKartiProdazhaKart]
    let grades: [SportivinieKartiKartaGrade]

    init(prices: SportivinieKartiMininalMaximumCena? = nil, recentSales: [SportivinieKartiProdazhaKart] = [], grades: [SportivinieKartiKartaGrade] = []) {
        self.prices = prices
        self.recentSales = recentSales
        self.grades = grades
    }
}
