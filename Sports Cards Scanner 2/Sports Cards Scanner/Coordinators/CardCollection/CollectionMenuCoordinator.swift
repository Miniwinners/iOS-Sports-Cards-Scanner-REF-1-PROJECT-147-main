import UIKit

final class CollectionMenuCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter
    let menuItems: [CollectionMenuItem]

    var didSelectItem: ((CollectionMenuItem) -> Void)?

    init(router: SCSRouter, menuItems: [CollectionMenuItem]) {
        self.router = router
        self.menuItems = menuItems
    }
}

extension CollectionMenuCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = CollectionMenuViewController(menuItems: menuItems)
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension CollectionMenuCoordinator: CollectionMenuViewControllerDelegate {
    func collectionMenuViewControllerCancelTapped(_ viewController: CollectionMenuViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func collectionMenuViewControllerDidSelectItem(_ item: CollectionMenuItem, in viewController: CollectionMenuViewController) {
        router.dismissFully(animated: true) { [didSelectItem] in
            didSelectItem?(item)
        }
    }
}
