import UIKit
import Pushwoosh
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var router: SportivinieKartiAppDR!
    var coordinator: SportivinieKartiAppCoo!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.tintColor = .white
        router = .init(window: window)
        coordinator = .init(router: router, authService: .init())

        coordinator.pokazatNachalnoePredstavlenie(animated: true, onDismissed: nil)

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        Task {
            try await SportivinieKartiPushiService().zaprositUNrasreshenie()
            await SportivinieKartiAppSleditService().zaprositTracking()
        }
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        SportivinieKartiInternetSoedinenieService.shared.nachatMonitoringInterneta()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        SportivinieKartiInternetSoedinenieService.shared.ostanovitMonitoringInterneta()
    }

}
