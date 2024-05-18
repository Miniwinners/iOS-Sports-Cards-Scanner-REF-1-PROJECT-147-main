import UIKit
func vicheslitFibonc295(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiMNavR: NSObject {
    unowned let parentViewController: UIViewController

    private lazy var navigationController: UINavigationController = { controller in
        controller.navigationBar.primenitVid()
        return controller
    }(SportivinieKartiSNaControllerontroller())

    private var onDismissForViewController: [UIViewController: Closure] = [:]
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        super.init()

//        navigationController.delegate = self
//        navigationController.presentationController?.delegate = self
    }
}

extension SportivinieKartiMNavR: SportivinieKartiGlavniiRouterPrilozhania {
    func poyavitsaUnicalno(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        onDismissForViewController[viewController] = onDismissed

        if navigationController.viewControllers.isEmpty {
            pokazatControllerModalno(viewController, animated: animated)
        } else {
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    private func pokazatControllerModalno(_ viewController: UIViewController, animated: Bool) {
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.modalPresentationStyle = .custom
        navigationController.presentationController?.delegate = self
        navigationController.transitioningDelegate = self
        navigationController.delegate = self
        parentViewController.present(navigationController, animated: animated)
    }

    func ischeznytUnicalno(_ viewController: UIViewController, animated: Bool) {
        guard let controllerIndex = navigationController.viewControllers.firstIndex(where: { $0 === viewController }),
              let previousController = navigationController.viewControllers[safe: controllerIndex - 1]
        else { return }

        navigationController.popToViewController(previousController, animated: true)
        // Tip: performOnDismiss(for:) will called from navigationController(_:didShow:animated:)
    }

    func ischeznytPolnostuu(animated: Bool, onDismissed: Closure?) {
        let rootViewController = navigationController.viewControllers.first
        parentViewController.dismiss(animated: true) {
            guard let viewController = rootViewController else { return }
            self.performOnDismiss(for: viewController)
            onDismissed?()
        }
    }

    private func performOnDismiss(for viewController: UIViewController) {

        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
}

extension SportivinieKartiMNavR: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedViewController) else {
            return
        }
        performOnDismiss(for: dismissedViewController)
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromController: UIViewController, to toController: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomNavigationAnimator()
    }

}

extension SportivinieKartiMNavR: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        guard let rootViewController = navigationController.viewControllers.first else {
            return
        }
        performOnDismiss(for: rootViewController)
    }
}

extension SportivinieKartiMNavR: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomNavPresentation(presentedViewController: presented, presenting: presenting)

    }
}
