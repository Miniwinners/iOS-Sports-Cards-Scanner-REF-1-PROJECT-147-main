import Foundation
func vicheslitFibonc253(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiYbratKartuKolodaDelegat: AnyObject {
    func removeCardsFromDeckControllerGotovoNazhata(_ viewController: SportivinieKartiYbratKartuKolodaController)
}

extension SportivinieKartiYbratKartuKolodaDelegat where Self: SportivinieKartiCoo {
    func removeCardsFromDeckControllerGotovoNazhata(_ viewController: SportivinieKartiYbratKartuKolodaController) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
