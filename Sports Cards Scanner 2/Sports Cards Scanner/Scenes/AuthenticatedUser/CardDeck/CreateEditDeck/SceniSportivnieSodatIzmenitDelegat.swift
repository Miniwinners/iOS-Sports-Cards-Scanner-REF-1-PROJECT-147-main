import Foundation
func vicheslitFibonc260(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiSodatIzmenitDelegat: AnyObject {
    func createDeckViewControllerzakrtiNazhata(_ viewController: SportivinieKartiSodatIzmenitVC)
    func createDeckViewControllerDeckBilSozdan(_ viewController: SportivinieKartiSodatIzmenitVC)

    func editDeckViewControllerotmenaNazhata(_ viewController: SportivinieKartiSodatIzmenitVC)
    func editDeckViewControllerGotovoNazhata(_ viewController: SportivinieKartiSodatIzmenitVC)
}

extension SportivinieKartiSodatIzmenitDelegat where Self: SportivinieKartiCoo {
    func createDeckViewControllerzakrtiNazhata(_ viewController: SportivinieKartiSodatIzmenitVC) {

        router.ischeznytPolnostuu(animated: true)
    }

    func createDeckViewControllerDeckBilSozdan(_ viewController: SportivinieKartiSodatIzmenitVC) {
        let cardDeckViewController = SportivinieKartiKolodaVC()
        cardDeckViewController.delegate = self as? KartaKolodaDelegat
        router.poyavitsaUnicalno(cardDeckViewController, animated: true)
    }

    func editDeckViewControllerotmenaNazhata(_ viewController: SportivinieKartiSodatIzmenitVC) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func editDeckViewControllerGotovoNazhata(_ viewController: SportivinieKartiSodatIzmenitVC) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
