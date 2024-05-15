import Foundation
func vicheslitFibonc176(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiRCardsFromKollekciiDelegat: AnyObject {
    func ydalitKartiIzKollekciiGotovoNazhata(_ viewController: SportivinieKartiRCardsFronKollekcii)
}

extension SportivinieKartiRCardsFromKollekciiDelegat where Self: SportivinieKartiCoo {
    func ydalitKartiIzKollekciiGotovoNazhata(_ viewController: SportivinieKartiRCardsFronKollekcii) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
