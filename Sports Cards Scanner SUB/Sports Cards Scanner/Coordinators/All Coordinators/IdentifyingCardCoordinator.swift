import UIKit

final class IdentifyingCardCoordinator {

    var children: [SCSCoordinator] = []
    let router: SCSRouter

    let scannedCard: ScannedCard

    weak var delegate: IdentifyingCardCoordinatorDelegate?

    init(router: SCSRouter, scannedCard: ScannedCard) {
        self.router = router
        self.scannedCard = scannedCard
    }
}

extension IdentifyingCardCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = IdentifyingCardViewController(scannedCard: scannedCard)
        viewController.delegate = self
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        router.present_unique(viewController, animated: true, onDismissed: onDismissed)
    }
}

extension IdentifyingCardCoordinator: IdentifyingCardViewControllerDelegate {
    func identifyingCardViewControllerCancelTapped(_ viewController: IdentifyingCardViewController) {
        var strongSelf: IdentifyingCardCoordinator! = self

        router.dismissFully(animated: true) { [weak delegate] in
            delegate?.identifyingCardCoordinatorDidFinish(coordinator: strongSelf)
            strongSelf = nil
        }
    }

    func identifyingCardViewControllerDidIdentify(withError error: Error, in viewController: IdentifyingCardViewController) {
        var strongSelf: IdentifyingCardCoordinator! = self

        router.dismissFully(animated: true) { [weak delegate] in
            delegate?.identifyingCardCoordinatorDidFinish(withError: error, coordinator: strongSelf)
            strongSelf = nil
        }
    }

    func identifyingCardViewControllerDidIdentify(withCard identifiedCard: CardRepresentable, in viewController: IdentifyingCardViewController) {
        var strongSelf: IdentifyingCardCoordinator! = self

        router.dismissFully(animated: true) { [weak delegate] in
            delegate?.identifyingCardCoordinatorDidFinish(withCard: identifiedCard, coordinator: strongSelf)
            strongSelf = nil
        }
    }
}

// MARK: - Identifying Card Delegate

protocol IdentifyingCardCoordinatorDelegate: AnyObject {
    func identifyingCardCoordinatorDidFinish(coordinator: IdentifyingCardCoordinator)
    func identifyingCardCoordinatorDidFinish(withCard identifiedCard: CardRepresentable, coordinator: IdentifyingCardCoordinator)
    func identifyingCardCoordinatorDidFinish(withError error: Error, coordinator: IdentifyingCardCoordinator)
}
