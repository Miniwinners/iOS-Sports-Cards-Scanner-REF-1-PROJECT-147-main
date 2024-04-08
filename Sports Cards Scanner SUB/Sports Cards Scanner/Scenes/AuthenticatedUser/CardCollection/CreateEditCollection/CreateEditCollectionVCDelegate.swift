import Foundation

protocol CreateEditCollectionVCDelegate: AnyObject {
    func createCollectionVCCloseTapped(_ viewController: CreateEditCollectionVC)
    func createCollectionVCCollectionDidCreate(_ viewController: CreateEditCollectionVC)
    func editCollectionVCCancelTapped(_ viewController: CreateEditCollectionVC)
    func editCollectionVCDoneTapped(_ viewController: CreateEditCollectionVC)
}

extension CreateEditCollectionVCDelegate where Self: SCSCoordinator {
    func createCollectionVCCloseTapped(_ viewController: CreateEditCollectionVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        router.dismissFully(animated: true)
    }

    func createCollectionVCCollectionDidCreate(_ viewController: CreateEditCollectionVC) {
        let viewController = CardCollectionViewController()
        viewController.delegate = self as? CardCollectionViewControllerDelegate
        router.present_unique(viewController, animated: true)
    }

    func editCollectionVCCancelTapped(_ viewController: CreateEditCollectionVC) {
        router.dismiss_unique(viewController, animated: true)
    }

    func editCollectionVCDoneTapped(_ viewController: CreateEditCollectionVC) {
        router.dismiss_unique(viewController, animated: true)
    }
}
