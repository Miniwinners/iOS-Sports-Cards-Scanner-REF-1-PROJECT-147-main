import UIKit

final class DeleteDeckPromptCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    private let cardDeckManager: CardDeckManager

    weak var delegate: DeleteDeckPromptCoordinatorDelegate?

    init(
        router: SCSRouter,
        cardDeckManager: CardDeckManager = CardSetsManager.shared
    ) {
        self.router = router
        self.cardDeckManager = cardDeckManager
    }
}

extension DeleteDeckPromptCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = DeleteAccountVC(description: L10n.Prompt.DeleteDeck.description)
        viewController.delegate = self
        viewController.cancelButton.setButtonTitle(L10n.Prompt.DeleteDeck.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Prompt.DeleteDeck.keepAction)
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension DeleteDeckPromptCoordinator: DeleteAccountVCdelegate {
    func promptViewControllerCancelTapped(_ viewController: DeleteAccountVC) {
        cardDeckManager.removeCardDeck()
        cardDeckManager.saveDeckIfNeeded()
        delegate?.deleteDeckPromptCoordinatorDeleteTapped(self)
    }

    func promptViewControllerConfirmTapped(_ viewController: DeleteAccountVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}

// MARK: - DeleteDeck Delegate

protocol DeleteDeckPromptCoordinatorDelegate: AnyObject {
    func deleteDeckPromptCoordinatorDeleteTapped(_ coordinator: DeleteDeckPromptCoordinator)
}
