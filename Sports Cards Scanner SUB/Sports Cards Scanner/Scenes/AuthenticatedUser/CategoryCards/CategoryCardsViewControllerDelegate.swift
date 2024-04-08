import Foundation

protocol CategoryCardsViewControllerDelegate: AnyObject {
    func categoryCardsViewControllerCloseTapped(_ viewController: CategoryCardsViewController)
    func categoryCardsViewControllerDidSelectCard(_ card: CardRepresentable, in viewController: CategoryCardsViewController)
}
