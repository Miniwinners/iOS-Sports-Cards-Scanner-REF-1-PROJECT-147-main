import UIKit

final class GraderSelectionCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    var didSelectGrader: ((CardGrader) -> Void)?

    let card: CardRepresentable

    init(router: SCSRouter, card: CardRepresentable) {
        self.router = router
        self.card = card
    }
}

extension GraderSelectionCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        var graders = card.graders
        if !graders.contains(card.selectedGrader) {
            graders.append(card.selectedGrader)
        }

        let viewController = GraderSelectionViewController(graders: graders)
        viewController.delegate = self
        router.present_unique(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension GraderSelectionCoordinator: GraderSelectionViewControllerDelegate {
    func graderSelectionViewControllerCancelTapped(_ viewController: GraderSelectionViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func graderSelectionViewControllerDidSelect(grader: CardGrader, in viewController: GraderSelectionViewController) {
        router.dismissFully(animated: true)

        didSelectGrader?(grader)
    }
}
