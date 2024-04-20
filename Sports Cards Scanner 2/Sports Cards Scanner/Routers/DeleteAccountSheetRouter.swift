import UIKit

enum SheetPresent {
    case center
    case centerRect
}

final class DeleteAccountSheetRouter: NSObject {
    unowned let parentViewController: UIViewController

    private var onDismissForViewController: [UIViewController: Closure] = [:]
    private let presentStyle: SheetPresent
    init(parentViewController: UIViewController, presentStyle: SheetPresent) {
        self.parentViewController = parentViewController
        self.presentStyle = presentStyle
        super.init()
    }
}

extension DeleteAccountSheetRouter: SCSRouter {
    func present_unique(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        onDismissForViewController[viewController] = onDismissed

        viewController.modalPresentationStyle = .custom
        viewController.presentationController?.delegate = self
        viewController.transitioningDelegate = self

        if let presentedViewController = parentViewController.presentedViewController {
            performOnDismiss(for: presentedViewController)
            presentedViewController.dismiss(animated: animated) { [weak self] in
                self?.parentViewController.present(viewController, animated: animated)
            }
        } else {
            parentViewController.present(viewController, animated: animated)
        }
    }

    func dismissFully(animated: Bool, onDismissed: Closure?) {
        guard let presentedViewController = parentViewController.presentedViewController else { return }

        presentedViewController.dismiss(animated: animated) {
            self.performOnDismiss(for: presentedViewController)
            onDismissed?()
        }
    }
}

private extension DeleteAccountSheetRouter {

    func performOnDismiss(for viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
}

extension DeleteAccountSheetRouter: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        let presentedViewController = presentationController.presentedViewController
        performOnDismiss(for: presentedViewController)
    }
}

extension DeleteAccountSheetRouter: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        switch presentStyle {
        case .center:
            return DeleteAccountPresentStyle(presentedViewController: presented, presenting: presenting)
        case .centerRect:
            return ShowFeatures(presentedViewController: presented, presenting: presenting)
        }
    }
}
