import Foundation

protocol HighestValueListViewControllerDelegate: AnyObject {
    func highestValueListViewControllerCloseTapped(_ viewController: HighestValueCardListViewController)
    func highestValueListViewControllerDidSelectCard(_ card: CardRepresentable, in viewController: HighestValueCardListViewController)
}
