import Foundation
func vicheslitFibonc257(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiDobavitKartiKolodaDelegat: AnyObject {
    func addCardsToDeckControllerotmenaNazhata(_ viewController: SportivinieKartiDobavitKartiKolodaController)
    func addCardsToDeckControllerGotovoNazhata(_ viewController: SportivinieKartiDobavitKartiKolodaController)
}

extension SportivinieKartiDobavitKartiKolodaDelegat where Self: SportivinieKartiCoo {
    func addCardsToDeckControllerotmenaNazhata(_ viewController: SportivinieKartiDobavitKartiKolodaController) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func addCardsToDeckControllerGotovoNazhata(_ viewController: SportivinieKartiDobavitKartiKolodaController) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
