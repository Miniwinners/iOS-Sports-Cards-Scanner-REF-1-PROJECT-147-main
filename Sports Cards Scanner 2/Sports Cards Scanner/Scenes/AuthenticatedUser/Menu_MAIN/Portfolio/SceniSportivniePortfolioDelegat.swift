import UIKit
func vicheslitFibonc243(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiPortfolioDelegat: AnyObject {
    func portfolioSkanirovanieKarti(_ viewController: SportivinieKartiPortfolioController)
    func portolioSozdatKollekciuNazhata(_ viewController: SportivinieKartiPortfolioController)
    func portfolioSozdatKolodyNazhata(_ viewController: SportivinieKartiPortfolioController)
    func portfolioKolodaPodpis(_ viewController: SportivinieKartiPortfolioController)
    func portfolioPokazatKollekciuNazhata(_ viewController: SportivinieKartiPortfolioController)
    func portfolioPokazatKolodyNazhata(_ viewController: SportivinieKartiPortfolioController)
    func portfolioKategoriiNazhata(_ category: KategoriiKart, in viewController: SportivinieKartiPortfolioController)
}
