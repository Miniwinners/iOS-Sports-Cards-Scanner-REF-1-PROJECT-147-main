import UIKit

final class DeleteAccountPromptCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    private let authService: AuthService
    private let profileManager: ProfileManager
    private let cardPhotoService: CardPhotoService

    private var isDeleteAccountInProcess = false

    var onDeletingFailed: ((Error) -> Void)?

    init(
        router: SCSRouter,
        authService: AuthService,
        profileManager: ProfileManager = .shared,
        cardPhotoService: CardPhotoService = .init()
    ) {
        self.router = router
        self.authService = authService
        self.profileManager = profileManager
        self.cardPhotoService = cardPhotoService
    }
}

extension DeleteAccountPromptCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = PromptViewController(description: L10n.Prompt.DeleteAccount.description)
        viewController.cancelButton.setButtonTitle(L10n.Prompt.DeleteAccount.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Prompt.DeleteAccount.keepAction)
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension DeleteAccountPromptCoordinator: PromptViewControllerDelegate {
    func promptViewControllerCancelTapped(_ viewController: PromptViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        viewController.isModalInPresentation = true
        viewController.cancelButton.isLoading = true
        isDeleteAccountInProcess = true

        Task { @MainActor in
            defer {
                viewController.isModalInPresentation = false
                viewController.cancelButton.isLoading = false
                isDeleteAccountInProcess = false
            }

            do {
                try await authService.deleteUserAccount()
                try await cardPhotoService.deleteAllPhotos()
                try await profileManager.deleteProfileData()
            } catch {
                var strongSelf: DeleteAccountPromptCoordinator! = self
                router.dismissFully(animated: true) {
                    strongSelf.onDeletingFailed?(error)
                    strongSelf = nil
                }
            }
        }
    }

    func promptViewControllerConfirmTapped(_ viewController: PromptViewController) {
        if isDeleteAccountInProcess { return }
        router.dismissFully(animated: true)
    }
}
