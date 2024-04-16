import UIKit

final class ScanCardCoordinator {

    var children: [SCSCoordinator] = []

    let router: SCSRouter

    private var scanCardViewController: ScanCardViewController!
    private var scannedCard: ScannedCard!

    init(router: SCSRouter) {
        self.router = router
    }
}

extension ScanCardCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = ScanCardViewController()
        viewController.delegate = self
        viewController.modalPresentationStyle = .fullScreen
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)

        self.scanCardViewController = viewController
    }
}

extension ScanCardCoordinator: ScanCardViewControllerDelegate {
    func scanCardViewControllerCloseTapped(_ viewController: ScanCardViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func scanCardViewControllerOpenSettings(_ viewController: ScanCardViewController) {
        guard let settingsURL = AppInfo.settingsURL,
              UIApplication.shared.canOpenURL(settingsURL)
        else {
            return
        }

        UIApplication.shared.open(settingsURL)
    }

    func scanCardViewControllerDidCapture(card: ScannedCard, _ viewController: ScanCardViewController) {
        self.scannedCard = card

        let router = ModalPresentationRouter(parentViewController: viewController, presentStyle: .common)
        let coordinator = IdentifyingCardCoordinator(router: router, scannedCard: card)
        coordinator.delegate = self
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }
}

extension ScanCardCoordinator: IdentifyingCardCoordinatorDelegate {
    func identifyingCardCoordinatorDidFinish(coordinator: IdentifyingCardCoordinator) {
        scanCardViewController.restartScanning()
    }

    func identifyingCardCoordinatorDidFinish(withCard identifiedCard: CardRepresentable, coordinator: IdentifyingCardCoordinator) {
        let router = ModalPresentationRouter(parentViewController: scanCardViewController, presentStyle: .common)
        let coordinator = CardDetailsCoordinator(
            router: router,
            card: identifiedCard,
            cardType: .identifiedCard,
            encodedCardImage: coordinator.scannedCard.encodedCardImage
        )
        presentChildCoordinator(coordinator, animated: true) { [weak self] in
            self?.scanCardViewController.restartScanning()
        }
    }

    func identifyingCardCoordinatorDidFinish(withError error: Error, coordinator: IdentifyingCardCoordinator) {
        let router = SCSModalNavigationRouter(parentViewController: scanCardViewController)
        let coordinator = SearchCardCoordinator(router: router, card: scannedCard)
        presentChildCoordinator(coordinator, animated: true) { [weak self] in
            self?.scanCardViewController.restartScanning()
        }
    }
}
