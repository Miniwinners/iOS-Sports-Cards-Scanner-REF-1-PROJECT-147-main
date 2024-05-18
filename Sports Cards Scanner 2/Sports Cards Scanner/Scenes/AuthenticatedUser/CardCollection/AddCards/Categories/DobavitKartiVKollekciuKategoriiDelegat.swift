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
    func addCardsToCollectionCategoriesControllerotmenaNazhata(_ viewController: DobavitKartiVKollekciuKategoriiController)
    func addCardsToCollectionCategoriesControllerGotovoNazhata(_ viewController: DobavitKartiVKollekciuKategoriiController)
    func dobavitKartiVKollekciuKategoriiDidVibrana(_ category: KategoriiKart, in viewController: DobavitKartiVKollekciuKategoriiController)
}

extension DobavitKartiVKollekciuKategoriiDelegat where Self: SportivinieKartiCoo {
    func addCardsToCollectionCategoriesControllerotmenaNazhata(_ viewController: DobavitKartiVKollekciuKategoriiController) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func addCardsToCollectionCategoriesControllerGotovoNazhata(_ viewController: DobavitKartiVKollekciuKategoriiController) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func dobavitKartiVKollekciuKategoriiDidVibrana(_ category: KategoriiKart, in viewController: DobavitKartiVKollekciuKategoriiController) {
        let addCardsController = DobavitKartiVKollekciuController(helper: viewController.helper, cardCategory: category)
        addCardsController.delegate = self as? DobavitKartiToCollectionKartiDelegat
        router.poyavitsaUnicalno(addCardsController, animated: true)
    }
}
