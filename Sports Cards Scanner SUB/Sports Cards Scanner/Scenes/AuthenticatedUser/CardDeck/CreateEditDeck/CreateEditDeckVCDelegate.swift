import Foundation

protocol CreateEditDeckVCDelegate: AnyObject {
    func createDeckViewControllerCloseTapped(_ viewController: CreateEditDeckVC)
    func createDeckViewControllerDeckDidCreate(_ viewController: CreateEditDeckVC)

    func editDeckViewControllerCancelTapped(_ viewController: CreateEditDeckVC)
    func editDeckViewControllerDoneTapped(_ viewController: CreateEditDeckVC)
}

extension CreateEditDeckVCDelegate where Self: SCSCoordinator {
    func createDeckViewControllerCloseTapped(_ viewController: CreateEditDeckVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func createDeckViewControllerDeckDidCreate(_ viewController: CreateEditDeckVC) {
        let cardDeckViewController = CardDeckViewController()
        cardDeckViewController.delegate = self as? CardDeckViewControllerDelegate
        router.present_unique(cardDeckViewController, animated: true)
    }

    func editDeckViewControllerCancelTapped(_ viewController: CreateEditDeckVC) {
        router.dismiss_unique(viewController, animated: true)
    }

    func editDeckViewControllerDoneTapped(_ viewController: CreateEditDeckVC) {
        router.dismiss_unique(viewController, animated: true)
    }
}
