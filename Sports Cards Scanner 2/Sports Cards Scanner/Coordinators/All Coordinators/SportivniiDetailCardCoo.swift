import UIKit

final class SportivinieKartiDetailCardCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania
    let card: SportivinieKartiKartaPredstavlenie
    let cardType: KartaType
    let encodedCardImage: Data?
    private var previousController: PreviousController
    weak var delegate: CardDetailsCoordinatorDelegate?

    private weak var cardDetailsViewController: SportivinieKartiCardOwnControllerDetail?
    private var scanCardViewController: SportivinieKartiScanirovanieKartiController?

    init(
        router: SportivinieKartiGlavniiRouterPrilozhania,
        card: SportivinieKartiKartaPredstavlenie,
        cardType: KartaType = .addedCard,
        encodedCardImage: Data? = nil,
        previousController: PreviousController,
        sample: SportivinieKartiScanirovanieKartiController? = nil

    ) {
        self.router = router
        self.card = card
        self.cardType = cardType
        self.encodedCardImage = encodedCardImage
        self.previousController = previousController
        self.scanCardViewController = sample
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiDetailCardCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiCardOwnControllerDetail(card: card, cardType: cardType, encodedCardImage: encodedCardImage, previousController: previousController, locked: true)
        viewController.delegate = self
        router.poyavitsaUnicalno(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension SportivinieKartiDetailCardCoo: SearchCardCoordinatorDelegate {
    func searchCardCoordinatorKartadDobavlena(_ coordinator: SportivinieKartiPoiskCardCoo) {

        router.ischeznytPolnostuu(animated: true)
    }
}

extension SportivinieKartiDetailCardCoo: SportivinieKartiCardOwnControllerDetailDelegate {
    func izmenitKartyPodbischik(_ viewController: SportivinieKartiCardOwnControllerDetail) {

    }

    func cardDetailsViewControllerzakrtiNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail) {

        router.ischeznytPolnostuu(animated: true)
    }

    func zakritPoslePoiska(_ viewController: SportivinieKartiCardOwnControllerDetail) {

        router.ischeznytPolnostuu(animated: true)
        scanCardViewController?.restartScanning()
    }

    func nazadNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail) {
        router.ischeznytUnicalno(viewController, animated: true)
    }

    func graderNazhat(_ viewController: SportivinieKartiCardOwnControllerDetail) {
        let inset: CGFloat = UIDevice.isIpad ? 160:40

        let router = SportivinieKartiDASR(parentViewController: viewController, presentStyle: .centerRect,
                                              heightRatio: UIDevice.isIpad ? 360:260,
                                              widthRatio: viewController.view.frame.width - inset)
        let coordinator = SportivinieKartiGraderCoo(router: router, card: viewController.card)
        coordinator.didSelectGrader = { [unowned viewController] grader in
            viewController.gradeDidVibrana(grader)
        }
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func cenaObzorNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail) {
        let viewController = SportivinieKartiCenaOcenkaController(
            card: viewController.card,
            grader: viewController.selectedGrader,
            encodedCardImage: viewController.encodedCardImage
        )
        router.poyavitsaUnicalno(viewController, animated: true)

    }

    func izmenitKartuNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail) {
        let cardsUpdater: SportivinieKartiKartUpdater
        if viewController.card is SportivinieKartipoiskanieKarti {
            cardsUpdater = viewController.searchedCardsManager
        } else {
            cardsUpdater = SportivinieKartiUserKartManager.shared
        }

        let viewController = SportivinieKartiIzmenitKartuController(card: viewController.card, cardsManager: cardsUpdater)
        viewController.delegate = self
        router.poyavitsaUnicalno(viewController, animated: true)
    }

    func naitiKartyNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail) {
        let encodedCardImage = viewController.encodedCardImage ?? Data()
        let cardCategory = viewController.card.category
        let scannedCard = SportivinieKartiScanirovannayaKarta(encodedCardImage: encodedCardImage, cardCategory: cardCategory)

        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiPoiskCardCoo(router: router, card: scannedCard, sample: nil)
        coordinator.delegate = self
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func kartaDobavlenaNazhata(_ viewController: SportivinieKartiCardOwnControllerDetail) {
        if let delegate = delegate {
            delegate.cardDetailsCoordinatorKartaDobavlena(self, from: viewController)
        } else {
            router.ischeznytPolnostuu(animated: true)
        }
    }

    func ybratKartyNazhata(_ card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiCardOwnControllerDetail) {
        cardDetailsViewController = viewController
        let inset: CGFloat = UIDevice.isIpad ? 140:40
        let router = SportivinieKartiDASR(parentViewController: viewController, presentStyle: .center, heightRatio: UIDevice.isIpad ? 380: 330, widthRatio: viewController.view.frame.width - inset)
        let coordinator = SportivinieKartiRemoveCoo(router: router, card: card)
        coordinator.delegate = self
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }
}

