import UIKit

final class ModalPresentationRouter {
    unowned let parentViewController: UIViewController

    private var onDismissForViewController: [UIViewController: Closure] = [:]

    var presentStyle: PresentationStyle?

    init(parentViewController: UIViewController, presentStyle: PresentationStyle?) {
        self.parentViewController = parentViewController
        self.presentStyle = presentStyle
    }
}

extension ModalPresentationRouter: SCSRouter {
    func present_unique(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        onDismissForViewController[viewController] = onDismissed

        if let presentedViewController = parentViewController.presentedViewController {
            performOnDismiss(for: presentedViewController)
            switch presentStyle {
            case .back:
                print("back")
            case .backDone:
                print("back done")
            case .close:
                viewController.closeButton()
            case .common:
                print("common")
            default:
                print("default")
            }
            presentedViewController.dismiss(animated: animated) { [weak self] in
                self?.parentViewController.present(viewController, animated: animated)
            }
        } else {
            switch presentStyle {
            case .back:
                print("back")
            case .backDone:
                print("back done")
            case .close:
                viewController.closeButton()
            case .common:
                print("common")
            default:
                print("default")
            }
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
