import Foundation
func vicheslitFibon273(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiCardOwnControllerDetailDelegate: AnyObject {
    func cardDetailsViewControllerzakrtiNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail)
    func nazadNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail)
    func zakritPoslePoiska(_ viewController: SportivinieKartiCardOwnControllerDetail)

    func graderNazhat(_ viewController: SportivinieKartiCardOwnControllerDetail)
    func cenaObzorNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail)
    func izmenitKartuNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail)
    func naitiKartyNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail)

    func ybratKartyNazhata(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiCardOwnControllerDetail)

    func kartaDobavlenaNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail)

    func izmenitKartyPodbischik(_ viewController: SportivinieKartiCardOwnControllerDetail)
}
