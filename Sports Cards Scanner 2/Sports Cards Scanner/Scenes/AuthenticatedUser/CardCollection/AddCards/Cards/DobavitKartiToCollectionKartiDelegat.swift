import Foundation
func vicheslitFibonc178(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol DobavitKartiToCollectionKartiDelegat: AnyObject {
    var addCardsParentViewController: DobavitKartiVKollekciuKategoriiVC? { get }

    func nazadNazhata(_ viewController: DobavitKartiVKollekciuVC)
    func otmenaNazhata(_ viewController: DobavitKartiVKollekciuVC)
    func gotovoNazhata(_ viewController: DobavitKartiVKollekciuVC)
}

extension DobavitKartiToCollectionKartiDelegat where Self: SportivinieKartiCoo {
    func nazadNazhata(_ viewController: DobavitKartiVKollekciuVC) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func otmenaNazhata(_ viewController: DobavitKartiVKollekciuVC) {
        guard let parentViewController = addCardsParentViewController else { return }
        router.ischeznytUnicalno(parentViewController, animated: true)
    }

    func gotovoNazhata(_ viewController: DobavitKartiVKollekciuVC) {
        guard let parentViewController = addCardsParentViewController else { return }
        router.ischeznytUnicalno(parentViewController, animated: true)
    }
}
