import UIKit

final class CardCollectionCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    var addCardsParentViewController: AddCardsToCollectionCategoriesVC?

    init(router: SCSRouter) {
        self.router = router
    }
}

extension CardCollectionCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = CardCollectionViewController()
        viewController.delegate = self
        router.present_unique(viewController, animated: true)
    }
}

extension CardCollectionCoordinator: CardCollectionViewControllerDelegate {
    func cardCollectionViewControllerAddCardsTapped(_ viewController: CardCollectionViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        let viewController = AddCardsToCollectionCategoriesVC()
        viewController.delegate = self
        self.addCardsParentViewController = viewController
        router.present_unique(viewController, animated: true)
    }
}

extension CardCollectionCoordinator: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardDidRemove(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        router.dismiss_unique(viewController, animated: true)
    }
}

extension CardCollectionCoordinator: DeleteCollectionPromptCoordinatorDelegate {
    func deleteCollectionPromptCoordinatorDeleteTapped(_ coordinator: DeleteCollectionPromptCoordinator) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}

extension CardCollectionCoordinator: AddCardsToCollectionCategoriesVCDelegate { }
extension CardCollectionCoordinator: AddCardsToCollectionCardsVCDelegate { }
extension CardCollectionCoordinator: RemoveCardsFromCollectionVCDelegate { }
extension CardCollectionCoordinator: SortCardsViewControllerDelegate { }
extension CardCollectionCoordinator: CreateEditCollectionVCDelegate { }
