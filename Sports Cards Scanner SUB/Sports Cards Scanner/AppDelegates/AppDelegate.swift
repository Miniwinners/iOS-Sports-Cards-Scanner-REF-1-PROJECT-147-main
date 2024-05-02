import UIKit
import FirebaseCore
import Pushwoosh
import Adjust

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkStatusMonitor.shared.startMonitoring()
//        ThirdPartyServicesManager.shared.initializeAdjust_unique()
//        ThirdPartyServicesManager.shared.initializePushwoosh_unique(delegate: self)
//        ThirdPartyServicesManager.shared.initializeInApps_unique()

        FirebaseApp.configure()
        configureManagers()
//        configurePushwoosh()
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

    func configurePushwoosh() {
        Pushwoosh.sharedInstance().delegate = self
        PushNotificationManager.initialize(withAppCode: SCSConfigurations.pushwooshToken, appName: SCSConfigurations.pushwooshAppName)
        PWInAppManager.shared().resetBusinessCasesFrequencyCapping()
        PWGDPRManager.shared().showGDPRDeletionUI()
        Pushwoosh.sharedInstance().registerForPushNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

extension AppDelegate: PWMessagingDelegate {
    // handle token received from APNS
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        Adjust.setDeviceToken(deviceToken)
        Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
    }

    // handle token receiving error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        Pushwoosh.sharedInstance().handlePushRegistrationFailure(error)
    }

    // this is for iOS < 10 and for silent push notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
    }

    // this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        print("onMessageReceived: ", message.payload?.description ?? "error")
    }

    // this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageOpened message: PWMessage) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        print("onMessageOpened: ", message.payload?.description ?? "error")
    }
}
