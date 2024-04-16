import UIKit

final class SearchCardCoordinator {
    var children: [SCSCoordinator] = []
    let router: SCSRouter

    weak var delegate: SearchCardCoordinatorDelegate?

    private let scannedCard: ScannedCard

    init(router: SCSRouter, card: ScannedCard) {
        self.router = router
        self.scannedCard = card
    }
}

extension SearchCardCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        let viewController = SearchCardViewController(searchCategory: scannedCard.cardCategory)
        viewController.delegate = self
        router.present_unique(viewController, animated: true, onDismissed: onDismissed)
    }
}

extension SearchCardCoordinator: SearchCardViewControllerDelegate {
    func searchCardViewControllerCloseTapped(_ viewController: SearchCardViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func searchCardViewControllerDidSelect(card: CardRepresentable, in viewController: SearchCardViewController) {

        let router = ModalPresentationRouter(parentViewController: viewController, presentStyle: .close)
        let coordinator = CardDetailsCoordinator(router: router, card: card, cardType: .searchedCard, encodedCardImage: self.scannedCard.encodedCardImage)
            coordinator.delegate = self
        self.presentChildCoordinator(coordinator, animated: true) {
            self.router.dismissFully(animated: true)
        }

    }
}

extension SearchCardCoordinator: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardDidAdd(_ coordinator: CardDetailsCoordinator, from viewController: CardDetailsViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        if let delegate {
            delegate.searchCardCoordinatorCardDidAdd(self)
        } else {
            router.dismissFully(animated: true)
        }
    }
}

// MARK: - Search Card Delegate

protocol SearchCardCoordinatorDelegate: AnyObject {
    func searchCardCoordinatorCardDidAdd(_ coordinator: SearchCardCoordinator)
}
