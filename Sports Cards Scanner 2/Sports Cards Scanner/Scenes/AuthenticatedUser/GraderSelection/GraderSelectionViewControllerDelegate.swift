import Foundation

protocol GraderSelectionViewControllerDelegate: AnyObject {
    func graderSelectionViewControllerDidSelect(grader: CardGrader, in viewController: GraderSelectionViewController)
    func graderSelectionViewControllerCancelTapped(_ viewController: GraderSelectionViewController)
}
