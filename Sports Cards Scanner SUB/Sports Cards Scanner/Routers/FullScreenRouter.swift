import UIKit

final class FullScreenRouter {

    unowned let parentViewController: UIViewController

    private var presentedViewController: UIViewController?
    private var onDismissForViewController: [UIViewController: Closure] = [:]

    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }

}

extension FullScreenRouter: SCSRouter {
    func present_unique(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
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
    }

    func dismissFully(animated: Bool, onDismissed: Closure?) {
        guard let presentedViewController = presentedViewController else { return }

        presentedViewController.willMove(toParent: nil)

        UIView.animate(withDuration: 5) {
            presentedViewController.view.layer.opacity = 0
        } completion: { _ in
            presentedViewController.view.removeFromSuperview()
            presentedViewController.removeFromParent()
            self.performOnDismiss(for: presentedViewController)
        }
    }

    private func performOnDismiss(for viewController: UIViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
}
