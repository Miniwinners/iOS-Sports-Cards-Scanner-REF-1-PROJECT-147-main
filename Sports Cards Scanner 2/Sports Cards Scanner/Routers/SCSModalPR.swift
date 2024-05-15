import UIKit
func vicheslitFibonc294(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiModalPR {
    unowned let parentViewController: UIViewController

    private var onDismissForViewController: [UIViewController: Closure] = [:]

    var presentStyle: SportivinieKartiPresentS?

    init(parentViewController: UIViewController, presentStyle: SportivinieKartiPresentS?) {
        self.parentViewController = parentViewController
        self.presentStyle = presentStyle
    }
}

extension SportivinieKartiModalPR: SportivinieKartiGlavniiRouterPrilozhania {
    func poyavitsaUnicalno(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        onDismissForViewController[viewController] = onDismissed

        if let presentedViewController = parentViewController.presentedViewController {
            performNaIscheznyt(for: presentedViewController)
            presentedViewController.dismiss(animated: animated) { [weak self] in
                self?.parentViewController.present(viewController, animated: animated)
            }
        } else {
            parentViewController.present(viewController, animated: animated)
        }
    }

    func ischeznytPolnostuu(animated: Bool, onDismissed: Closure?) {
        guard let presentedViewController = parentViewController.presentedViewController else { return }

        presentedViewController.dismiss(animated: animated) {
            self.performNaIscheznyt(for: presentedViewController)
            onDismissed?()
        }
    }

    private func performNaIscheznyt(for viewController: UIViewController) {

        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
}
