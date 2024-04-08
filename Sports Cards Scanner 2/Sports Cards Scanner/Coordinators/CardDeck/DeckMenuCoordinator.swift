import UIKit

final class DeckMenuCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter
    let menuItems: [DeckMenuItem]

    var didSelectItem: ((DeckMenuItem) -> Void)?

    init(router: SCSRouter, menuItems: [DeckMenuItem]) {
        self.router = router
        self.menuItems = menuItems
    }
}

extension DeckMenuCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = DeckMenuViewController(menuItems: menuItems)
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension DeckMenuCoordinator: DeckMenuViewControllerDelegate {
    func deckMenuViewControllerCancelTapped(_ viewController: DeckMenuViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func deckMenuViewControllerDidSelectItem(_ item: DeckMenuItem, in viewController: DeckMenuViewController) {
        router.dismissFully(animated: true) { [didSelectItem] in
            didSelectItem?(item)
        }
    }
}
