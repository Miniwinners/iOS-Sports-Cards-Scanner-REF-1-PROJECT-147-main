import UIKit

final class SportivinieKartiYdalitKollekciuCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    private let cardCollectionManager: SportivinieKartiKartaKollekciaManger

    weak var delegate: DeleteCollectionDelegat?

    init(
        router: SportivinieKartiGlavniiRouterPrilozhania,
        cardCollectionManager: SportivinieKartiKartaKollekciaManger = SportivinieKartiKartaPostavitManager.shared
    ) {
        self.router = router
        self.cardCollectionManager = cardCollectionManager
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiYdalitKollekciuCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiDAVC(description: L10n.Prompt.DeleteCollection.description, styleButton: .delete)
        viewController.delegate = self
        viewController.cancelButton.setButtonTitle(L10n.Prompt.DeleteCollection.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Prompt.DeleteCollection.keepAction)
        router.poyavitsaUnicalno(viewController, animated: animated, onDismissed: onDismissed)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiYdalitKollekciuCoo: SportivinieKartiDAVCD {
    func promptViewControllerotmenaNazhata(_ viewController: SportivinieKartiDAVC) {
        cardCollectionManager.ydalitKollekciuKart()
        cardCollectionManager.sohranitKollekciuIFnado()
        delegate?.deleteCollectionPromptCoordinatorYdalitNazhata(self)
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

// MARK: - DeleteCollection Delegate

protocol DeleteCollectionDelegat: AnyObject {
    func deleteCollectionPromptCoordinatorYdalitNazhata(_ coordinator: SportivinieKartiYdalitKollekciuCoo)
}

enum UnicalniiYdalitKollekciuCoo {
    case ydalit
    case present
    case none
}
