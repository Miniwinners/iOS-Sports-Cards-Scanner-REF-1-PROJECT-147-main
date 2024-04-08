import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var router: AppDelegateRouter!
    var coordinator: SCSAppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.tintColor = .labelColor

        router = .init(window: window)
        coordinator = .init(router: router, authService: .init())

        coordinator.presentInitialState(animated: true, onDismissed: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        Task {
            try await PushNotificationService().requestUNPermission()
            await AppTrackingService().requestTracking()
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        NetworkMonitoringService.shared.startNetworkMonitoring()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        NetworkMonitoringService.shared.stopNetworkMonitoring()
    }

}
