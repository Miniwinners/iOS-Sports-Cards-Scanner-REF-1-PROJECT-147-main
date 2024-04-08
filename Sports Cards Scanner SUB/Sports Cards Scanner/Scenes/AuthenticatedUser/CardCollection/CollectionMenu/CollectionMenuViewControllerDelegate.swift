import Foundation

protocol CollectionMenuViewControllerDelegate: AnyObject {
    func collectionMenuViewControllerCancelTapped(_ viewController: CollectionMenuViewController)
    func collectionMenuViewControllerDidSelectItem(_ item: CollectionMenuItem, in viewController: CollectionMenuViewController)
}
