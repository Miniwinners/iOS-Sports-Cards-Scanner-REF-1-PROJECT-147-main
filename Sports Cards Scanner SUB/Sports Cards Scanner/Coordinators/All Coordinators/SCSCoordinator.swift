import UIKit

protocol SCSCoordinator: AnyObject {
    var children: [SCSCoordinator] { get set }
    var router: SCSRouter { get }

    func presentInitialState(animated: Bool, onDismissed: Closure?)
    func dismissFully(animated: Bool)
    func presentChildCoordinator(_ coordinator: SCSCoordinator, animated: Bool, onDismissed: Closure?)
}

extension SCSCoordinator {
    func dismissFully(animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: animated)
    }

    func presentChildCoordinator(_ child: SCSCoordinator, animated: Bool, onDismissed: Closure?) {
        children.append(child)
        child.presentInitialState(animated: animated) { [weak self, weak child] in
            guard let self = self, let child = child else { return }
            self.removeChildCoordinator(child)
            onDismissed?()
        }
    }

    private func removeChildCoordinator(_ child: SCSCoordinator) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        guard let index = children.firstIndex(where: { $0 === child }) else {
            return
        }
        children.remove(at: index)
    }
}
