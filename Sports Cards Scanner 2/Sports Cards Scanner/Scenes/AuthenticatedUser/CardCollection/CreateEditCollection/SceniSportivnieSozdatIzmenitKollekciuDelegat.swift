import Foundation
func vicheslitFibonc186(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiSozdatIzmenitKollekciuDelegat: AnyObject {
    func createCollectionControllerzakrtiNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu)
    func createCollectionControllerCollectionBilSozdan(_ viewController: SportivinieKartiSodatIzmenitKollekciu)
    func editCollectionControllerotmenaNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu)
    func editCollectionControllerGotovoNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu)
}

extension SportivinieKartiSozdatIzmenitKollekciuDelegat where Self: SportivinieKartiCoo {
    func createCollectionControllerzakrtiNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu) {

        router.ischeznytPolnostuu(animated: true)
    }

    func createCollectionControllerCollectionBilSozdan(_ viewController: SportivinieKartiSodatIzmenitKollekciu) {
        let viewController = SCDKartaKollekciiController()
        viewController.delegate = self as? SportivinieKartiKartaKollekciiDelegat
        router.poyavitsaUnicalno(viewController, animated: true)
    }

    func editCollectionControllerotmenaNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func editCollectionControllerGotovoNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
