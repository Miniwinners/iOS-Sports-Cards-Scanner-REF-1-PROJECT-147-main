import UIKit

 final class DeleteAccountSheetRouter: NSObject {
    unowned let parentViewController: UIViewController

    private var onDismissForViewController: [UIViewController: Closure] = [:]

    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
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
        return DeleteAccountPresentStyle(presentedViewController: presented, presenting: presenting)
    }
 }
// final class DeleteAccountSheetRouter: NSObject {
//    unowned let parentViewController: UIViewController
//
//    private var onDismissForViewController: [UIViewController: Closure] = [:]
//
//    init(parentViewController: UIViewController) {
//        self.parentViewController = parentViewController
//        super.init()
//    }
// }
//
// extension DeleteAccountSheetRouter: SCSRouter {
//    func present_unique(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
//        onDismissForViewController[viewController] = onDismissed
//
//        viewController.modalPresentationStyle = .pageSheet
//        viewController.presentationController?.delegate = self
//        setupPresentationController(for: viewController)
//
//        if let presentedViewController = parentViewController.presentedViewController {
//            performOnDismiss(for: presentedViewController)
//            presentedViewController.dismiss(animated: animated) { [weak self] in
//                self?.parentViewController.present(viewController, animated: animated)
//            }
//        } else {
//            parentViewController.present(viewController, animated: animated)
//        }
//    }
//
//    func dismissFully(animated: Bool, onDismissed: Closure?) {
//        guard let presentedViewController = parentViewController.presentedViewController else { return }
//
//        presentedViewController.dismiss(animated: animated) {
//            self.performOnDismiss(for: presentedViewController)
//            onDismissed?()
//        }
//    }
// }
//
// private extension DeleteAccountSheetRouter {
//    func setupPresentationController(for viewController: UIViewController) {
//        guard let presentationController = viewController.sheetPresentationController else { return }
//
//        if #available(iOS 16, *) {
//            presentationController.detents = [.custom(resolver: { _ in viewController.preferredContentSize.height })]
//        } else {
//            presentationController.detents = [.medium(), .large()]
//            presentationController.selectedDetentIdentifier = .medium
//        }
//
//        presentationController.preferredCornerRadius = 12
//    }
//
//    func performOnDismiss(for viewController: UIViewController) {
//        guard let onDismiss = onDismissForViewController[viewController] else {
//            return
//        }
//        onDismiss()
//        onDismissForViewController[viewController] = nil
//    }
// }
//
// extension DeleteAccountSheetRouter: UIAdaptivePresentationControllerDelegate {
//    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
//        let presentedViewController = presentationController.presentedViewController
//        performOnDismiss(for: presentedViewController)
//    }
// }
