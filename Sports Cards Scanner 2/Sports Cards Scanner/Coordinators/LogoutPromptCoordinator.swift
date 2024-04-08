import UIKit

final class LogoutPromptCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    private let authService: AuthService

    init(router: SCSRouter, authService: AuthService) {
        self.router = router
        self.authService = authService
    }
}

extension LogoutPromptCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = PromptViewController(description: L10n.Prompt.Logout.description)
        viewController.cancelButton.setButtonTitle(L10n.Prompt.Logout.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Common.cancel)
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension LogoutPromptCoordinator: PromptViewControllerDelegate {
    func promptViewControllerCancelTapped(_ viewController: PromptViewController) {
        try? authService.performSignOut()
    }

    func promptViewControllerConfirmTapped(_ viewController: PromptViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}
