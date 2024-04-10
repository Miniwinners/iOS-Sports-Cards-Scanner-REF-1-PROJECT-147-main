import UIKit

enum TabBarItem: CaseIterable {
    case dashboard
    case portfolio
    case more

    var image: UIImage {
        switch self {
        case .dashboard: return Images.dashboard.image
        case .portfolio: return Images.portfolio.image
        case .more: return Images.more.image
        }
    }

    var selectedImage: UIImage {
        switch self {
        case .dashboard: return Images.dashboardSelected.image
        case .portfolio: return Images.portfolioSelected.image
        case .more: return Images.moreSelected.image
        }
    }

    var text: String {
        switch self {
        case .dashboard: return L10n.Dashboard.title
        case .portfolio: return L10n.Portfolio.title
        case .more: return L10n.More.title
        }
    }

    var selectedText: String {
        switch self {
        case .dashboard: return ""
        case .portfolio: return ""
        case .more: return ""
        }
    }
}