extension SportivinieKartiDetailCardCoo: SportivinieKartiIzmenitKartuDelegat {
    func editCardViewParallelNazhata(_ viewController: SportivinieKartiIzmenitKartuController) {
        let parallels = viewController.card.parallels
        let selectedParallelIndex = viewController.selectedParallelIndex

        let parallelSelectionViewController = SportivinieKartiParallelViborController(parallels: parallels, selected: selectedParallelIndex)
        parallelSelectionViewController.parallelDidSelect = { [unowned parallelSelectionViewController, unowned router] index in
            viewController.obnovitVibraniyIndex(index)
            router.ischeznytUnicalno(parallelSelectionViewController, animated: true)
        }
        router.poyavitsaUnicalno(parallelSelectionViewController, animated: true)
    }

    func editCardViewGradeNazhata(_ viewController: SportivinieKartiIzmenitKartuController) {
        let selectedGrader = viewController.selectedGrader
        let selectedGrade = viewController.selectedGrade

        let gradeSelectionViewController = SportivinieKartiGradeViborController(grader: selectedGrader, grade: selectedGrade)
        gradeSelectionViewController.gradeDidSelect = { [unowned gradeSelectionViewController, unowned router] grader, grade in
            viewController.obnovitVibraniiGrade(grader: grader, grade: grade)
            router.ischeznytUnicalno(gradeSelectionViewController, animated: true)
        }
        router.poyavitsaUnicalno(gradeSelectionViewController, animated: true)
    }

    func editCardViewControllerDetaliObnovleni(_ viewController: SportivinieKartiIzmenitKartuController) {
        router.ischeznytUnicalno(viewController, animated: true)
    }
}

extension SportivinieKartiDetailCardCoo: RemoveCardPromptCoordinatorDelegate {
    func removeCardPromptCoordinatorCardYbrana(_ coordinator: SportivinieKartiRemoveCoo) {
        if let delegate = delegate {
            guard let viewController = cardDetailsViewController else { return }
            delegate.cardDetailsCoordinatorCardYbrana(self, from: viewController)
        } else {
            router.ischeznytPolnostuu(animated: true)
        }
    }

    func removeCardPromptCoordinatorYbranaOshibka(_ coordinator: SportivinieKartiRemoveCoo) {
        guard let viewController = cardDetailsViewController else { return }
        let alertType: SportivinieKartitipAlerta = .noInternetConnection(okAction: nil)
        SportivinieKartiAlertService.shared.podgotovitAlertController(type: alertType, in: viewController)
    }
}

// MARK: - CardDetails Coordinator Delegate

protocol CardDetailsCoordinatorDelegate: AnyObject {
    func cardDetailsCoordinatorKartaDobavlena(_ coordinator: SportivinieKartiDetailCardCoo, from viewController: SportivinieKartiCardOwnControllerDetail)
    func cardDetailsCoordinatorCardYbrana(_ coordinator: SportivinieKartiDetailCardCoo, from viewController: SportivinieKartiCardOwnControllerDetail)
}

extension CardDetailsCoordinatorDelegate where Self: SportivinieKartiCoo {
    func cardDetailsCoordinatorKartaDobavlena(_ coordinator: SportivinieKartiDetailCardCoo, from viewController: SportivinieKartiCardOwnControllerDetail) {
        router.ischeznytPolnostuu(animated: true)
    }

    func cardDetailsCoordinatorCardYbrana(_ coordinator: SportivinieKartiDetailCardCoo, from viewController: SportivinieKartiCardOwnControllerDetail) {
        router.ischeznytPolnostuu(animated: true)
    }
}
