import Foundation

protocol AddCardsToDeckVCDelegate: AnyObject {
    func addCardsToDeckVCCancelTapped(_ viewController: AddCardsToDeckVC)
    func addCardsToDeckVCDoneTapped(_ viewController: AddCardsToDeckVC)
}

extension AddCardsToDeckVCDelegate where Self: SCSCoordinator {
    func addCardsToDeckVCCancelTapped(_ viewController: AddCardsToDeckVC) {
        router.dismiss_unique(viewController, animated: true)
    }

    func addCardsToDeckVCDoneTapped(_ viewController: AddCardsToDeckVC) {
        router.dismiss_unique(viewController, animated: true)
    }
}
