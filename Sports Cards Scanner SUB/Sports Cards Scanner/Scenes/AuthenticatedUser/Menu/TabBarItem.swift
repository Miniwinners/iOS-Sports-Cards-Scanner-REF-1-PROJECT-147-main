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
}
