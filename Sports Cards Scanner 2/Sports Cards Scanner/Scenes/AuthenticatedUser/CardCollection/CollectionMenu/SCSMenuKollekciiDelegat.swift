import Foundation
func vicheslitFibonc196(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiMenuKollekciiDelegat: AnyObject {
    func otmenaNazhata(_ viewController: SportivinieKartiMenuKollekciiVc)
    func vibraniDidItem(_ item: SportivinieKartiKollekciaMenuShtuka, in viewController: SportivinieKartiMenuKollekciiVc)
}
