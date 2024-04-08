import Foundation

protocol RecentlyAddedListViewControllerDelegate: AnyObject {
    func recentlyAddedListViewControllerCloseTapped(_ viewController: RecentlyAddedListViewController)
    func recentlyAddedListViewControllerDidSelectCard(_ card: CardRepresentable, in viewController: RecentlyAddedListViewController)
}
