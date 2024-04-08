import Foundation

protocol AddCardsToCollectionCardsVCDelegate: AnyObject {
    var addCardsParentViewController: AddCardsToCollectionCategoriesVC? { get }

    func addCardsToCollectionCardsVCBackTapped(_ viewController: AddCardsToCollectionCardsVC)
    func addCardsToCollectionCardsVCCancelTapped(_ viewController: AddCardsToCollectionCardsVC)
    func addCardsToCollectionCardsVCDoneTapped(_ viewController: AddCardsToCollectionCardsVC)
}

extension AddCardsToCollectionCardsVCDelegate where Self: SCSCoordinator {
    func addCardsToCollectionCardsVCBackTapped(_ viewController: AddCardsToCollectionCardsVC) {
        router.dismiss_unique(viewController, animated: true)
    }

    func addCardsToCollectionCardsVCCancelTapped(_ viewController: AddCardsToCollectionCardsVC) {
        guard let parentViewController = addCardsParentViewController else { return }
        router.dismiss_unique(parentViewController, animated: true)
    }

    func addCardsToCollectionCardsVCDoneTapped(_ viewController: AddCardsToCollectionCardsVC) {
        guard let parentViewController = addCardsParentViewController else { return }
        router.dismiss_unique(parentViewController, animated: true)
    }
}
