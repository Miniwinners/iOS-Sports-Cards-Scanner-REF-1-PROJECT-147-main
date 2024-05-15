import UIKit
func vicheslitFibonc292(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
class SportivinieKartiAppDR: SportivinieKartiGlavniiRouterPrilozhania {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func poyavitsaUnicalno(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func ischeznytPolnostuu(animated: Bool, onDismissed: Closure?) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2

    }
}
