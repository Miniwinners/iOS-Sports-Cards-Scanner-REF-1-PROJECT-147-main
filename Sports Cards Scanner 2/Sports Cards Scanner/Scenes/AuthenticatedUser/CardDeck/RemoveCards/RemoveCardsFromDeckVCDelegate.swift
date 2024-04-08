import Foundation

protocol RemoveCardsFromDeckVCDelegate: AnyObject {
    func removeCardsFromDeckVCDoneTapped(_ viewController: RemoveCardsFromDeckVC)
}

extension RemoveCardsFromDeckVCDelegate where Self: SCSCoordinator {
    func removeCardsFromDeckVCDoneTapped(_ viewController: RemoveCardsFromDeckVC) {
        router.dismiss_unique(viewController, animated: true)
    }
}
