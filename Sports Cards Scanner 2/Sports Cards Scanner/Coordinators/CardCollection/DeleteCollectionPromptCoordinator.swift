import UIKit

final class DeleteCollectionPromptCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    private let cardCollectionManager: CardCollectionManager

    weak var delegate: DeleteCollectionPromptCoordinatorDelegate?

    init(
        router: SCSRouter,
        cardCollectionManager: CardCollectionManager = CardSetsManager.shared
    ) {
        self.router = router
        self.cardCollectionManager = cardCollectionManager
    }
}

extension DeleteCollectionPromptCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = DeleteAccountVC(description: L10n.Prompt.DeleteCollection.description, styleButton: .delete)
        viewController.delegate = self
        viewController.cancelButton.setButtonTitle(L10n.Prompt.DeleteCollection.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Prompt.DeleteCollection.keepAction)
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension DeleteCollectionPromptCoordinator: DeleteAccountVCdelegate {
    func promptViewControllerCancelTapped(_ viewController: DeleteAccountVC) {
        cardCollectionManager.removeCardCollection()
        cardCollectionManager.saveCollectionIfNeeded()
        delegate?.deleteCollectionPromptCoordinatorDeleteTapped(self)
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

// MARK: - DeleteCollection Delegate

protocol DeleteCollectionPromptCoordinatorDelegate: AnyObject {
    func deleteCollectionPromptCoordinatorDeleteTapped(_ coordinator: DeleteCollectionPromptCoordinator)
}
