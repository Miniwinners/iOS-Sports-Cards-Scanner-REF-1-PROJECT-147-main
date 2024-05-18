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
    func doskaScannerNazhat(_ viewController: SportivinieKartiDoskaController)
    func doskaDetaliKartiNazhata(card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiDoskaController)
    func doskaTekushaaCenaDiscloseNazhata(_ viewController: SportivinieKartiDoskaController)
    func doskaNaibolshaiaCenaDiscloseNazhata(_ viewController: SportivinieKartiDoskaController)
    func doskaNedavnoDobavlenieDiscloseNazhata(_ viewController: SportivinieKartiDoskaController)
}
