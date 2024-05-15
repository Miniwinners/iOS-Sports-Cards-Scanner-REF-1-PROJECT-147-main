import UIKit

final class SportivinieKartiKartaKolodaCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

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

extension SportivinieKartiKartaKolodaCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiKolodaVC()
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

extension SportivinieKartiKartaKolodaCoo: YdalitKolodyePromptDelegat {
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

extension SportivinieKartiKartaKolodaCoo: CardDetailsCoordinatorDelegate {
    func cardDetailsCoordinatorCardYbrana(_ coordinator: SportivinieKartiDetailCardCoo, from viewController: SportivinieKartiCardOwnVCDetail) {
        router.ischeznytUnicalno(viewController, animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiKartaKolodaCoo: SportivinieKartiSodatIzmenitDelegat { }
extension SportivinieKartiKartaKolodaCoo: KartaKolodaDelegat { }
extension SportivinieKartiKartaKolodaCoo: SportivinieKartiDobavitKartiKolodaDelegat { }
extension SportivinieKartiKartaKolodaCoo: SportivinieKartiYbratKartuKolodaDelegat { }
extension SportivinieKartiKartaKolodaCoo: SportivinieKartiSortirovkaKartVcDelegat { }