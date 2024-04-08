import Foundation

protocol AddCardsToCollectionCategoriesVCDelegate: AnyObject {
    func addCardsToCollectionCategoriesVCCancelTapped(_ viewController: AddCardsToCollectionCategoriesVC)
    func addCardsToCollectionCategoriesVCDoneTapped(_ viewController: AddCardsToCollectionCategoriesVC)
    func addCardsToCollectionCategoriesVCCategoryDidSelect(_ category: CardCategory, in viewController: AddCardsToCollectionCategoriesVC)
}

extension AddCardsToCollectionCategoriesVCDelegate where Self: SCSCoordinator {
    func addCardsToCollectionCategoriesVCCancelTapped(_ viewController: AddCardsToCollectionCategoriesVC) {
        router.dismiss_unique(viewController, animated: true)
    }

    func addCardsToCollectionCategoriesVCDoneTapped(_ viewController: AddCardsToCollectionCategoriesVC) {
        router.dismiss_unique(viewController, animated: true)
    }

    func addCardsToCollectionCategoriesVCCategoryDidSelect(_ category: CardCategory, in viewController: AddCardsToCollectionCategoriesVC) {
        let addCardsController = AddCardsToCollectionCardsVC(helper: viewController.helper, cardCategory: category)
        addCardsController.delegate = self as? AddCardsToCollectionCardsVCDelegate
        router.present_unique(addCardsController, animated: true)
    }
}
