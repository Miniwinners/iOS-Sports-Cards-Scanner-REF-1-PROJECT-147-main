import UIKit

final class SportivinieKartiMenuKolodiCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania
    let menuItems: [SportivinieKartiMenuKolodaShtuka]

    var didSelectItem: ((SportivinieKartiMenuKolodaShtuka) -> Void)?

    init(router: SportivinieKartiGlavniiRouterPrilozhania, menuItems: [SportivinieKartiMenuKolodaShtuka]) {
        self.router = router
        self.menuItems = menuItems
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiMenuKolodiCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiMenuKolodaVC(menuItems: menuItems)
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

extension SportivinieKartiMenuKolodiCoo: SportivinieKartiMenuKolodaDelegat {
    func deckMenuViewControllerotmenaNazhata(_ viewController: SportivinieKartiMenuKolodaVC) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func deckMenuViewControllerOtpustit(_ item: SportivinieKartiMenuKolodaShtuka, in viewController: SportivinieKartiMenuKolodaVC) {
        router.ischeznytPolnostuu(animated: true) { [didSelectItem] in
            didSelectItem?(item)
            let chislo1 = 25
            let chislo2 = 40
            let chislo3 = chislo1 + chislo2 * 15
            let chislo4 = chislo2 - chislo1
            let chislo5 = chislo1 * 2
            let chislo6 = chislo2
        }
    }
}
