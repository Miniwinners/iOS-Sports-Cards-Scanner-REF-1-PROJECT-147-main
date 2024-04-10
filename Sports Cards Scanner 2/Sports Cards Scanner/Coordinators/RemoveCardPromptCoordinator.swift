import UIKit

final class RemoveCardPromptCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    weak var delegate: RemoveCardPromptCoordinatorDelegate?

    private let card: CardRepresentable

    private let cardsManager: UserCardsManager
    private let cardPhotoService: CardPhotoService

    private var isRemoveCardInProcess = false

    init(
        router: SCSRouter,
        card: CardRepresentable,
        cardsManager: UserCardsManager = .shared,
        cardPhotoService: CardPhotoService = .init()
    ) {
        self.router = router
        self.card = card
        self.cardsManager = cardsManager
        self.cardPhotoService = cardPhotoService
    }
}

extension RemoveCardPromptCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = DeleteAccountVC(description: L10n.Prompt.RemoveCard.description)
        viewController.cancelButton.setButtonTitle(L10n.Prompt.RemoveCard.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Prompt.RemoveCard.keepAction)
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension RemoveCardPromptCoordinator: DeleteAccountVCdelegate {
    func promptViewControllerCancelTapped(_ viewController: DeleteAccountVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        guard NetworkMonitoringService.shared.isNetworkAvailable else {
            router.dismissFully(animated: true)
            delegate?.removeCardPromptCoordinatorRemovingDidFail(self)
            return
        }

        viewController.isModalInPresentation = true
        viewController.cancelButton.isLoading = true
        isRemoveCardInProcess = true

        Task { @MainActor in
            defer {
                viewController.isModalInPresentation = false
                viewController.cancelButton.isLoading = false
                isRemoveCardInProcess = false
            }

            cardsManager.removeUserCard(card)
            cardsManager.saveCardsIfNeeded()
            try? await cardPhotoService.removeImage(named: card.id)

            router.dismissFully(animated: true)

            delegate?.removeCardPromptCoordinatorCardDidRemove(self)
        }
    }

    func promptViewControllerConfirmTapped(_ viewController: DeleteAccountVC) {
        if isRemoveCardInProcess { return }
        router.dismissFully(animated: true)
    }
}

// MARK: - Remove Card Delegate

protocol RemoveCardPromptCoordinatorDelegate: AnyObject {
    func removeCardPromptCoordinatorCardDidRemove(_ coordinator: RemoveCardPromptCoordinator)
    func removeCardPromptCoordinatorRemovingDidFail(_ coordinator: RemoveCardPromptCoordinator)
}
