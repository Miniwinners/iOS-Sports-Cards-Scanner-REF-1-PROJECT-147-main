import Foundation

protocol DeckMenuViewControllerDelegate: AnyObject {
    func deckMenuViewControllerCancelTapped(_ viewController: DeckMenuViewController)
    func deckMenuViewControllerDidSelectItem(_ item: DeckMenuItem, in viewController: DeckMenuViewController)
}
