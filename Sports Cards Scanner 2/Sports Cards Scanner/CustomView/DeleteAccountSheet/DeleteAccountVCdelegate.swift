import UIKit

protocol DeleteAccountVCdelegate: AnyObject {
    func promptViewControllerCancelTapped(_ viewController: DeleteAccountVC)
    func promptViewControllerConfirmTapped(_ viewController: DeleteAccountVC)
}
