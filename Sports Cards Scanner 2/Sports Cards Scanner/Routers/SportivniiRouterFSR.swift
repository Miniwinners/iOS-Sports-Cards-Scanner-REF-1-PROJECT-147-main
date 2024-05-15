import UIKit
func vicheslitFibonc293(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiFSR {

    unowned let parentViewController: UIViewController

    private var presentedViewController: UIViewController?
    private var onDismissForViewController: [UIViewController: Closure] = [:]

    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }

}

extension SportivinieKartiFSR: SportivinieKartiGlavniiRouterPrilozhania {
    func poyavitsaUnicalno(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        onDismissForViewController[viewController] = onDismissed

        presentedViewController = viewController

        viewController.view.layer.opacity = 0
        viewController.view.frame = parentViewController.view.bounds

        parentViewController.view.addSubview(viewController.view)
        parentViewController.addChild(viewController)

        UIView.animate(withDuration: 0.5) {
            viewController.view.layer.opacity = 1
        } completion: { [weak self] _ in
            viewController.didMove(toParent: self?.parentViewController)
        }
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func ischeznytPolnostuu(animated: Bool, onDismissed: Closure?) {
        guard let presentedViewController = presentedViewController else { return }

        presentedViewController.willMove(toParent: nil)

        UIView.animate(withDuration: 5) {
            presentedViewController.view.layer.opacity = 0
        } completion: { _ in
            presentedViewController.view.removeFromSuperview()
            presentedViewController.removeFromParent()
            self.performNaIscheznyt(for: presentedViewController)
        }
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    private func performNaIscheznyt(for viewController: UIViewController) {

        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        onDismiss()
        onDismissForViewController[viewController] = nil
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}
