import Foundation

protocol CardDeckViewControllerDelegate: AnyObject {
    func cardDeckViewControllerCloseTapped(_ viewController: CardDeckViewController)
    func cardDeckViewControllerAddCardsTapped(_ viewController: CardDeckViewController)
    func cardDeckViewControllerMenuTapped(for deck: CardDeck, in viewController: CardDeckViewController)
    func cardDeckViewControllerCardDidSelect(_ card: CardRepresentable, in viewController: CardDeckViewController)
}

extension CardDeckViewControllerDelegate where Self: SCSCoordinator {
    func cardDeckViewControllerCloseTapped(_ viewController: CardDeckViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func cardDeckViewControllerAddCardsTapped(_ viewController: CardDeckViewController) {
        let addCardsViewController = AddCardsToDeckVC()
        addCardsViewController.delegate = self as? AddCardsToDeckVCDelegate
        router.present_unique(addCardsViewController, animated: true)
    }

    func cardDeckViewControllerMenuTapped(for deck: CardDeck, in viewController: CardDeckViewController) {
        let router = DeleteAccountSheetRouter(parentViewController: viewController)
        let menuItems = deck.cardIDs.isEmpty ? DeckMenuItem.noCardsItems : DeckMenuItem.allCases
        let coordinator = DeckMenuCoordinator(router: router, menuItems: menuItems)
        coordinator.didSelectItem = { [weak self] item in
            self?.menuItemDidSelect(item, for: deck, parentViewController: viewController)
        }
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func cardDeckViewControllerCardDidSelect(_ card: CardRepresentable, in viewController: CardDeckViewController) {
        let coordinator = CardDetailsCoordinator(router: router, card: card)
        coordinator.delegate = self as? CardDetailsCoordinatorDelegate
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    // MARK: - Helpers

    private func menuItemDidSelect(_ item: DeckMenuItem, for deck: CardDeck, parentViewController: CardDeckViewController) {
        switch item {
        case .addCards: presentAddCards(in: parentViewController)
        case .removeCards: presentRemoveCards()
        case .sortCards: presentSortCards()
        case .editDeck: presentEditDeck(deck)
        case .deleteDeck: presentDeleteDeckConfirmation(in: parentViewController)
        }
    }

    private func presentAddCards(in viewController: CardDeckViewController) {
        cardDeckViewControllerAddCardsTapped(viewController)
    }

    private func presentRemoveCards() {
        let removeCardsViewController = RemoveCardsFromDeckVC()
        removeCardsViewController.delegate = self as? RemoveCardsFromDeckVCDelegate
        router.present_unique(removeCardsViewController, animated: true)
    }

    private func presentSortCards() {
        let sortCardsViewController = SortCardsViewController()
        sortCardsViewController.delegate = self as? SortCardsViewControllerDelegate
        router.present_unique(sortCardsViewController, animated: true)
    }

    private func presentEditDeck(_ cardDeck: CardDeck) {
        let editDeckViewController = CreateEditDeckVC(cardDeck: cardDeck)
        editDeckViewController.delegate = self as? CreateEditDeckVCDelegate
        router.present_unique(editDeckViewController, animated: true)
    }

    private func presentDeleteDeckConfirmation(in viewController: CardDeckViewController) {
        let router = DeleteAccountSheetRouter(parentViewController: viewController)
        let coordinator = DeleteDeckPromptCoordinator(router: router)
        coordinator.delegate = self as? DeleteDeckPromptCoordinatorDelegate
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }
}
