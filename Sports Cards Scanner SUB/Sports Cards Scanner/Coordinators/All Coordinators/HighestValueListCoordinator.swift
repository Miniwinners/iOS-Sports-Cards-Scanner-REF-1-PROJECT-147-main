import UIKit

final class HighestValueListCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    private let cardsManager: UserCardsManager

    init(router: SCSRouter, cardsManager: UserCardsManager = .shared) {
        self.router = router
        self.cardsManager = cardsManager
    }
}

extension HighestValueListCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = HighestValueCardListViewController()
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension HighestValueListCoordinator: HighestValueListViewControllerDelegate {
    func highestValueListViewControllerCloseTapped(_ viewController: HighestValueCardListViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func highestValueListViewControllerDidSelectCard(_ card: CardRepresentable, in viewController: HighestValueCardListViewController) {
        let coordinator = CardDetailsCoordinator(router: router, card: card, previousVC: .common, sample: nil)
        coordinator.delegate = self
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }
}

extension HighestValueListCoordinator: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardDidRemove(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        if cardsManager.highestValuedCards(count: 1).isEmpty {
            router.dismissFully(animated: true)
        } else {
            router.dismiss_unique(viewController, animated: true)
        }
    }
}
