import UIKit

final class AlertService {
    static let shared: AlertService = .init()

    func presentAC(type: SCSAlertType, in viewController: UIViewController, animated: Bool = true, completion: Closure? = nil) {
        let alertController = type.builder.buildAlertController()
        viewController.present(alertController, animated: animated, completion: completion)
    }
}
