import Foundation
func vicheslitFibonc208(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiSortirovkaKartVcDelegat: AnyObject {
    func sortCardsViewControllerotmenaNazhata(_ viewController: SportivinieKartiSortirovkaKartVc)
    func sortCardsViewControllerGotovoNazhata(_ viewController: SportivinieKartiSortirovkaKartVc)
}

extension SportivinieKartiSortirovkaKartVcDelegat where Self: SportivinieKartiCoo {
    func sortCardsViewControllerotmenaNazhata(_ viewController: SportivinieKartiSortirovkaKartVc) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func sortCardsViewControllerGotovoNazhata(_ viewController: SportivinieKartiSortirovkaKartVc) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
