import UIKit

final class SwipeNavigationController: UINavigationController {

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

}

// MARK: - GestureRecognizer Delegate

extension SwipeNavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true
        }

        return viewControllers.count > 1 && ((viewControllers.last as? SwipableController)?.isSwipeBackEnabled ?? true)
    }
}
