import UIKit

class AppDelegateRouter: SCSRouter {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func present_unique(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    func dismissFully(animated: Bool, onDismissed: Closure?) { }
}
