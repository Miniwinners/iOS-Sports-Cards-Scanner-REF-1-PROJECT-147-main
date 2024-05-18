import UIKit

final class SportivinieKartiKartaKollekciaCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    var addCardsParentViewController: DobavitKartiVKollekciuKategoriiController?

    init(router: SportivinieKartiGlavniiRouterPrilozhania) {
        self.router = router
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiKartaKollekciaCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SCDKartaKollekciiController()
        viewController.delegate = self
        router.poyavitsaUnicalno(viewController, animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiKartaKollekciaCoo: SportivinieKartiKartaKollekciiDelegat {
    func cardCollectionViewControllerDobavitKarty(_ viewController: SCDKartaKollekciiController) {
        let viewController = DobavitKartiVKollekciuKategoriiController()
        viewController.delegate = self
        self.addCardsParentViewController = viewController
        router.poyavitsaUnicalno(viewController, animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

}

extension SportivinieKartiKartaKollekciaCoo: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardYbrana(_ coordinator: SportivinieKartiDetailCardCoo, from viewController: SportivinieKartiCardOwnControllerDetail) {
        router.ischeznytUnicalno(viewController, animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiKartaKollekciaCoo: DeleteCollectionDelegat {
    func deleteCollectionPromptCoordinatorYdalitNazhata(_ coordinator: SportivinieKartiYdalitKollekciuCoo) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiKartaKollekciaCoo: DobavitKartiVKollekciuKategoriiDelegat { }
extension SportivinieKartiKartaKollekciaCoo: DobavitKartiToCollectionKartiDelegat { }
extension SportivinieKartiKartaKollekciaCoo: SportivinieKartiRCardsFromKollekciiDelegat { }
extension SportivinieKartiKartaKollekciaCoo: SportivinieKartiSortirovkaKartControllerDelegat { }
extension SportivinieKartiKartaKollekciaCoo: SportivinieKartiSozdatIzmenitKollekciuDelegat { }

enum KartaKollekciiCoo {
    case ydalit
    case present
    case none
}
