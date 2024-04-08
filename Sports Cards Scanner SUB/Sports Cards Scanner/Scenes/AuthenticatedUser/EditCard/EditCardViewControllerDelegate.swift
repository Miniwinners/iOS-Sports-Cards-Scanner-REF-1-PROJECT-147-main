import Foundation

protocol EditCardViewControllerDelegate: AnyObject {
    func editCardViewControllerParallelTapped(_ viewController: EditCardViewController)
    func editCardViewControllerGradeTapped(_ viewController: EditCardViewController)
    func editCardViewControllerDetailsDidUpdate(_ viewController: EditCardViewController)
}
