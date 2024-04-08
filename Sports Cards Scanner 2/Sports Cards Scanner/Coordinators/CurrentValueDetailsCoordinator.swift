import UIKit

final class CurrentValueDetailsCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    init(router: SCSRouter) {
        self.router = router
    }
}

extension CurrentValueDetailsCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = CurrentValueDetailsViewController()
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension CurrentValueDetailsCoordinator: CurrentValueDetailsViewControllerDelegate {
    func currentValueDetailsViewControllerCloseTapped(_ viewController: CurrentValueDetailsViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}
