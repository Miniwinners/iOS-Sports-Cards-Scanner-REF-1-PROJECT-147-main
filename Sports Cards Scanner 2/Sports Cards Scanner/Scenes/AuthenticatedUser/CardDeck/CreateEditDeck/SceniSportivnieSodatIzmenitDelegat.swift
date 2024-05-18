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
    func createDeckViewControllerzakrtiNazhata(_ viewController: SportivinieKartiSodatIzmeniTableKlrtka)
    func createDeckViewControllerDeckBilSozdan(_ viewController: SportivinieKartiSodatIzmeniTableKlrtka)

    func editDeckViewControllerotmenaNazhata(_ viewController: SportivinieKartiSodatIzmeniTableKlrtka)
    func editDeckViewControllerGotovoNazhata(_ viewController: SportivinieKartiSodatIzmeniTableKlrtka)
}

extension SportivinieKartiSodatIzmenitDelegat where Self: SportivinieKartiCoo {
    func createDeckViewControllerzakrtiNazhata(_ viewController: SportivinieKartiSodatIzmeniTableKlrtka) {

        router.ischeznytPolnostuu(animated: true)
    }

    func createDeckViewControllerDeckBilSozdan(_ viewController: SportivinieKartiSodatIzmeniTableKlrtka) {
        let cardDeckViewController = SportivinieKartiKolodaController()
        cardDeckViewController.delegate = self as? KartaKolodaDelegat
        router.poyavitsaUnicalno(cardDeckViewController, animated: true)
    }

    func editDeckViewControllerotmenaNazhata(_ viewController: SportivinieKartiSodatIzmeniTableKlrtka) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func editDeckViewControllerGotovoNazhata(_ viewController: SportivinieKartiSodatIzmeniTableKlrtka) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}
