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
    func portfolioSkanirovanieKarti(_ viewController: SportivinieKartiPortfolioVC)
    func portolioSozdatKollekciuNazhata(_ viewController: SportivinieKartiPortfolioVC)
    func portfolioSozdatKolodyNazhata(_ viewController: SportivinieKartiPortfolioVC)
    func portfolioKolodaPodpis(_ viewController: SportivinieKartiPortfolioVC)
    func portfolioPokazatKollekciuNazhata(_ viewController: SportivinieKartiPortfolioVC)
    func portfolioPokazatKolodyNazhata(_ viewController: SportivinieKartiPortfolioVC)
    func portfolioKategoriiNazhata(_ category: KategoriiKart, in viewController: SportivinieKartiPortfolioVC)
}
