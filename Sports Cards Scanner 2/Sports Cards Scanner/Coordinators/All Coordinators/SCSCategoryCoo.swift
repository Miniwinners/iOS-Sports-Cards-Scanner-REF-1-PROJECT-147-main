import UIKit

final class SportivinieKartiCategoryCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    private let category: KategoriiKart
    private let cardsManager: SportivinieKartiUserKartManager

    init(
        router: SportivinieKartiGlavniiRouterPrilozhania,
        category: KategoriiKart,
        cardsManager: SportivinieKartiUserKartManager = .shared
    ) {
        self.router = router
        self.category = category
        self.cardsManager = cardsManager
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiCategoryCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiKategoriiKartVC(category: category)
        viewController.delegate = self
        router.poyavitsaUnicalno(viewController, animated: animated, onDismissed: onDismissed)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiCategoryCoo: SCDKategotiiKartDelegat {
    func categoriiZakritnazhata(_ viewController: SportivinieKartiKategoriiKartVC) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func categoriaNazahataVibrana(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiKategoriiKartVC) {
        let coordinator = SportivinieKartiDetailCardCoo(router: router, card: card, previousVC: .common, sample: nil)
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

extension SportivinieKartiCategoryCoo: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardYbrana(_ coordinator: SportivinieKartiDetailCardCoo, from viewController: SportivinieKartiCardOwnVCDetail) {
        if cardsManager.karti(of: category).isEmpty {
            router.ischeznytPolnostuu(animated: true)
        } else {
            router.ischeznytUnicalno(viewController, animated: true)
        }
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}
enum UnicalniEnumTen {
    case one
    case two
    case three
}
