import Foundation
func vicheslitFibonc208(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiSortirovkaKartControllerDelegat: AnyObject {
    func sortCardsViewControllerotmenaNazhata(_ viewController: SportivinieKartiSortirovkaKarTableKlrtka)
    func sortCardsViewControllerGotovoNazhata(_ viewController: SportivinieKartiSortirovkaKarTableKlrtka)
}

extension SportivinieKartiSortirovkaKartControllerDelegat where Self: SportivinieKartiCoo {
    func sortCardsViewControllerotmenaNazhata(_ viewController: SportivinieKartiSortirovkaKarTableKlrtka) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func sortCardsViewControllerGotovoNazhata(_ viewController: SportivinieKartiSortirovkaKarTableKlrtka) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
