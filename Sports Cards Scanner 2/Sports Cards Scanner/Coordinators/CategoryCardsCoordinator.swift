import UIKit

final class CategoryCardsCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    private let category: CardCategory
    private let cardsManager: UserCardsManager

    init(
        router: SCSRouter,
        category: CardCategory,
        cardsManager: UserCardsManager = .shared
    ) {
        self.router = router
        self.category = category
        self.cardsManager = cardsManager
    }
}

extension CategoryCardsCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = CategoryCardsViewController(category: category)
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension CategoryCardsCoordinator: CategoryCardsViewControllerDelegate {
    func categoryCardsViewControllerCloseTapped(_ viewController: CategoryCardsViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func categoryCardsViewControllerDidSelectCard(_ card: CardRepresentable, in viewController: CategoryCardsViewController) {
        let coordinator = CardDetailsCoordinator(router: router, card: card)
        coordinator.delegate = self
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }
}

extension CategoryCardsCoordinator: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardDidRemove(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        if cardsManager.cards(of: category).isEmpty {
            router.dismissFully(animated: true)
        } else {
            router.dismiss_unique(viewController, animated: true)
        }
    }
}
