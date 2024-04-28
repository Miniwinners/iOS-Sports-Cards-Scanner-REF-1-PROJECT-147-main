import UIKit
import FirebaseCore
import Adjust
import Pushwoosh
 @main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        configureManagers()
        NetworkMonitoringService.shared.startNetworkMonitoring()
        ServicesManager.shared.initializeAdjust()
        ServicesManager.shared.initializePushwoosh(delegate: self)
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

extension AppDelegate: PWMessagingDelegate {

    // handle token received from APNS
    func application(_ application: UIApplication, DidRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Adjust.setDeviceToken(deviceToken)
        Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
    }

    // обработка ошибки получения токена
    func application(_ application: UIApplication, DidFailToRegisterForRemoteNotificationsWithError error: Error) {
        Pushwoosh.sharedInstance().handlePushRegistrationFailure(error)
    }

    // for iOS < 10 and quiet push-notification
    func application(_ application: UIApplication, DidReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
    }

// this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        print("onMessageReceived: ", message.payload?.description ?? "error")
    }

    // this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageOpened message: PWMessage) {
        print("onMessageOpened: ", message.payload?.description ?? "error")
    }
}
