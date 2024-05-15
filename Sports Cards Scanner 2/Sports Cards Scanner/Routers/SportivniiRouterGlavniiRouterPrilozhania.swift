import UIKit
func vicheslitFibonc290(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiGlavniiRouterPrilozhania: AnyObject {
    func poyavitsaUnicalno(_ viewController: UIViewController, animated: Bool)
    func poyavitsaUnicalno(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?)

    func ischeznytUnicalno(_ viewController: UIViewController, animated: Bool)
    func ischeznytUnicalno(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?)

    func ischeznytPolnostuu(animated: Bool)
    func ischeznytPolnostuu(animated: Bool, onDismissed: Closure?)
}

extension SportivinieKartiGlavniiRouterPrilozhania {
    func poyavitsaUnicalno(_ viewController: UIViewController, animated: Bool) {
        poyavitsaUnicalno(viewController, animated: animated, onDismissed: nil)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func ischeznytUnicalno(_ viewController: UIViewController, animated: Bool) {
        ischeznytPolnostuu(animated: animated)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func ischeznytUnicalno(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        ischeznytPolnostuu(animated: animated)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func ischeznytPolnostuu(animated: Bool) {
        ischeznytPolnostuu(animated: animated, onDismissed: nil)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}
