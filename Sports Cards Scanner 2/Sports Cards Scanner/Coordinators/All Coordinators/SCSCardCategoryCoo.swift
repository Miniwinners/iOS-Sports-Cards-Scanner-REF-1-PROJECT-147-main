import UIKit

final class SportivinieKartiCardCategoryCoo: SportivinieKartiCoo {
    var children: [SportivinieKartiCoo] = []

    let router: SportivinieKartiGlavniiRouterPrilozhania

    init(router: SportivinieKartiGlavniiRouterPrilozhania) {
        self.router = router
    }

    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let cardCategoriesViewController = SportivinieKartiKartiKategoriiController()
        cardCategoriesViewController.delegate = self
        router.poyavitsaUnicalno(cardCategoriesViewController, animated: animated, onDismissed: onDismissed)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiCardCategoryCoo: SportivinieKartiKartiKategoriiDelegat {
    func cardCategoriesViewControllerzakrtiNazhata(_ viewController: SportivinieKartiKartiKategoriiController) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        router.ischeznytPolnostuu(animated: true)
    }
}

enum UnicalniEnum {
    case one
    case two
    case three
}
