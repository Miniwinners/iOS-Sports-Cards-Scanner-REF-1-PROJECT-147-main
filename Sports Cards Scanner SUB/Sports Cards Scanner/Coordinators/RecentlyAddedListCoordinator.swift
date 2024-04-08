import UIKit

final class RecentlyAddedListCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    private let cardsManager: UserCardsManager

    init(router: SCSRouter, cardsManager: UserCardsManager = .shared) {
        self.router = router
        self.cardsManager = cardsManager
    }
}

extension RecentlyAddedListCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = RecentlyAddedListViewController()
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension RecentlyAddedListCoordinator: RecentlyAddedListViewControllerDelegate {
    func recentlyAddedListViewControllerCloseTapped(_ viewController: RecentlyAddedListViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func recentlyAddedListViewControllerDidSelectCard(_ card: CardRepresentable, in viewController: RecentlyAddedListViewController) {
        let coordinator = CardDetailsCoordinator(router: router, card: card)
        coordinator.delegate = self
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }
}

extension RecentlyAddedListCoordinator: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardDidRemove(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        if cardsManager.recentlyAddedCards(count: 1).isEmpty {
            router.dismissFully(animated: true)
        } else {
            router.dismiss_unique(viewController, animated: true)
        }
    }
}
