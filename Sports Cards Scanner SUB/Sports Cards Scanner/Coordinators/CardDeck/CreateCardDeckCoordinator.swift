import UIKit

final class CreateCardDeckCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    init(router: SCSRouter) {
        self.router = router
    }
}

extension CreateCardDeckCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = CreateEditDeckVC()
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension CreateCardDeckCoordinator: DeleteDeckPromptCoordinatorDelegate {
    func deleteDeckPromptCoordinatorDeleteTapped(_ coordinator: DeleteDeckPromptCoordinator) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}

extension CreateCardDeckCoordinator: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardDidRemove(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        router.dismiss_unique(viewController, animated: true)
    }
}

extension CreateCardDeckCoordinator: CreateEditDeckVCDelegate { }
extension CreateCardDeckCoordinator: CardDeckViewControllerDelegate { }
extension CreateCardDeckCoordinator: AddCardsToDeckVCDelegate { }
extension CreateCardDeckCoordinator: RemoveCardsFromDeckVCDelegate { }
extension CreateCardDeckCoordinator: SortCardsViewControllerDelegate { }
