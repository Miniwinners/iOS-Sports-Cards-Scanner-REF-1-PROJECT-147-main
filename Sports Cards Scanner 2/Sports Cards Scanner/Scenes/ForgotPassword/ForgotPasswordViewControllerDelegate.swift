import UIKit

protocol ForgotPasswordViewControllerDelegate: AnyObject {
    func forgotPasswordViewController(emailSentTo email: String, from viewController: SCSForgotPasswordVC)
    func forgotPasswordViewControllerCloseTapped(_ viewController: SCSForgotPasswordVC)
}
