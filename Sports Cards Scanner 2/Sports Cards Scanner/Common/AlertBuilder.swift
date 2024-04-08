import UIKit

final class AlertBuilder {
    private let alertController: UIAlertController

    private var actions: [UIAlertAction] = []

    private var preferredActionIndex: Int?
    private var preferredAction: UIAlertAction? {
        guard let index = preferredActionIndex else { return nil }
        return actions[safe: index]
    }

    init(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert
    ) {
        alertController = .init(title: title, message: message, preferredStyle: style)
    }

    func addAlertAction(
        titled title: String,
        style: UIAlertAction.Style = .default,
        handler: AlertHandler?
    ) -> Self {
        let action = UIAlertAction(title: title, style: style) { [unowned alertController] action in
            handler?(alertController, action)
        }
        actions.append(action)
        return self
    }

    func setPreferredAction(at index: Int?) -> Self {
        preferredActionIndex = index
        return self
    }

    func buildAlertController() -> UIAlertController {
        actions.forEach(alertController.addAction(_:))
        alertController.preferredAction = preferredAction
        return alertController
    }

}
