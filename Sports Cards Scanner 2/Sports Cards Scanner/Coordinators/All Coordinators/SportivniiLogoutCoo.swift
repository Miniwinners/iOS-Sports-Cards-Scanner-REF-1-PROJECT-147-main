import UIKit

final class SportivinieKartiLogoutCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    private let authService: SportivinieKartiAuthenticationService

    init(router: SportivinieKartiGlavniiRouterPrilozhania, authService: SportivinieKartiAuthenticationService) {
        self.router = router
        self.authService = authService
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}

extension SportivinieKartiLogoutCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let viewController = SportivinieKartiYdalitAccountController(description: L10n.Prompt.Logout.description, styleButton: .logOut)
        viewController.cancelButton.setButtonTitle(L10n.Prompt.Logout.confirmAction)
        viewController.confirmButton.setButtonTitle(L10n.Prompt.DeleteAccount.keepAction)
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

extension SportivinieKartiLogoutCoo: ViewSportivnieYdalitAccaountDelegat {
    func promptViewControllerotmenaNazhata(_ viewController: SportivinieKartiYdalitAccountController) {
        try? authService.podgotovitVihod()
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func promptViewControllerPodtverditYdalitNazhata(_ viewController: SportivinieKartiYdalitAccountController) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}
enum UnicalniEnumFour {
    case one
    case two
    case three
}
