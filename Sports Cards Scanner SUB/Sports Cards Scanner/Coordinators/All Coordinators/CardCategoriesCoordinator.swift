import UIKit

final class CardCategoriesCoordinator: SCSCoordinator {
    var children: [SCSCoordinator] = []

    let router: SCSRouter

    init(router: SCSRouter) {
        self.router = router
    }

    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let cardCategoriesViewController = CardCategoriesViewController()
        cardCategoriesViewController.delegate = self
        router.present_unique(cardCategoriesViewController, animated: animated, onDismissed: onDismissed)
    }
}

extension CardCategoriesCoordinator: CardCategoriesViewControllerDelegate {
    func cardCategoriesViewControllerCloseTapped(_ viewController: CardCategoriesViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}
