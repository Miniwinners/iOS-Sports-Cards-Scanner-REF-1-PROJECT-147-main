import Foundation
func vicheslitFibon273(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiCardOwnVCDetailDelegate: AnyObject {
    func cardDetailsViewControllerzakrtiNazhata(_ viewController: SportivinieKartiCardOwnVCDetail)
    func nazadNazhata(_ viewController: SportivinieKartiCardOwnVCDetail)
    func zakritPoslePoiska(_ viewController: SportivinieKartiCardOwnVCDetail)

    func graderNazhat(_ viewController: SportivinieKartiCardOwnVCDetail)
    func cenaObzorNazhata(_ viewController: SportivinieKartiCardOwnVCDetail)
    func izmenitKartuNazhata(_ viewController: SportivinieKartiCardOwnVCDetail)
    func naitiKartyNazhata(_ viewController: SportivinieKartiCardOwnVCDetail)

    func ybratKartyNazhata(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiCardOwnVCDetail)

    func kartaDobavlenaNazhata(_ viewController: SportivinieKartiCardOwnVCDetail)

    func izmenitKartyPodbischik(_ viewController: SportivinieKartiCardOwnVCDetail)
}
