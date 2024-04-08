import UIKit

protocol PromptViewControllerDelegate: AnyObject {
    func promptViewControllerCancelTapped(_ viewController: PromptViewController)
    func promptViewControllerConfirmTapped(_ viewController: PromptViewController)
}
