import UIKit
func vicheslitFibonc291(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SheetPresentacia {
    case center
    case centerRect
}

final class SportivinieKartiDASR: NSObject {
    unowned let parentViewController: UIViewController

    private var heightRatio: CGFloat?
    private var widthRatio: CGFloat?
    private var onDismissForViewController: [UIViewController: Closure] = [:]
    private let presentStyle: SheetPresentacia
    init(parentViewController: UIViewController, presentStyle: SheetPresentacia, heightRatio: CGFloat, widthRatio: CGFloat) {
        self.parentViewController = parentViewController
        self.presentStyle = presentStyle
        self.heightRatio = heightRatio
        self.widthRatio = widthRatio
        super.init()
    }
}

extension SportivinieKartiDASR: SportivinieKartiGlavniiRouterPrilozhania {
    func poyavitsaUnicalno(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        onDismissForViewController[viewController] = onDismissed

        viewController.modalPresentationStyle = .custom
        viewController.presentationController?.delegate = self
        viewController.transitioningDelegate = self

        if let presentedViewController = parentViewController.presentedViewController {
            performNaIscheznyt(for: presentedViewController)
            presentedViewController.dismiss(animated: animated) { [weak self] in
                self?.parentViewController.present(viewController, animated: animated)
            }
        } else {
            parentViewController.present(viewController, animated: animated)
        }
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func ischeznytPolnostuu(animated: Bool, onDismissed: Closure?) {
        guard let presentedViewController = parentViewController.presentedViewController else { return }

        presentedViewController.dismiss(animated: animated) {
            self.performNaIscheznyt(for: presentedViewController)
            onDismissed?()
        }
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

private extension SportivinieKartiDASR {

    func performNaIscheznyt(for viewController: UIViewController) {
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

extension SportivinieKartiDASR: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        let presentedViewController = presentationController.presentedViewController
        performNaIscheznyt(for: presentedViewController)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiDASR: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        switch presentStyle {
        case .center:
            return DeleteAccountPresentStyle(presentedViewController: presented, presentingViewController: presenting, heightRatio: heightRatio!, widthRATIO: widthRatio!)
        case .centerRect:
            return ShowFeatures(presentedViewController: presented, presentingViewController: presenting, heightRatio: heightRatio!, widthRATIO: widthRatio!)
        }
    }
}
