import UIKit

final class SportivinieKartiMenuKollekciiCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania
    let menuItems: [SportivinieKartiKollekciaMenuShtuka]

    var didSelectItem: ((SportivinieKartiKollekciaMenuShtuka) -> Void)?

    init(router: SportivinieKartiGlavniiRouterPrilozhania, menuItems: [SportivinieKartiKollekciaMenuShtuka]) {
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

extension SportivinieKartiMenuKollekciiCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiMenuKollekciiController(menuItems: menuItems)
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

extension SportivinieKartiMenuKollekciiCoo: SportivinieKartiMenuKollekciiDelegat {
    func otmenaNazhata(_ viewController: SportivinieKartiMenuKollekciiController) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func vibraniDidItem(_ item: SportivinieKartiKollekciaMenuShtuka, in viewController: SportivinieKartiMenuKollekciiController) {
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

enum MenuItemsScreen {
    case sort
    case ydalit
    case add
    case estimate
    case edit
}
