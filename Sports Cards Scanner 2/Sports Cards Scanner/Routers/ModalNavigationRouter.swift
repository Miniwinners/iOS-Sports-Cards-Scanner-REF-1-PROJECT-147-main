import UIKit
import SnapKit

final class SCSModalNavigationRouter: NSObject {
    unowned let parentViewController: UIViewController

    private lazy var navigationController: UINavigationController = { controller in
        controller.navigationBar.applyDefaultAppearance()
        return controller
    }(SwipeNavigationController())

    private var onDismissForViewController: [UIViewController: Closure] = [:]

    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        super.init()

        navigationController.delegate = self
        navigationController.presentationController?.delegate = self
    }
}

extension SCSModalNavigationRouter: SCSRouter {

    func present_unique(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        onDismissForViewController[viewController] = onDismissed

        if navigationController.viewControllers.isEmpty {
            presentVCModally(viewController, animated: animated)
        } else {
            viewController.setBackButtonImage()
            navigationController.pushViewController(viewController, animated: animated)
        }
    }

    private func presentVCModally(_ viewController: UIViewController, animated: Bool) {
        navigationController.setViewControllers([viewController], animated: false)
        parentViewController.present(navigationController, animated: animated)
    }

    func dismiss_unique(_ viewController: UIViewController, animated: Bool) {
        guard let vcIndex = navigationController.viewControllers.firstIndex(where: { $0 === viewController }),
              let previousVC = navigationController.viewControllers[safe: vcIndex - 1]
        else { return }

        navigationController.popToViewController(previousVC, animated: true)
        // Tip: performOnDismiss(for:) will called from navigationController(_:didShow:animated:)
    }

    func dismissFully(animated: Bool, onDismissed: Closure?) {
        let rootViewController = navigationController.viewControllers.first
        parentViewController.dismiss(animated: animated) {
            guard let viewController = rootViewController else { return }
            self.performOnDismiss(for: viewController)
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

extension SCSModalNavigationRouter: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedViewController) else {
            return
        }
        performOnDismiss(for: dismissedViewController)
    }
}

extension SCSModalNavigationRouter: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        guard let rootViewController = navigationController.viewControllers.first else {
            return
        }
        performOnDismiss(for: rootViewController)
    }
}

protocol CloseButton {
    func closeButton ()
}

protocol BackButton {
    func backButton()
}

protocol BackDoneButton {
    func backDoneButton ()
}
extension UIViewController: CloseButton {
    func closeButton() {
        let closeButton = UIButton()
        closeButton.setImage(Images.close.image, for: .normal)
        closeButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 22
        closeButton.layer.masksToBounds = false
        closeButton.layer.shadowColor = UIColor.black.cgColor
        closeButton.layer.shadowOpacity = 0.1
        closeButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        closeButton.layer.shadowRadius = 15
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(44)

        }
    }

    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

}

extension UIViewController: BackButton {
    func backButton() {

    }

}

extension UIViewController: BackDoneButton {
    func backDoneButton() {

    }

}
