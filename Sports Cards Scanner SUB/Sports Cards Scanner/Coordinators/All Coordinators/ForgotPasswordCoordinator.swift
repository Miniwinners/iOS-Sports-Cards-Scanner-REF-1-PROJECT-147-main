import UIKit

final class ForgotPasswordCoordinator: SCSCoordinator {
    var children: [SCSCoordinator] = []

    let router: SCSRouter

    private let authService: AuthService

    init(router: SCSRouter, authService: AuthService) {
        self.router = router
        self.authService = authService
    }

    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let forgotPasswordViewController = SCSForgotPasswordVC(authService: authService)
        forgotPasswordViewController.delegate = self
        router.present_unique(forgotPasswordViewController, animated: animated, onDismissed: onDismissed)
    }
}

extension ForgotPasswordCoordinator: ForgotPasswordViewControllerDelegate {
    func forgotPasswordViewController(emailSentTo email: String, from viewController: SCSForgotPasswordVC) {
        let resetPasswordViewController = ResetPasswordViewController(email: email)
        resetPasswordViewController.delegate = self
        router.present_unique(resetPasswordViewController, animated: true)
    }

    func forgotPasswordViewControllerCloseTapped(_ viewController: SCSForgotPasswordVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}

extension ForgotPasswordCoordinator: ResetPasswordViewControllerDelegate {
    func resetPasswordViewControllerCloseTapped(_ viewController: ResetPasswordViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}
