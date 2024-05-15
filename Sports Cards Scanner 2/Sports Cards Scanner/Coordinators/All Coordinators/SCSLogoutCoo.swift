import UIKit

final class SportivinieKartiLogoutCoo {
    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    private let authService: SportivinieKartiAuthenticationSc

    init(router: SportivinieKartiGlavniiRouterPrilozhania, authService: SportivinieKartiAuthenticationSc) {
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
        let viewController = SportivinieKartiDAVC(description: L10n.Prompt.Logout.description, styleButton: .delete)
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

extension SportivinieKartiLogoutCoo: SportivinieKartiDAVCD {
    func promptViewControllerotmenaNazhata(_ viewController: SportivinieKartiDAVC) {
        try? authService.podgotovitVihod()
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
enum UnicalniEnumFour {
    case one
    case two
    case three
}
