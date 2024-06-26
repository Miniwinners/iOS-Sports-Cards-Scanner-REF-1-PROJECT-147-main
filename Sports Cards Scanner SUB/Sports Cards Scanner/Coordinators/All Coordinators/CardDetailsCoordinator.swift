import UIKit

final class CardDetailsCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter
    let card: CardRepresentable
    let cardType: CardType
    let encodedCardImage: Data?
    private var previousVC: PreviousVC
    weak var delegate: CardDetailsCoordinatorDelegate?
    private var locked: Bool = true
    private weak var cardDetailsViewController: CardDetailsViewController?
    private var scanCardViewController: ScanCardViewController?

    init(
        router: SCSRouter,
        card: CardRepresentable,
        cardType: CardType = .addedCard,
        encodedCardImage: Data? = nil,
        previousVC: PreviousVC,
        sample: ScanCardViewController? = nil

    ) {
        self.router = router
        self.card = card
        self.cardType = cardType
        self.encodedCardImage = encodedCardImage
        self.previousVC = previousVC
        self.scanCardViewController = sample
    }
}

extension CardDetailsCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = CardDetailsViewController(card: card, cardType: cardType, encodedCardImage: encodedCardImage, previousVC: previousVC, locked: locked)
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension CardDetailsCoordinator: SearchCardCoordinatorDelegate {
    func searchCardCoordinatorCardDidAdd(_ coordinator: SearchCardCoordinator) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}

extension CardDetailsCoordinator: CardDetailsViewControllerDelegate {
    func editCardDelegateSubscribe(_ viewController: CardDetailsViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        presentUnsubscribed()
    }

