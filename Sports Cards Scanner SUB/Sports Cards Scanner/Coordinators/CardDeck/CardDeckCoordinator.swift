import UIKit

final class CardDeckCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    init(router: SCSRouter) {
        self.router = router
    }
}

extension CardDeckCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = CardDeckViewController()
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension CardDeckCoordinator: DeleteDeckPromptCoordinatorDelegate {
    func deleteDeckPromptCoordinatorDeleteTapped(_ coordinator: DeleteDeckPromptCoordinator) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}

extension CardDeckCoordinator: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardDidRemove(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        router.dismiss_unique(viewController, animated: true)
    }
}

extension CardDeckCoordinator: CreateEditDeckVCDelegate { }
extension CardDeckCoordinator: CardDeckViewControllerDelegate { }
extension CardDeckCoordinator: AddCardsToDeckVCDelegate { }
extension CardDeckCoordinator: RemoveCardsFromDeckVCDelegate { }
extension CardDeckCoordinator: SortCardsViewControllerDelegate { }
