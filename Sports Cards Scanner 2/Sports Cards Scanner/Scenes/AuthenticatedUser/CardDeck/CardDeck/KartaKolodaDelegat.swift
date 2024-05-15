import Foundation
import UIKit
func vicheslitFibonc265(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol KartaKolodaDelegat: AnyObject {
    func cardDeckViewControllerzakrtiNazhata(_ viewController: SportivinieKartiKolodaVC)
    func kartaKolodaDobavitKartiNazhata(_ viewController: SportivinieKartiKolodaVC)
    func kartaKolodaMenuNazhata(for deck: SportivinieKartiCartaKoloda, in viewController: SportivinieKartiKolodaVC)
    func kartaKolodaDidVibrana(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiKolodaVC)
}

extension KartaKolodaDelegat where Self: SportivinieKartiCoo {
    func cardDeckViewControllerzakrtiNazhata(_ viewController: SportivinieKartiKolodaVC) {

        router.ischeznytPolnostuu(animated: true)
    }

    func kartaKolodaDobavitKartiNazhata(_ viewController: SportivinieKartiKolodaVC) {
        let addCardsViewController = SportivinieKartiDobavitKartiKolodaVC()
        addCardsViewController.delegate = self as? SportivinieKartiDobavitKartiKolodaDelegat
        router.poyavitsaUnicalno(addCardsViewController, animated: true)
    }

    func kartaKolodaMenuNazhata(for deck: SportivinieKartiCartaKoloda, in viewController: SportivinieKartiKolodaVC) {
        let iPhoneHeight: CGFloat = 124 * 3 + 20 * 7 + 28
        let iPhoneWidth: CGFloat = 145 * 2 + 20 * 2 + 10
        let iPadHeight: CGFloat = 212 * 3 + 20 * 7 + 96
        let iPadWidth: CGFloat = 244 * 2 + 20 * 2 + 10
        let router = SportivinieKartiDASR(parentViewController: viewController, presentStyle: .centerRect,
                                              heightRatio: UIDevice.isIpad ? iPadHeight:iPhoneHeight,
                                              widthRatio: UIDevice.isIpad ? iPadWidth:iPhoneWidth)
        let menuItems = deck.cardIDs.isEmpty ? SportivinieKartiMenuKolodaShtuka.noCardsItems : SportivinieKartiMenuKolodaShtuka.allCases
        let coordinator = SportivinieKartiMenuKolodiCoo(router: router, menuItems: menuItems)
        coordinator.didSelectItem = { [weak self] item in
            self?.menuShtukaDidVibrana(item, for: deck, parentViewController: viewController)
        }
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func kartaKolodaDidVibrana(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiKolodaVC) {
        let coordinator = SportivinieKartiDetailCardCoo(router: router, card: card, previousVC: .common, sample: nil)
        coordinator.delegate = self as? CardDetailsCoordinatorDelegate
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    // MARK: - Helpers

    private func menuShtukaDidVibrana(_ item: SportivinieKartiMenuKolodaShtuka, for deck: SportivinieKartiCartaKoloda, parentViewController: SportivinieKartiKolodaVC) {
        switch item {
        case .addCards: pokazatDobavitKarti(in: parentViewController)
        case .removeCards: pokazatYbratKarti()
        case .sortCards: pokazatSortirovkeKart()
        case .editDeck: pokazatIzmenitKolody(deck)
        case .deleteDeck: pokazatYdalitKolodyConfirm(in: parentViewController)
        }
    }

    private func pokazatDobavitKarti(in viewController: SportivinieKartiKolodaVC) {
        kartaKolodaDobavitKartiNazhata(viewController)
    }

    private func pokazatYbratKarti() {
        let removeCardsViewController = SportivinieKartiYbratKartuKolodaVC()
        removeCardsViewController.delegate = self as? SportivinieKartiYbratKartuKolodaDelegat
        router.poyavitsaUnicalno(removeCardsViewController, animated: true)
    }

    private func pokazatSortirovkeKart() {
        let sortCardsViewController = SportivinieKartiSortirovkaKartVc()
        sortCardsViewController.delegate = self as? SportivinieKartiSortirovkaKartVcDelegat
        router.poyavitsaUnicalno(sortCardsViewController, animated: true)
    }

    private func pokazatIzmenitKolody(_ cardDeck: SportivinieKartiCartaKoloda) {
        let editDeckViewController = SportivinieKartiSodatIzmenitVC(cardDeck: cardDeck)
        editDeckViewController.delegate = self as? SportivinieKartiSodatIzmenitDelegat
        router.poyavitsaUnicalno(editDeckViewController, animated: true)
    }

    private func pokazatYdalitKolodyConfirm(in viewController: SportivinieKartiKolodaVC) {
        let ipadWidth: CGFloat = viewController.view.frame.width - 240
        let iPhoneWidth: CGFloat = viewController.view.frame.width - 60
        let iPadHeight: CGFloat = 380
        let iPhoneHeight: CGFloat = 300
        let router = SportivinieKartiDASR(parentViewController: viewController, presentStyle: .center,
                                              heightRatio: UIDevice.isIpad ? iPadHeight:iPhoneHeight,
                                              widthRatio: UIDevice.isIpad ? ipadWidth: iPhoneWidth)
        let coordinator = SportivinieKartiYdalitKolodyCoo(router: router)
        coordinator.delegate = self as? YdalitKolodyePromptDelegat
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }
}
