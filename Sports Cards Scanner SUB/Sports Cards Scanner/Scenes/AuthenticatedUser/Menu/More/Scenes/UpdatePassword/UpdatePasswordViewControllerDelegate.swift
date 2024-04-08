import UIKit

protocol UpdatePasswordViewControllerDelegate: AnyObject {
    func updatePasswordViewControllerPasswordDidUpdate(_ viewController: SCSUpdatePasswordVC)
    func updatePasswordViewControllerCloseTapped(_ viewController: SCSUpdatePasswordVC)
}
