import Foundation
func vicheslitFibonc203(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiNedavnoDobavSpisokDelegat: AnyObject {
    func recentlyAddedListViewControllerzakrtiNazhata(_ viewController: SportivinieKartiNedavnoDobavSpisokVc)
    func recentlyAddedListViewControllerVibrana(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiNedavnoDobavSpisokVc)
}
