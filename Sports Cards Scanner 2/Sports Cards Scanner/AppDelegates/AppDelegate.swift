import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        configureManagers()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}

private extension AppDelegate {
    func configureManagers() {
        CardCategoriesManager.setProfileManager(.shared)

        UserCardsManager.setProfileManager(.shared)
        UserCardsManager.setCategoriesManager(.shared)
        UserCardsManager.setCardSetsManager(CardSetsManager.shared)

        CardSetsManager.setCardsManager(.shared)
        CardSetsManager.setProfileManager(.shared)
    }
}
