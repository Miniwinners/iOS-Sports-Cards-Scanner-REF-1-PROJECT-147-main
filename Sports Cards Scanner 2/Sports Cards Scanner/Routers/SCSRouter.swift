import UIKit

protocol SCSRouter: AnyObject {
    func present_unique(_ viewController: UIViewController, animated: Bool)
    func present_unique(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?)
//    func present_unique(_ viewController: UIViewController, buttonType: presentationStyle, animated: Bool, onDismissed: Closure?)

    func dismiss_unique(_ viewController: UIViewController, animated: Bool)
    func dismissVC_unique(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?)

    func dismissFully(animated: Bool)
    func dismissFully(animated: Bool, onDismissed: Closure?)
}

extension SCSRouter {
    func present_unique(_ viewController: UIViewController, animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        present_unique(viewController, animated: animated, onDismissed: nil)
    }

    func dismiss_unique(_ viewController: UIViewController, animated: Bool) {
        dismissFully(animated: animated)
    }

    func dismissVC_unique(_ viewController: UIViewController, animated: Bool, onDismissed: Closure?) {
        dismissFully(animated: animated)
    }

    func dismissFully(animated: Bool) {
        dismissFully(animated: animated, onDismissed: nil)
    }
}
