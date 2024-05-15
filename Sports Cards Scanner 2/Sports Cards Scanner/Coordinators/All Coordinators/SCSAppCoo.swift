import UIKit

final class SportivinieKartiAppCoo: NSObject {

    var children: [SportivinieKartiCoo] = []
    let router: SportivinieKartiGlavniiRouterPrilozhania

    private let authService: SportivinieKartiAuthenticationSc
    private lazy var alertService: SportivinieKartiAlertSc = .shared

    private weak var authenticatedUserController: UITabBarController?

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

extension SportivinieKartiAppCoo: SportivinieKartiCoo {
    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?) {
        predstavitNachalniiVid()

        pokazatProverkyInterneta()
    }

    func ischeznytPolnostuu(animated: Bool) {
        SportivinieKartiAuthStateManager.shared.otpisPodAuthStatus(self)
        router.ischeznytPolnostuu(animated: animated)
    }

}

extension SportivinieKartiAppCoo: SportivinieKartiCCD {
    func proverkaInternetaZagryzka(_ viewController: SportivinieKartiCCVC) {
        predstavitNachalniiVid()
        SportivinieKartiAuthStateManager.shared.podpisPodAuthStatus(self) { [weak self] _, user in
            SportivinieKartiProfileManager.shared.postavitIDPolzovatelya(user?.uid)

            self?.children.removeAll()
            if user == nil {
                self?.predstavitVhod()
            } else {
                self?.pokazatAftorizirovanii()
            }
        }
    }
}
extension SportivinieKartiAppCoo: SportivinieKartiSignInD {
    func vhodNazhataKnopkaRegistracii(_ viewController: SportivinieKartiVhodVC) {

        vhodRegistracia()
    }

    func vhodUserVoshel(_ viewController: SportivinieKartiVhodVC) {

        predstavitVidBezZagryzki()
    }

    func vhodNazhataZabilParol(_ viewController: SportivinieKartiVhodVC) {

        predstavitZabilParol(in: viewController)
    }
}

extension SportivinieKartiAppCoo: SportivinieKartiSignUpD {
    func vhodVhodNazhata(_ viewController: SportivinieKartiRegistraciaVhodVC) {

        predstavitVhod()
    }

    func registraciaUserZaregalcya(_ viewController: SportivinieKartiRegistraciaVhodVC) {

        predstavitVidBezZagryzki()
    }
}

extension SportivinieKartiAppCoo: SportivinieKartiEsheDelegat {
    func esheNazhalShtuku(_ item: SportivinieKartiProfilShtuka, in viewController: SportivinieKartiEsheVC) {
        switch item {
        case .cardCategories:
            let router = SportivinieKartiMNavR(parentViewController: viewController)
            let coordinator = SportivinieKartiCardCategoryCoo(router: router)
            predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)

        case .updatePassword:
            let router = SportivinieKartiMNavR(parentViewController: viewController)
            let coordinator = SportivinieKartiUpdatePSWDCoo(router: router, authService: authService)
            predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)

        case .privacyPolicy, .termsAndConditions:
            pokazatGoogleWebStranicy()
        case .pushNotifications:
            break

        case .logout:
            pokazatVihodprompt(from: viewController)

        case .deleteAccount:
            pokazatYdalitAkkayntPromt(from: viewController)
        }
    }
}

extension SportivinieKartiAppCoo: SportivinieKartiDoskaDelegat {
    func doskaScannerNazhat(_ viewController: SportivinieKartiDoskaVC) {

        predstavitScannerKarti(from: viewController)
    }

    func doskaDetaliKartiNazhata(card: SportivinieKartiKartaPredstavlenie, in viewController: SportivinieKartiDoskaVC) {
        predstavitDetaliKarti(of: card, from: viewController)
    }

    func doskaTekushaaCenaDiscloseNazhata(_ viewController: SportivinieKartiDoskaVC) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiCurrentValueCoo(router: router)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func doskaNaibolshaiaCenaDiscloseNazhata(_ viewController: SportivinieKartiDoskaVC) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiHighValueCoo(router: router)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func doskaNedavnoDobavlenieDiscloseNazhata(_ viewController: SportivinieKartiDoskaVC) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiRecentCoo(router: router)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }
}

extension SportivinieKartiAppCoo: SportivinieKartiPortfolioDelegat {
    func portfolioKolodaPodpis(_ viewController: SportivinieKartiPortfolioVC) {

    }

    func portfolioSkanirovanieKarti(_ viewController: SportivinieKartiPortfolioVC) {

        predstavitScannerKarti(from: viewController)
    }

    func portolioSozdatKollekciuNazhata(_ viewController: SportivinieKartiPortfolioVC) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiSozdatKolleciuCoo(router: router)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func portfolioSozdatKolodyNazhata(_ viewController: SportivinieKartiPortfolioVC) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiSozdatKolodyCoo(router: router)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func portfolioPokazatKollekciuNazhata(_ viewController: SportivinieKartiPortfolioVC) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiKartaKollekciaCoo(router: router)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func portfolioPokazatKolodyNazhata(_ viewController: SportivinieKartiPortfolioVC) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiKartaKolodaCoo(router: router)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func portfolioKategoriiNazhata(_ category: KategoriiKart, in viewController: SportivinieKartiPortfolioVC) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiCategoryCoo(router: router, category: category)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }
}

