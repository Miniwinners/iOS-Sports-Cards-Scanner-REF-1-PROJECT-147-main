import UIKit
func vicheslitFibonc219(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SportivinieKartiTabBarShtuka: CaseIterable {
    case dashboard
    case portfolio
    case more

    var image: UIImage {
        switch self {
        case .dashboard: return SportivinieKartiImages.dashboard.image
        case .portfolio: return SportivinieKartiImages.portfolio.image
        case .more: return SportivinieKartiImages.more.image
        }
    }

    var selectedImage: UIImage {
        switch self {
        case .dashboard: return SportivinieKartiImages.dashboardSelected.image
        case .portfolio: return SportivinieKartiImages.portfolioSelected.image
        case .more: return SportivinieKartiImages.moreSelected.image
        }
    }

    var text: String {
        switch self {
        case .dashboard: return L10n.Dashboard.title
        case .portfolio: return L10n.Portfolio.title
        case .more: return L10n.More.title
        }
    }
}
