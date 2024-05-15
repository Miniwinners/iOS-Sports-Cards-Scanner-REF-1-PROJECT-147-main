import UIKit

final class SportivinieKartiForgotPSWDCoo: SportivinieKartiCoo {
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

    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        let forgotPasswordViewController = SportivinieKartiFPVC(authService: authService)
        forgotPasswordViewController.delegate = self
        router.poyavitsaUnicalno(forgotPasswordViewController, animated: animated, onDismissed: onDismissed)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiForgotPSWDCoo: SportivinieKartiFPVD {
    func zabilParol(emailSentTo email: String, from viewController: SportivinieKartiFPVC) {
        let resetPasswordViewController = SportivinieKartiRPVC(email: email)
        resetPasswordViewController.delegate = self
        router.poyavitsaUnicalno(resetPasswordViewController, animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func forgotPasswordViewControllerzakrtiNazhata(_ viewController: SportivinieKartiFPVC) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}

extension SportivinieKartiForgotPSWDCoo: SportivinieKartiRPVCD {
    func resetPasswordViewControllerzakrtiNazhata(_ viewController: SportivinieKartiRPVC) {
        router.ischeznytPolnostuu(animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}
