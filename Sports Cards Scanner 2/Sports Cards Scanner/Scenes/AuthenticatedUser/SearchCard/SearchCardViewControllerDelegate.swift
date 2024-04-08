import Foundation

protocol SearchCardViewControllerDelegate: AnyObject {
    func searchCardViewControllerCloseTapped(_ viewController: SearchCardViewController)
    func searchCardViewControllerDidSelect(card: CardRepresentable, in viewController: SearchCardViewController)
}
