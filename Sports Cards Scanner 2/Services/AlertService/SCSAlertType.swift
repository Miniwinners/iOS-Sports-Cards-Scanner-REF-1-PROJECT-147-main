import Foundation

enum SCSAlertType {
    case noInternetConnection(okAction: AlertHandler?)
    case needRecentLogin(okAction: AlertHandler?)
}

extension SCSAlertType {
    var builder: AlertBuilder {
        switch self {
        case .noInternetConnection(let okAction):
            return .init(title: L10n.Alert.NoInternetConnection.title, message: L10n.Alert.NoInternetConnection.message)
                .addAlertAction(titled: L10n.Common.ok.uppercased()) { alertController, action in
                    if let okAction = okAction {
                        okAction(alertController, action)
                    } else {
                        alertController.dismiss(animated: true)
                    }
                }

        case .needRecentLogin(let okAction):
            return .init(title: L10n.Alert.NeedRecentLogin.title, message: L10n.Alert.NeedRecentLogin.message)
                .addAlertAction(titled: L10n.Common.cancel) { alertController, _ in
                    alertController.dismiss(animated: true)
                }
                .addAlertAction(titled: L10n.Alert.NeedRecentLogin.Action.logOut, style: .destructive) { alertController, action in
                    if let okAction = okAction {
                        okAction(alertController, action)
                    } else {
                        alertController.dismiss(animated: true)
                    }
                }
        }
    }
}
