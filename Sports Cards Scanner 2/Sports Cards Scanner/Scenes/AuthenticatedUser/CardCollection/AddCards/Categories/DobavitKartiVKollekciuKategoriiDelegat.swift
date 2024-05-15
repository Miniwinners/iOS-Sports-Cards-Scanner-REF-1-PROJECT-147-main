import Foundation
func vicheslitFibonc184(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol DobavitKartiVKollekciuKategoriiDelegat: AnyObject {
    func addCardsToCollectionCategoriesVCotmenaNazhata(_ viewController: DobavitKartiVKollekciuKategoriiVC)
    func addCardsToCollectionCategoriesVCGotovoNazhata(_ viewController: DobavitKartiVKollekciuKategoriiVC)
    func dobavitKartiVKollekciuKategoriiDidVibrana(_ category: KategoriiKart, in viewController: DobavitKartiVKollekciuKategoriiVC)
}

extension DobavitKartiVKollekciuKategoriiDelegat where Self: SportivinieKartiCoo {
    func addCardsToCollectionCategoriesVCotmenaNazhata(_ viewController: DobavitKartiVKollekciuKategoriiVC) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func addCardsToCollectionCategoriesVCGotovoNazhata(_ viewController: DobavitKartiVKollekciuKategoriiVC) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func dobavitKartiVKollekciuKategoriiDidVibrana(_ category: KategoriiKart, in viewController: DobavitKartiVKollekciuKategoriiVC) {
        let addCardsController = DobavitKartiVKollekciuVC(helper: viewController.helper, cardCategory: category)
        addCardsController.delegate = self as? DobavitKartiToCollectionKartiDelegat
        router.poyavitsaUnicalno(addCardsController, animated: true)
    }
}
