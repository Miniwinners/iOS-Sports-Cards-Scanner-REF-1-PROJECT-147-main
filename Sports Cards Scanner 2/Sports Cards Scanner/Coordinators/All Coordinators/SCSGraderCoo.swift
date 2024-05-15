import UIKit

final class SportivinieKartiGraderCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    var didSelectGrader: ((SportivinieKartiKartaGrader) -> Void)?

    let card: SportivinieKartiKartaPredstavlenie

    init(router: SportivinieKartiGlavniiRouterPrilozhania, card: SportivinieKartiKartaPredstavlenie) {
        self.router = router
        self.card = card
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiGraderCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        var graders = card.graders
        if !graders.contains(card.selectedGrader) {
            graders.append(card.selectedGrader)
        }

        let viewController = SportivinieKartiGraderViborVc(graders: graders)
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

extension SportivinieKartiGraderCoo: SportivinieKartiGraderViborDelegat {
    func graderSelectionViewControllerotmenaNazhata(_ viewController: SportivinieKartiGraderViborVc) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func graderSelectionViewControllerVibrana(grader: SportivinieKartiKartaGrader, in viewController: SportivinieKartiGraderViborVc) {
        router.ischeznytPolnostuu(animated: true)
        didSelectGrader?(grader)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}
