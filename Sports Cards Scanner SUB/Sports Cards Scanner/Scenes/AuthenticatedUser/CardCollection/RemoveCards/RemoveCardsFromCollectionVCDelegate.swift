import Foundation

protocol RemoveCardsFromCollectionVCDelegate: AnyObject {
    func removeCardsFromCollectionVCDoneTapped(_ viewController: RemoveCardsFromCollectionVC)
}

extension RemoveCardsFromCollectionVCDelegate where Self: SCSCoordinator {
    func removeCardsFromCollectionVCDoneTapped(_ viewController: RemoveCardsFromCollectionVC) {
        router.dismiss_unique(viewController, animated: true)
    }
}
