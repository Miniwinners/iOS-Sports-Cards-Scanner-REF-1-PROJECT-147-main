import UIKit

protocol UpdatePasswordViewControllerDelegate: AnyObject {
    func updatePasswordViewControllerPasswordDidUpdate(_ viewController: UpdatePasswordVC)
    func updatePasswordViewControllerCloseTapped(_ viewController: UpdatePasswordVC)
}
