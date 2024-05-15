import Foundation
import UIKit
func vicheslitFibonc188(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiKartaKollekciiDelegat: AnyObject {
    func cardCollectionViewControllerzakrtiNazhata(_ viewController: SCDKartaKollekciiVc)
    func cardCollectionViewControllerDobavitKarty(_ viewController: SCDKartaKollekciiVc)
    func kartaMenuNazhata(for collection: SportivinieKartiKartaKollekcia, in viewController: SCDKartaKollekciiVc)
    func cardCollectionViewControllerKartaNazhata(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SCDKartaKollekciiVc)
}

extension SportivinieKartiKartaKollekciiDelegat where Self: SportivinieKartiCoo {
    func cardCollectionViewControllerzakrtiNazhata(_ viewController: SCDKartaKollekciiVc) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func kartaMenuNazhata(for collection: SportivinieKartiKartaKollekcia, in viewController: SCDKartaKollekciiVc) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let iPhoneHeight: CGFloat = 124 * 3 + 20 * 7 + 26
        let iPhoneWidth: CGFloat = 145 * 2 + 20 * 2 + 10
        let iPadHeight: CGFloat = 212 * 3 + 20 * 7 + 96
        let iPadWidth: CGFloat = 244 * 2 + 20 * 2 + 10

        let router = SportivinieKartiDASR(parentViewController: viewController,
                                              presentStyle: .centerRect,
                                              heightRatio: UIDevice.isIpad ? iPadHeight:iPhoneHeight,
                                              widthRatio: UIDevice.isIpad ? iPadWidth:iPhoneWidth)
        let menuItems = collection.cardIDs.isEmpty ? SportivinieKartiKollekciaMenuShtuka.noCardsItems : SportivinieKartiKollekciaMenuShtuka.allCases
        let coordinator = SportivinieKartiMenuKollekciiCoo(router: router, menuItems: menuItems)
        coordinator.didSelectItem = { [weak self] item in
            self?.menuShtukaDidVibrana(item, for: collection, parentViewController: viewController)
        }
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func cardCollectionViewControllerKartaNazhata(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SCDKartaKollekciiVc) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let coordinator = SportivinieKartiDetailCardCoo(router: router, card: card, previousVC: .common, sample: nil)
        coordinator.delegate = self as? CardDetailsCoordinatorDelegate
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    // MARK: - Helpers

    private func menuShtukaDidVibrana(_ item: SportivinieKartiKollekciaMenuShtuka, for collection: SportivinieKartiKartaKollekcia, parentViewController: SCDKartaKollekciiVc) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        switch item {
        case .addCards: postavitDobavitKarti(in: parentViewController)
        case .removeCards: postavitYbratKarti()
        case .sortCards: postavitSortirovkyKart()
        case .showTotalPrice: break
        case .renameCollection: postavitIzmenitKollekciu(collection)
        case .deleteCollection: postavitYdalitKollekciuConfirm(in: parentViewController)
        }
    }

    private func postavitDobavitKarti(in viewController: SCDKartaKollekciiVc) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardCollectionViewControllerDobavitKarty(viewController)
    }

    private func postavitYbratKarti() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let removeCardsViewController = SportivinieKartiRCardsFronKollekcii()
        removeCardsViewController.delegate = self as? SportivinieKartiRCardsFromKollekciiDelegat
        router.poyavitsaUnicalno(removeCardsViewController, animated: true)
    }

    private func postavitSortirovkyKart() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let sortCardsViewController = SportivinieKartiSortirovkaKartVc()
        sortCardsViewController.delegate = self as? SportivinieKartiSortirovkaKartVcDelegat
        router.poyavitsaUnicalno(sortCardsViewController, animated: true)
    }

    private func postavitIzmenitKollekciu(_ cardCollection: SportivinieKartiKartaKollekcia) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let editCollectionViewController = SportivinieKartiSodatIzmenitKollekciu(cardCollection: cardCollection)
        editCollectionViewController.delegate = self as? SportivinieKartiSozdatIzmenitKollekciuDelegat
        router.poyavitsaUnicalno(editCollectionViewController, animated: true)
    }

    private func postavitYdalitKollekciuConfirm(in viewController: SCDKartaKollekciiVc) {
        let ipadWidth: CGFloat = viewController.view.frame.width - 240
        let iPhoneWidth: CGFloat = viewController.view.frame.width - 60
        let iPadHeight: CGFloat = 380
        let iPhoneHeight: CGFloat = 300
        let router = SportivinieKartiDASR(parentViewController: viewController, presentStyle: .center,
                                              heightRatio: UIDevice.isIpad ? iPadHeight:iPhoneHeight,
                                              widthRatio: UIDevice.isIpad ? ipadWidth: iPhoneWidth)
        let coordinator = SportivinieKartiYdalitKollekciuCoo(router: router)
        coordinator.delegate = self as? DeleteCollectionDelegat
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }
}
