import UIKit

final class UpdatePasswordCoordinator: SCSCoordinator {
    var children: [SCSCoordinator] = []

    let router: SCSRouter

    private let authService: AuthService

    init(router: SCSRouter, authService: AuthService) {
        self.router = router
        self.authService = authService
    }

    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let updatePasswordViewController = SCSUpdatePasswordVC(authService: authService)
        updatePasswordViewController.delegate = self
        router.present_unique(updatePasswordViewController, animated: animated, onDismissed: onDismissed)
    }
}

extension UpdatePasswordCoordinator: UpdatePasswordViewControllerDelegate {
    func updatePasswordViewControllerCloseTapped(_ viewController: SCSUpdatePasswordVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func updatePasswordViewControllerPasswordDidUpdate(_ viewController: SCSUpdatePasswordVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }
}
