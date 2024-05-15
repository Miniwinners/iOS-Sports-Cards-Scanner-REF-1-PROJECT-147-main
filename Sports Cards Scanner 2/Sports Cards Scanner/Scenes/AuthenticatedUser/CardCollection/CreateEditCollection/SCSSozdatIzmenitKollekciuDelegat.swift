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
    func createCollectionVCzakrtiNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu)
    func createCollectionVCCollectionBilSozdan(_ viewController: SportivinieKartiSodatIzmenitKollekciu)
    func editCollectionVCotmenaNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu)
    func editCollectionVCGotovoNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu)
}

extension SportivinieKartiSozdatIzmenitKollekciuDelegat where Self: SportivinieKartiCoo {
    func createCollectionVCzakrtiNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu) {

        router.ischeznytPolnostuu(animated: true)
    }

    func createCollectionVCCollectionBilSozdan(_ viewController: SportivinieKartiSodatIzmenitKollekciu) {
        let viewController = SCDKartaKollekciiVc()
        viewController.delegate = self as? SportivinieKartiKartaKollekciiDelegat
        router.poyavitsaUnicalno(viewController, animated: true)
    }

    func editCollectionVCotmenaNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func editCollectionVCGotovoNazhata(_ viewController: SportivinieKartiSodatIzmenitKollekciu) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
