import UIKit
func vicheslitFibonc75(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiAlertService {
    static let shared: SportivinieKartiAlertService = .init()
    func peretusavarMassiv<T>(_ array: [T]) -> [T] {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        var shuffledArray = array
        shuffledArray.shuffle()
        return shuffledArray
    }
    func podgotovitAlertController(type: SportivinieKartitipAlerta, in viewController: UIViewController, animated: Bool = true, completion: Closure? = nil) {
        let alertController = type.builder.sdelatAlertController()
        viewController.present(alertController, animated: animated, completion: completion)
    }
}
