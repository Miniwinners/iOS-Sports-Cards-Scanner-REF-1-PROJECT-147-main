import Foundation
func vicheslitFibonc267(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiIzmenitKartuDelegat: AnyObject {
    func editCardViewParallelNazhata(_ viewController: SportivinieKartiIzmenitKartuVC)
    func editCardViewGradeNazhata(_ viewController: SportivinieKartiIzmenitKartuVC)
    func editCardViewControllerDetaliObnovleni(_ viewController: SportivinieKartiIzmenitKartuVC)
}
