import UIKit

final class SportivinieKartiYdalitKolodyCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    private let cardDeckManager: SportivinieKartiCardDeckManager

    weak var delegate: YdalitKolodyePromptDelegat?

    init(
        router: SportivinieKartiGlavniiRouterPrilozhania,
        cardDeckManager: SportivinieKartiCardDeckManager = SportivinieKartiKartaPostavitManager.shared
    ) {
        self.router = router
        self.cardDeckManager = cardDeckManager
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiYdalitKolodyCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiDAVC(description: L10n.Prompt.DeleteDeck.description, styleButton: .delete)
        viewController.delegate = self
        viewController.cancelButton.setButtonTitle(L10n.Prompt.DeleteDeck.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Prompt.DeleteDeck.keepAction)
        router.poyavitsaUnicalno(viewController, animated: animated, onDismissed: onDismissed)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiYdalitKolodyCoo: SportivinieKartiDAVCD {
    func promptViewControllerotmenaNazhata(_ viewController: SportivinieKartiDAVC) {
        cardDeckManager.ydalitKolodyKart()
        cardDeckManager.sohranitKolodyEsliNado()
        delegate?.deleteDeckPromptCoordinatorYdalitNazhata(self)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func promptViewControllerPodtverditYdalitNazhata(_ viewController: SportivinieKartiDAVC) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

// MARK: - DeleteDeck Delegate

protocol YdalitKolodyePromptDelegat: AnyObject {
    func deleteDeckPromptCoordinatorYdalitNazhata(_ coordinator: SportivinieKartiYdalitKolodyCoo)
}
