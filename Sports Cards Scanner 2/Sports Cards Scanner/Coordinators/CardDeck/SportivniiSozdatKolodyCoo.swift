import UIKit

final class SportivinieKartiSozdatKolodyCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    init(router: SportivinieKartiGlavniiRouterPrilozhania) {
        self.router = router
    }
}

extension SportivinieKartiSozdatKolodyCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiSodatIzmeniTableKlrtka()
        viewController.delegate = self
        router.poyavitsaUnicalno(viewController, animated: animated, onDismissed: onDismissed)
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiSozdatKolodyCoo: YdalitKolodyePromptDelegat {
    func deleteDeckPromptCoordinatorYdalitNazhata(_ coordinator: SportivinieKartiYdalitKolodyCoo) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiSozdatKolodyCoo: CardDetailsCoordinatorDelegate {
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

extension SportivinieKartiSozdatKolodyCoo: SportivinieKartiSodatIzmenitDelegat { }
extension SportivinieKartiSozdatKolodyCoo: KartaKolodaDelegat { }
extension SportivinieKartiSozdatKolodyCoo: SportivinieKartiDobavitKartiKolodaDelegat { }
extension SportivinieKartiSozdatKolodyCoo: SportivinieKartiYbratKartuKolodaDelegat { }
extension SportivinieKartiSozdatKolodyCoo: SportivinieKartiSortirovkaKartControllerDelegat { }
