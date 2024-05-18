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
    func cardDeckViewControllerzakrtiNazhata(_ viewController: SportivinieKartiKolodaController)
    func kartaKolodaDobavitKartiNazhata(_ viewController: SportivinieKartiKolodaController)
    func kartaKolodaMenuNazhata(for deck: SportivinieKartiCartaKoloda, in viewController: SportivinieKartiKolodaController)
    func kartaKolodaDidVibrana(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiKolodaController)
}

extension KartaKolodaDelegat where Self: SportivinieKartiCoo {
    func cardDeckViewControllerzakrtiNazhata(_ viewController: SportivinieKartiKolodaController) {

        router.ischeznytPolnostuu(animated: true)
    }

    func kartaKolodaDobavitKartiNazhata(_ viewController: SportivinieKartiKolodaController) {
        let addCardsViewController = SportivinieKartiDobavitKartiKolodaController()
        addCardsViewController.delegate = self as? SportivinieKartiDobavitKartiKolodaDelegat
        router.poyavitsaUnicalno(addCardsViewController, animated: true)
    }

    func kartaKolodaMenuNazhata(for deck: SportivinieKartiCartaKoloda, in viewController: SportivinieKartiKolodaController) {
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

    func kartaKolodaDidVibrana(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiKolodaController) {
        let coordinator = SportivinieKartiDetailCardCoo(router: router, card: card, previousController: .common, sample: nil)
        coordinator.delegate = self as? CardDetailsCoordinatorDelegate
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    // MARK: - Helpers

    private func menuShtukaDidVibrana(_ item: SportivinieKartiMenuKolodaShtuka, for deck: SportivinieKartiCartaKoloda, parentViewController: SportivinieKartiKolodaController) {
        switch item {
        case .addCards: pokazatDobavitKarti(in: parentViewController)
        case .removeCards: pokazatYbratKarti()
        case .sortCards: pokazatSortirovkeKart()
        case .editDeck: pokazatIzmenitKolody(deck)
        case .deleteDeck: pokazatYdalitKolodyConfirm(in: parentViewController)
        }
    }

    private func pokazatDobavitKarti(in viewController: SportivinieKartiKolodaController) {
        kartaKolodaDobavitKartiNazhata(viewController)
    }

    private func pokazatYbratKarti() {
        let removeCardsViewController = SportivinieKartiYbratKartuKolodaController()
        removeCardsViewController.delegate = self as? SportivinieKartiYbratKartuKolodaDelegat
        router.poyavitsaUnicalno(removeCardsViewController, animated: true)
    }

    private func pokazatSortirovkeKart() {
        let sortCardsViewController = SportivinieKartiSortirovkaKarTableKlrtka()
        sortCardsViewController.delegate = self as? SportivinieKartiSortirovkaKartControllerDelegat
        router.poyavitsaUnicalno(sortCardsViewController, animated: true)
    }

    private func pokazatIzmenitKolody(_ cardDeck: SportivinieKartiCartaKoloda) {
        let editDeckViewController = SportivinieKartiSodatIzmeniTableKlrtka(cardDeck: cardDeck)
        editDeckViewController.delegate = self as? SportivinieKartiSodatIzmenitDelegat
        router.poyavitsaUnicalno(editDeckViewController, animated: true)
    }

    private func pokazatYdalitKolodyConfirm(in viewController: SportivinieKartiKolodaController) {
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
