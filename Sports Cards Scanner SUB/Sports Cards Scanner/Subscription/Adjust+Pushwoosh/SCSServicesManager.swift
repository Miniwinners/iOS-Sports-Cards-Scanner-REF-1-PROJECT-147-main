import UIKit
import Adjust
import Pushwoosh
import AppTrackingTransparency
import AdSupport

class ThirdPartyServicesManager {
    static let shared = ThirdPartyServicesManager()
    
    func initializeAdjust_unique() {
        let yourAppToken = SCSConfigurations.adjustToken
        #if DEBUG
        let environment = ADJEnvironmentSandbox
        #else
        let environment = ADJEnvironmentProduction
        #endif
        let adjustConfig = ADJConfig(appToken: yourAppToken, environment: environment)
        
        adjustConfig?.logLevel = ADJLogLevelVerbose
        
        Adjust.appDidLaunch(adjustConfig)
    }
    
    func initializePushwoosh_unique(delegate: PWMessagingDelegate) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        //set custom delegate for push handling, in our case AppDelegate
        Pushwoosh.sharedInstance().delegate = delegate;
        PushNotificationManager.initialize(withAppCode: SCSConfigurations.pushwooshToken, appName: SCSConfigurations.pushwooshAppName)
        PWInAppManager.shared().resetBusinessCasesFrequencyCapping()
        PWGDPRManager.shared().showGDPRDeletionUI()
        Pushwoosh.sharedInstance().registerForPushNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func initializeInApps_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        IAPManager.shared.loadProductsFunc()
        IAPManager.shared.completeAllTransactionsFunc()
    }
    
    func makeATT_unique() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("Authorized")
                let idfa = ASIdentifierManager.shared().advertisingIdentifier
                print("Пользователь разрешил доступ. IDFA: ", idfa)
                let authorizationStatus = Adjust.appTrackingAuthorizationStatus()
                Adjust.updateConversionValue(Int(authorizationStatus))
                Adjust.checkForNewAttStatus()
                print(ASIdentifierManager.shared().advertisingIdentifier)
            case .denied:
                print("Denied")
            case .notDetermined:
                print("Not Determined")
            case .restricted:
                print("Restricted")
            @unknown default:
                print("Unknown")
            }
        }
    }
}
