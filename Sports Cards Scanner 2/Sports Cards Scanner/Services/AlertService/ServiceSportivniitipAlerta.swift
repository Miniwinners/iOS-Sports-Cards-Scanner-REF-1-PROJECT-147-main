import Foundation
func vicheslitFibonc77(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SportivinieKartitipAlerta {
    case noInternetConnection(okAction: AlertHandler?)
//    case needRecentLogin(okAction: AlertHandler?)
}

extension SportivinieKartitipAlerta {
    var builder: SportivinieKartiAlertStroitel {
        switch self {
        case .noInternetConnection(let okAction):
            return .init(title: L10n.Alert.NoInternetConnection.title, message: L10n.Alert.NoInternetConnection.message)
                .dobavitAlertDeistvie(titled: L10n.Common.ok.uppercased()) { alertController, action in
                    if let okAction = okAction {
                        okAction(alertController, action)
                    } else {
                        alertController.dismiss(animated: true)
                    }
                }

//        case .needRecentLogin(let okAction):
//            return .init(title: L10n.Alert.NeedRecentLogin.title, message: L10n.Alert.NeedRecentLogin.message)
//                .dobavitAlertDeistvie(titled: L10n.Common.cancel) { alertController, _ in
//                    alertController.dismiss(animated: true)
//                }
//                .dobavitAlertDeistvie(titled: L10n.Alert.NeedRecentLogin.Action.logOut, style: .destructive) { alertController, action in
//                    if let okAction = okAction {
//                        okAction(alertController, action)
//                    } else {
//                        alertController.dismiss(animated: true)
//                    }
//                }
        }
    }
}
