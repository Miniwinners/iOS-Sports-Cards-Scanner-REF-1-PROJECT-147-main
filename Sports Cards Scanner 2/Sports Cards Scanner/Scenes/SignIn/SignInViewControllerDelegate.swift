import UIKit

protocol SignInViewControllerDelegate: AnyObject {
    func signInViewControllerDidPressSignUp(_ viewController: SCSSignInVC)
    func signInViewControllerUserSignedIn(_ viewController: SCSSignInVC)
    func signInViewControllerDidPressForgotPassword(_ viewController: SCSSignInVC)
}
