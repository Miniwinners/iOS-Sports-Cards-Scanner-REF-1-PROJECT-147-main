import UIKit

struct AppInfo {
    static var bundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? ""
    }

    static var appName: String {
        (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String) ?? ""
    }

    static var settingsURL: URL? {
        URL(string: UIApplication.openSettingsURLString)
    }
}
