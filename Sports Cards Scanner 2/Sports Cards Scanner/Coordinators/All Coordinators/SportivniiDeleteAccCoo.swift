import UIKit

final class SportivinieKartiDeleteAccCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    private let authService: SportivinieKartiAuthenticationService
    private let profileManager: SportivinieKartiProfileManager
    private let cardPhotoService: SportivinieKartiPhotoKartiService

    private var isDeleteAccountInProcess = false

    var onDeletingFailed: ((Error) -> Void)?

    init(
        router: SportivinieKartiGlavniiRouterPrilozhania,
        authService: SportivinieKartiAuthenticationService,
        profileManager: SportivinieKartiProfileManager = .shared,
        cardPhotoService: SportivinieKartiPhotoKartiService = .init()
    ) {
        self.router = router
        self.authService = authService
        self.profileManager = profileManager
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

extension SportivinieKartiDeleteAccCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiYdalitAccountController(description: L10n.Prompt.DeleteAccount.description, styleButton: .delete)
        viewController.cancelButton.setButtonTitle(L10n.Prompt.DeleteAccount.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Prompt.DeleteAccount.keepAction)
        viewController.delegate = self
        router.poyavitsaUnicalno(viewController, animated: animated, onDismissed: onDismissed)
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
    }

}

extension SportivinieKartiDeleteAccCoo: ViewSportivnieYdalitAccaountDelegat {
    func promptViewControllerotmenaNazhata(_ viewController: SportivinieKartiYdalitAccountController) {

        viewController.isModalInPresentation = true
        viewController.cancelButton.isLoading = true
        isDeleteAccountInProcess = true

        Task { @MainActor in
            defer {
                viewController.isModalInPresentation = false
                viewController.cancelButton.isLoading = false
                isDeleteAccountInProcess = false
            }

            do {
                try await authService.ydalitAkkayntUsera()
                try await cardPhotoService.ydalitVsePhoto()
                try await profileManager.ydalitDatyProfil()
            } catch {
                var strongSelf: SportivinieKartiDeleteAccCoo! = self
                router.ischeznytPolnostuu(animated: true) {
                    strongSelf.onDeletingFailed?(error)
                    strongSelf = nil
                }
            }
        }
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        try? self.authService.podgotovitVihod()

    }

    func promptViewControllerPodtverditYdalitNazhata(_ viewController: SportivinieKartiYdalitAccountController) {
        if isDeleteAccountInProcess { return }
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
    }
}

enum UnicalniEnumThree {
    case one
    case two
    case three
}
