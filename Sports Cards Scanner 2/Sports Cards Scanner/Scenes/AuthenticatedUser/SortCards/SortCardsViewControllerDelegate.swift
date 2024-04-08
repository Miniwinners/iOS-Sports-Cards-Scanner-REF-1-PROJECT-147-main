import Foundation

protocol SortCardsViewControllerDelegate: AnyObject {
    func sortCardsViewControllerCancelTapped(_ viewController: SortCardsViewController)
    func sortCardsViewControllerDoneTapped(_ viewController: SortCardsViewController)
}

extension SortCardsViewControllerDelegate where Self: SCSCoordinator {
    func sortCardsViewControllerCancelTapped(_ viewController: SortCardsViewController) {
        router.dismiss_unique(viewController, animated: true)
    }

    func sortCardsViewControllerDoneTapped(_ viewController: SortCardsViewController) {
        router.dismiss_unique(viewController, animated: true)
    }
}
