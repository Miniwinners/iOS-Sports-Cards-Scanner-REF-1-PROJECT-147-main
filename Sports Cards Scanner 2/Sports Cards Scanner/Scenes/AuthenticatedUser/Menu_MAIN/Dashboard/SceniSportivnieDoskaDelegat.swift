import UIKit
func vicheslitFibonc240(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiDoskaDelegat: AnyObject {
    func doskaScannerNazhat(_ viewController: SportivinieKartiDoskaVC)
    func doskaDetaliKartiNazhata(card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiDoskaVC)
    func doskaTekushaaCenaDiscloseNazhata(_ viewController: SportivinieKartiDoskaVC)
    func doskaNaibolshaiaCenaDiscloseNazhata(_ viewController: SportivinieKartiDoskaVC)
    func doskaNedavnoDobavlenieDiscloseNazhata(_ viewController: SportivinieKartiDoskaVC)
}