private extension SportivinieKartiAppCoo {

    func predstavitNachalniiVid() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .backColor
        router.poyavitsaUnicalno(viewController, animated: false)
    }

    func pokazatProverkyInterneta() {
        SportivinieKartiAuthStateManager.shared.otpisPodAuthStatus(self)
        let checkConnectionVC = SportivinieKartiCCVC()
        checkConnectionVC.delegate = self
        router.poyavitsaUnicalno(checkConnectionVC, animated: true)
    }

    func predstavitVhod() {
        let signInViewController = SportivinieKartiVhodVC(authService: authService)
        signInViewController.delegate = self
        router.poyavitsaUnicalno(signInViewController, animated: true)
    }

    func pokazatAftorizirovanii() {
        let dashboardViewController = SportivinieKartiDoskaVC()
        dashboardViewController.delegate = self

        let portfolioViewController = SportivinieKartiPortfolioVC()
        portfolioViewController.delegate = self

        let moreViewController = SportivinieKartiEsheVC(authService: authService)
        moreViewController.delegate = self

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([dashboardViewController, portfolioViewController, moreViewController], animated: false)
        postavidOsnovnoiTabBar(tabBarController.tabBar)
        tabBarController.setupVidTabBAR()
        authenticatedUserController = tabBarController

        self.router.poyavitsaUnicalno(tabBarController, animated: true)

    }

    func predstavitVidBezZagryzki() {
        let dashboardViewController = SportivinieKartiDoskaVC()
        dashboardViewController.delegate = self

        let portfolioViewController = SportivinieKartiPortfolioVC()
        portfolioViewController.delegate = self

        let moreViewController = SportivinieKartiEsheVC(authService: authService)
        moreViewController.delegate = self

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([dashboardViewController, portfolioViewController, moreViewController], animated: false)
        postavidOsnovnoiTabBar(tabBarController.tabBar)
        tabBarController.setupVidTabBAR()
        authenticatedUserController = tabBarController

        router.poyavitsaUnicalno(tabBarController, animated: true)
    }

    func vhodRegistracia() {
        let signUpViewController = SportivinieKartiRegistraciaVhodVC(authService: authService)
        signUpViewController.delegate = self
        router.poyavitsaUnicalno(signUpViewController, animated: true)
    }

    func predstavitZabilParol(in viewController: UIViewController) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let forgotPasswordCoordinator = SportivinieKartiForgotPSWDCoo(router: router, authService: authService)
        predstavitDocherniiCoo(forgotPasswordCoordinator, animated: true, onDismissed: nil)
    }

    func pokazatGoogleWebStranicy() {
        guard let googleURL = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(googleURL)
    }

    func predstavitScannerKarti(from viewController: UIViewController) {
        let router = SportivinieKartiModalPR(parentViewController: viewController, presentStyle: .common)
        let coordinator = SportivinieKartiScanirovaineCoo(router: router)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func predstavitDetaliKarti(of card: SportivinieKartiKartaPredstavlenie, from viewController: UIViewController) {
        let router = SportivinieKartiMNavR(parentViewController: viewController)
        let coordinator = SportivinieKartiDetailCardCoo(router: router, card: card, previousVC: .common, sample: nil)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func pokazatVihodprompt(from viewController: UIViewController) {
        let router = SportivinieKartiDASR(parentViewController: viewController, presentStyle: .center, heightRatio: UIDevice.isIphone ? 260:360, widthRatio: UIDevice.isIphone ? 335:580)
        let coordinator = SportivinieKartiLogoutCoo(router: router, authService: authService)
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func pokazatYdalitAkkayntPromt(from viewController: UIViewController) {
        let router = SportivinieKartiDASR(parentViewController: viewController, presentStyle: .center, heightRatio: UIDevice.isIphone ? 280:380, widthRatio: UIDevice.isIphone ? 335:580)
        let coordinator = SportivinieKartiDeleteAccCoo(router: router, authService: authService)
        coordinator.onDeletingFailed = { [weak self] error in
            guard error.asAuthError.code == .requiresRecentLogin else { return }
            self?.pokasatRequiedNedavniiLogin(from: viewController)
        }
        predstavitDocherniiCoo(coordinator, animated: true, onDismissed: nil)
    }

    func pokasatRequiedNedavniiLogin(from viewController: UIViewController) {
//        let alertType: SportivinieKartitipAlerta = .needRecentLogin { [weak self] _, _ in
//            try? self?.authService.podgotovitVihod()
//        }
//        alertService.podgotovitAlertController(type: alertType, in: viewController)
    }

    // MARK: - Helpers

    func postavidOsnovnoiTabBar(_ tabBar: UITabBar) {
        tabBar.primenitVid()
        zip(tabBar.items ?? [], SportivinieKartiTabBarShtuka.allCases).forEach {
            $0.image = $1.image
            $0.selectedImage = $1.selectedImage
            $0.imageInsets = UIEdgeInsets(top: UIDevice.isIpad ? -30: -5, left: 0, bottom: 0, right: 0)
        }
    }
}