    func cardDetailsViewControllerCloseTapped(_ viewController: CardDetailsViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func cardDetaisCloseAfterSearch(_ viewController: CardDetailsViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
        scanCardViewController?.restartScanning()
    }

    func cardDetailsViewControllerBackTapped(_ viewController: CardDetailsViewController) {
        router.dismiss_unique(viewController, animated: true)
    }

    func cardDetailsViewControllerSelectGraderTapped(_ viewController: CardDetailsViewController) {
        let inset: CGFloat = UIDevice.isIpad ? 160:40

        let router = DeleteAccountSheetRouter(parentViewController: viewController, presentStyle: .centerRect,
                                              heightRatio: UIDevice.isIpad ? 360:250,
                                              widthRatio: viewController.view.frame.width - inset)
        let coordinator = GraderSelectionCoordinator(router: router, card: viewController.card)
        coordinator.didSelectGrader = { [unowned viewController] grader in
            viewController.graderDidSelect(grader)
        }
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func cardDetailsViewControllerPricingReportTapped(_ viewController: CardDetailsViewController) {
        let viewController = PricingReportViewController(
            card: viewController.card,
            grader: viewController.selectedGrader,
            encodedCardImage: viewController.encodedCardImage
        )
        router.present_unique(viewController, animated: true)

    }

    func cardDetailsViewControllerEditCardTapped(_ viewController: CardDetailsViewController) {
            let cardsUpdater: CardsUpdater
            if viewController.card is SearchedCard {
                cardsUpdater = viewController.searchedCardsManager
            } else {
                cardsUpdater = UserCardsManager.shared
            }

            let viewController = EditCardViewController(card: viewController.card, cardsManager: cardsUpdater)
            viewController.delegate = self
            router.present_unique(viewController, animated: true)

    }

    func cardDetailsViewControllerFindCardTapped(_ viewController: CardDetailsViewController) {
        let encodedCardImage = viewController.encodedCardImage ?? Data()
        let cardCategory = viewController.card.category
        let scannedCard = ScannedCard(encodedCardImage: encodedCardImage, cardCategory: cardCategory)

        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = SearchCardCoordinator(router: router, card: scannedCard, sample: nil)
        coordinator.delegate = self
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func cardDetailsViewControllerCardDidAdd(_ viewController: CardDetailsViewController) {
        if let delegate = delegate {
            delegate.cardDetailsCoordinatorCardDidAdd(self, from: viewController)
        } else {
            router.dismissFully(animated: true)
        }
    }

    func cardDetailsViewControllerRemoveCardTapped(_ card: CardRepresentable, in viewController: CardDetailsViewController) {
        cardDetailsViewController = viewController
        let inset: CGFloat = UIDevice.isIpad ? 140:40
        let router = DeleteAccountSheetRouter(parentViewController: viewController, presentStyle: .center, heightRatio: UIDevice.isIpad ? 260: 330, widthRatio: viewController.view.frame.width - inset)
        let coordinator = RemoveCardPromptCoordinator(router: router, card: card)
        coordinator.delegate = self
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }
}

extension CardDetailsCoordinator: EditCardViewControllerDelegate {
    func editCardViewControllerParallelTapped(_ viewController: EditCardViewController) {
        let parallels = viewController.card.parallels
        let selectedParallelIndex = viewController.selectedParallelIndex

        let parallelSelectionViewController = ParallelSelectionViewController(parallels: parallels, selected: selectedParallelIndex)
        parallelSelectionViewController.parallelDidSelect = { [unowned parallelSelectionViewController, unowned router] index in
            viewController.updateSelectedParallelIndex(index)
            router.dismiss_unique(parallelSelectionViewController, animated: true)
        }
        router.present_unique(parallelSelectionViewController, animated: true)
    }

    func editCardViewControllerGradeTapped(_ viewController: EditCardViewController) {
        let selectedGrader = viewController.selectedGrader
        let selectedGrade = viewController.selectedGrade

        let gradeSelectionViewController = GradeSelectionViewController(grader: selectedGrader, grade: selectedGrade)
        gradeSelectionViewController.gradeDidSelect = { [unowned gradeSelectionViewController, unowned router] grader, grade in
            viewController.updateSelectedGrade(grader: grader, grade: grade)
            router.dismiss_unique(gradeSelectionViewController, animated: true)
        }
        router.present_unique(gradeSelectionViewController, animated: true)
    }

    func editCardViewControllerDetailsDidUpdate(_ viewController: EditCardViewController) {
        router.dismiss_unique(viewController, animated: true)
    }
}

extension CardDetailsCoordinator: RemoveCardPromptCoordinatorDelegate {
    func removeCardPromptCoordinatorCardDidRemove(_ coordinator: RemoveCardPromptCoordinator) {
        if let delegate = delegate {
            guard let viewController = cardDetailsViewController else { return }
            delegate.cardDetailsCoordinatorCardDidRemove(self, from: viewController)
        } else {
            router.dismissFully(animated: true)
        }
    }

    func removeCardPromptCoordinatorRemovingDidFail(_ coordinator: RemoveCardPromptCoordinator) {
        guard let viewController = cardDetailsViewController else { return }
        let alertType: SCSAlertType = .noInternetConnection(okAction: nil)
        AlertService.shared.presentAC(type: alertType, in: viewController)
    }

    func presentUnsubscribed() {
        let premiumVC = PremiumMainController(productBuy: .unlockContentProduct)
        premiumVC.delegate = self
        router.present_unique(premiumVC, animated: true)
    }
}

extension CardDetailsCoordinator: PremiumMainControllerDelegate {

    func premiumMainControllerUserDidSubscribe(_ viewController: PremiumMainController) {
        router.dismiss_unique(viewController, animated: true)
    }
}

// MARK: - CardDetails Coordinator Delegate

protocol CardDetailsCoordinatorDelegate: AnyObject {
    func cardDetailsCoordinatorCardDidAdd(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController)
    func cardDetailsCoordinatorCardDidRemove(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController)
}

extension CardDetailsCoordinatorDelegate where Self: SCSCoordinator {
    func cardDetailsCoordinatorCardDidAdd(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        router.dismissFully(animated: true)
    }

    func cardDetailsCoordinatorCardDidRemove(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        router.dismissFully(animated: true)
    }
}
