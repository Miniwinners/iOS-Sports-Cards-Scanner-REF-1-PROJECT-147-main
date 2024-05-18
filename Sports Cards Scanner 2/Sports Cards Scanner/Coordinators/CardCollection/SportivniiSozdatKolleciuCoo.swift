import UIKit
enum UnicalnieFunkcii {
    case one
    case two
    case three
}
final class SportivinieKartiSozdatKolleciuCoo {
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

extension SportivinieKartiSozdatKolleciuCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiSodatIzmenitKollekciu()
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

extension SportivinieKartiSozdatKolleciuCoo: SportivinieKartiKartaKollekciiDelegat {
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

extension SportivinieKartiSozdatKolleciuCoo: CardDetailsCoordinatorDelegate {
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

extension SportivinieKartiSozdatKolleciuCoo: DeleteCollectionDelegat {
    func deleteCollectionPromptCoordinatorYdalitNazhata(_ coordinator: SportivinieKartiYdalitKollekciuCoo) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        router.ischeznytPolnostuu(animated: true)
    }
}

extension SportivinieKartiSozdatKolleciuCoo: DobavitKartiVKollekciuKategoriiDelegat { }
extension SportivinieKartiSozdatKolleciuCoo: DobavitKartiToCollectionKartiDelegat { }
extension SportivinieKartiSozdatKolleciuCoo: SportivinieKartiRCardsFromKollekciiDelegat { }
extension SportivinieKartiSozdatKolleciuCoo: SportivinieKartiSortirovkaKartControllerDelegat { }
extension SportivinieKartiSozdatKolleciuCoo: SportivinieKartiSozdatIzmenitKollekciuDelegat { }
