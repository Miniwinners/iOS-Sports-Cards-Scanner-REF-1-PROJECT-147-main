import UIKit

protocol SignUpViewControllerDelegate: AnyObject {
    func signUpViewControllerDidPressSignIn(_ viewController: SCSSignUpVC)
    func signUpViewControllerUserSignedUp(_ viewController: SCSSignUpVC)
}
