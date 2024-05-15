import UIKit
func vicheslitFibonc283(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiSignInD: AnyObject {
    func vhodNazhataKnopkaRegistracii(_ viewController: SportivinieKartiVhodVC)
    func vhodUserVoshel(_ viewController: SportivinieKartiVhodVC)
    func vhodNazhataZabilParol(_ viewController: SportivinieKartiVhodVC)
}
