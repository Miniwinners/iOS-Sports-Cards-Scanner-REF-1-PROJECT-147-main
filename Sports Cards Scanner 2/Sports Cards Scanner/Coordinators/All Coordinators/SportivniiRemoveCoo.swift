import UIKit

final class SportivinieKartiRemoveCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    weak var delegate: RemoveCardPromptCoordinatorDelegate?

    private let card: SportivinieKartiKartaPredstavlenie

    private let cardsManager: SportivinieKartiUserKartManager
    private let cardPhotoService: SportivinieKartiPhotoKartiSc

    private var isRemoveCardInProcess = false

    init(
        router: SportivinieKartiGlavniiRouterPrilozhania,
        card: SportivinieKartiKartaPredstavlenie,
        cardsManager: SportivinieKartiUserKartManager = .shared,
        cardPhotoService: SportivinieKartiPhotoKartiSc = .init()
    ) {
        self.router = router
        self.card = card
        self.cardsManager = cardsManager
        self.cardPhotoService = cardPhotoService
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiRemoveCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiDAVC(description: L10n.Prompt.RemoveCard.description, styleButton: .delete)
        viewController.cancelButton.setButtonTitle(L10n.Prompt.RemoveCard.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Prompt.RemoveCard.keepAction)
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

extension SportivinieKartiRemoveCoo: SportivinieKartiDAVCD {
    func promptViewControllerotmenaNazhata(_ viewController: SportivinieKartiDAVC) {
        guard SportivinieKartiInternetSoedinenieSc.shared.isNetworkAvailable else {
            router.ischeznytPolnostuu(animated: true)
            delegate?.removeCardPromptCoordinatorYbranaOshibka(self)
            return
        }

        viewController.isModalInPresentation = true
        viewController.cancelButton.isLoading = true
        isRemoveCardInProcess = true

        Task { @MainActor in
            defer {
                viewController.isModalInPresentation = false
                viewController.cancelButton.isLoading = false
                isRemoveCardInProcess = false
            }

            cardsManager.ybratKartyUsera(card)
            cardsManager.sohranitKartiEsliNado()
            try? await cardPhotoService.ybratPhoto(named: card.id)

            router.ischeznytPolnostuu(animated: true)

            delegate?.removeCardPromptCoordinatorCardYbrana(self)
        }
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func promptViewControllerPodtverditYdalitNazhata(_ viewController: SportivinieKartiDAVC) {
        if isRemoveCardInProcess { return }
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

// MARK: - Remove Card Delegate

protocol RemoveCardPromptCoordinatorDelegate: AnyObject {
    func removeCardPromptCoordinatorCardYbrana(_ coordinator: SportivinieKartiRemoveCoo)
    func removeCardPromptCoordinatorYbranaOshibka(_ coordinator: SportivinieKartiRemoveCoo)
}
enum UnicalniEnumNine {
    case one
    case two
    case three
}
