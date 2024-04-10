import UIKit

final class SCSAppCoordinator: NSObject {

    var children: [SCSCoordinator] = []
    let router: SCSRouter

    private let authService: AuthService
    private lazy var alertService: AlertService = .shared

    private weak var authenticatedUserController: UITabBarController?

    init(router: SCSRouter, authService: AuthService) {
        self.router = router
        self.authService = authService
    }
}

extension SCSAppCoordinator: SCSCoordinator {
    func presentInitialState(animated: Bool, onDismissed: Closure?) {
        presentInitialView()

        AuthStateManager.shared.subscribeForAuthState(self) { [weak self] _, user in
            ProfileManager.shared.setUserID(user?.uid)

            self?.children.removeAll()
            if user == nil {
                self?.presentSignIn()
            } else {
                self?.presentAuthenticated()
            }
        }
    }

    func dismissFully(animated: Bool) {
        AuthStateManager.shared.unsubscribeForAuthState(self)
        router.dismissFully(animated: animated)
    }
}

extension SCSAppCoordinator: SignInViewControllerDelegate {
    func signInViewControllerDidPressSignUp(_ viewController: SCSSignInVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        presentSignUp()
    }

    func signInViewControllerUserSignedIn(_ viewController: SCSSignInVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        presentAuthenticated()
    }

    func signInViewControllerDidPressForgotPassword(_ viewController: SCSSignInVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        presentForgotPassword(in: viewController)
    }
}

extension SCSAppCoordinator: SignUpViewControllerDelegate {
    func signUpViewControllerDidPressSignIn(_ viewController: SCSSignUpVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        presentSignIn()
    }

    func signUpViewControllerUserSignedUp(_ viewController: SCSSignUpVC) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        presentAuthenticated()
    }
}

extension SCSAppCoordinator: MoreViewControllerDelegate {
    func moreViewControllerDidPressItem(_ item: ProfileItem, in viewController: MoreViewController) {
        switch item {
        case .cardCategories:
            let router = SCSModalNavigationRouter(parentViewController: viewController)
            let coordinator = CardCategoriesCoordinator(router: router)
            presentChildCoordinator(coordinator, animated: true, onDismissed: nil)

        case .updatePassword:
            let router = SCSModalNavigationRouter(parentViewController: viewController)
            let coordinator = UpdatePasswordCoordinator(router: router, authService: authService)
            presentChildCoordinator(coordinator, animated: true, onDismissed: nil)

        case .privacyPolicy, .termsAndConditions:
            presentGoogleWebPage()

        case .pushNotifications:
            break

        case .logout:
            presentLogoutPrompt(from: viewController)

        case .deleteAccount:
            presentDeleteAccountPrompt(from: viewController)
        }
    }
}

extension SCSAppCoordinator: DashboardViewControllerDelegate {
    func dashboardViewControllerScanCardTapped(_ viewController: DashboardViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        presentScanCard(from: viewController)
    }

    func dashboardViewControllerCardDetailsTapped(card: CardRepresentable, in viewController: DashboardViewController) {
        presentCardDetails(of: card, from: viewController)
    }

    func dashboardViewControllerDiscloseCurrentValueTapped(_ viewController: DashboardViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = CurrentValueDetailsCoordinator(router: router)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func dashboardViewControllerDiscloseHighestValueTapped(_ viewController: DashboardViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = HighestValueListCoordinator(router: router)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func dashboardViewControllerDiscloseRecentlyAddedTapped(_ viewController: DashboardViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = RecentlyAddedListCoordinator(router: router)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }
}

extension SCSAppCoordinator: PortfolioViewControllerDelegate {
    func portfolioViewControllerScanCardTapped(_ viewController: PortfolioViewController) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        presentScanCard(from: viewController)
    }

    func portfolioViewControllerCreateCollectionTapped(_ viewController: PortfolioViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = CreateCardCollectionCoordinator(router: router)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func portfolioViewControllerCreateDeckTapped(_ viewController: PortfolioViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = CreateCardDeckCoordinator(router: router)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func portfolioViewControllerShowCollectionTapped(_ viewController: PortfolioViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = CardCollectionCoordinator(router: router)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func portfolioViewControllerShowDeckTapped(_ viewController: PortfolioViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = CardDeckCoordinator(router: router)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func portfolioViewControllerCategoryTapped(_ category: CardCategory, in viewController: PortfolioViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = CategoryCardsCoordinator(router: router, category: category)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }
}

private extension SCSAppCoordinator {
    func presentInitialView() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .backColor
        router.present_unique(viewController, animated: false)
    }

    func presentSignIn() {
        let signInViewController = SCSSignInVC(authService: authService)
        signInViewController.delegate = self
        router.present_unique(signInViewController, animated: true)
    }

    func presentAuthenticated() {
        let dashboardViewController = DashboardViewController()
        dashboardViewController.delegate = self

        let portfolioViewController = PortfolioViewController()
        portfolioViewController.delegate = self

        let moreViewController = MoreViewController(authService: authService)
        moreViewController.delegate = self

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([dashboardViewController, portfolioViewController, moreViewController], animated: false)
        setupMainTabBar(tabBarController.tabBar)

        authenticatedUserController = tabBarController

        router.present_unique(tabBarController, animated: true)
    }

    func presentSignUp() {
        let signUpViewController = SCSSignUpVC(authService: authService)
        signUpViewController.delegate = self
        router.present_unique(signUpViewController, animated: true)
    }

    func presentForgotPassword(in viewController: UIViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let forgotPasswordCoordinator = ForgotPasswordCoordinator(router: router, authService: authService)
        presentChildCoordinator(forgotPasswordCoordinator, animated: true, onDismissed: nil)
    }

    func presentGoogleWebPage() {
        guard let googleURL = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(googleURL)
    }

    func presentScanCard(from viewController: UIViewController) {
        let router = ModalPresentationRouter(parentViewController: viewController)
        let coordinator = ScanCardCoordinator(router: router)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func presentCardDetails(of card: CardRepresentable, from viewController: UIViewController) {
        let router = SCSModalNavigationRouter(parentViewController: viewController)
        let coordinator = CardDetailsCoordinator(router: router, card: card)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func presentLogoutPrompt(from viewController: UIViewController) {
        let router = DeleteAccountSheetRouter(parentViewController: viewController)
        let coordinator = LogoutPromptCoordinator(router: router, authService: authService)
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func presentDeleteAccountPrompt(from viewController: UIViewController) {
        let router = DeleteAccountSheetRouter(parentViewController: viewController)
        let coordinator = DeleteAccountPromptCoordinator(router: router, authService: authService)
        coordinator.onDeletingFailed = { [weak self] error in
            guard error.asAuthError.code == .requiresRecentLogin else { return }
            self?.presentRequiredRecentLogin(from: viewController)
        }
        presentChildCoordinator(coordinator, animated: true, onDismissed: nil)
    }

    func presentRequiredRecentLogin(from viewController: UIViewController) {
        let alertType: SCSAlertType = .needRecentLogin { [weak self] _, _ in
            try? self?.authService.performSignOut()
        }
        alertService.presentAC(type: alertType, in: viewController)
    }

    // MARK: - Helpers

    func setupMainTabBar(_ tabBar: UITabBar) {
        tabBar.applyDefaultAppearance()

        zip(tabBar.items ?? [], TabBarItem.allCases).forEach {
            $0.image = $1.image
            $0.selectedImage = $1.selectedImage
            $0.title = $1.text

        }
    }
}
