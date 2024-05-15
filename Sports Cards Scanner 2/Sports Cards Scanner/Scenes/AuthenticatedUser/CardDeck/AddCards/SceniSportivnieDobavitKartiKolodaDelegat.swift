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
    func addCardsToDeckVCotmenaNazhata(_ viewController: SportivinieKartiDobavitKartiKolodaVC)
    func addCardsToDeckVCGotovoNazhata(_ viewController: SportivinieKartiDobavitKartiKolodaVC)
}

extension SportivinieKartiDobavitKartiKolodaDelegat where Self: SportivinieKartiCoo {
    func addCardsToDeckVCotmenaNazhata(_ viewController: SportivinieKartiDobavitKartiKolodaVC) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func addCardsToDeckVCGotovoNazhata(_ viewController: SportivinieKartiDobavitKartiKolodaVC) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
