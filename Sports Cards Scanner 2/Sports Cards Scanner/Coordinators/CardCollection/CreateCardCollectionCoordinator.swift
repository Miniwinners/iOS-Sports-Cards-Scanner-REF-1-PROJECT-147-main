import UIKit

final class CreateCardCollectionCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    var addCardsParentViewController: AddCardsToCollectionCategoriesVC?

    init(router: SCSRouter) {
        self.router = router
    }
}

extension CreateCardCollectionCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = CreateEditCollectionVC()
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension CreateCardCollectionCoordinator: CardCollectionViewControllerDelegate {
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

extension CreateCardCollectionCoordinator: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardDidRemove(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        router.dismiss_unique(viewController, animated: true)
    }
}

extension CreateCardCollectionCoordinator: DeleteCollectionPromptCoordinatorDelegate {
    func deleteCollectionPromptCoordinatorDeleteTapped(_ coordinator: DeleteCollectionPromptCoordinator) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}

extension CreateCardCollectionCoordinator: AddCardsToCollectionCategoriesVCDelegate { }
extension CreateCardCollectionCoordinator: AddCardsToCollectionCardsVCDelegate { }
extension CreateCardCollectionCoordinator: RemoveCardsFromCollectionVCDelegate { }
extension CreateCardCollectionCoordinator: SortCardsViewControllerDelegate { }
extension CreateCardCollectionCoordinator: CreateEditCollectionVCDelegate { }
