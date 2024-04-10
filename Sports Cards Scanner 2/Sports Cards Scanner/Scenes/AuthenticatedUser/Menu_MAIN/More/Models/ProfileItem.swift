import Foundation

enum ProfileItem: CaseIterable {
    case cardCategories
    case updatePassword
    case privacyPolicy
    case termsAndConditions
    case pushNotifications
    case logout
    case deleteAccount

    var title: String {
        switch self {
        case .cardCategories: return L10n.More.Item.cardCategories
        case .updatePassword: return L10n.More.Item.updatePassword
        case .privacyPolicy: return L10n.More.Item.privacyPolicy
        case .termsAndConditions: return L10n.More.Item.termsAndConditions
        case .pushNotifications: return L10n.More.Item.pushNotifications
        case .logout: return L10n.More.Item.logout
        case .deleteAccount: return L10n.More.Item.deleteAccount
        }
    }

    var type: ItemType {
        switch self {
        case .cardCategories, .updatePassword, .privacyPolicy,
                .termsAndConditions, .logout, .deleteAccount:
            return .selectable
        case .pushNotifications:
            return .switchable
        }
    }

    var isFirst: Bool { self == Self.allCases.first }
    var isLast: Bool { self == Self.allCases.last }
}

extension ProfileItem {
    enum ItemType {
        case selectable
        case switchable
    }
}
