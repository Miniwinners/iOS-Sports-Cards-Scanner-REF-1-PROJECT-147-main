import UIKit

protocol ScanCardViewControllerDelegate: AnyObject {
    func scanCardViewControllerCloseTapped(_ viewController: ScanCardViewController)
    func scanCardViewControllerOpenSettings(_ viewController: ScanCardViewController)
    func scanCardViewControllerDidCapture(card: ScannedCard, _ viewController: ScanCardViewController)
}
