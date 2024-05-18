import UIKit

final class SportivinieKartiPoiskCardCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    weak var delegate: SearchCardCoordinatorDelegate?

    private let scannedCard: SportivinieKartiScanirovannayaKarta
    private var scanCardViewController: SportivinieKartiScanirovanieKartiController?
    init(router: SportivinieKartiGlavniiRouterPrilozhania, card: SportivinieKartiScanirovannayaKarta, sample: SportivinieKartiScanirovanieKartiController? = nil) {
        self.router = router
        self.scannedCard = card
        self.scanCardViewController = sample
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiPoiskCardCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiPoiskKartiController(searchCategory: scannedCard.cardCategory)
        viewController.delegate = self
        router.poyavitsaUnicalno(viewController, animated: true, onDismissed: onDismissed)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiPoiskCardCoo: SportivinieKartiPoiskKartiDelegat {
    func poiskZakritNazhata(_ viewController: SportivinieKartiPoiskKartiController) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func poiskVkladkaNazhata(card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiPoiskKartiController) {
        let coordinator = SportivinieKartiDetailCardCoo(router: router, card: card, cardType: .searchedCard, encodedCardImage: scannedCard.encodedCardImage, previousController: .search, sample: scanCardViewController)
        coordinator.delegate = self
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiPoiskCardCoo: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorKartaDobavlena(_ coordinator: SportivinieKartiDetailCardCoo, from viewController: SportivinieKartiCardOwnControllerDetail) {
        if let delegate {
            delegate.searchCardCoordinatorKartadDobavlena(self)
        } else {
            router.ischeznytPolnostuu(animated: true)
        }
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

// MARK: - Search Card Delegate

protocol SearchCardCoordinatorDelegate: AnyObject {
    func searchCardCoordinatorKartadDobavlena(_ coordinator: SportivinieKartiPoiskCardCoo)
}
