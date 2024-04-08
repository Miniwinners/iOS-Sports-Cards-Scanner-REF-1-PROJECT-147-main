import UIKit

protocol DashboardViewControllerDelegate: AnyObject {
    func dashboardViewControllerScanCardTapped(_ viewController: DashboardViewController)
    func dashboardViewControllerCardDetailsTapped(card: CardRepresentable, in viewController: DashboardViewController)
    func dashboardViewControllerDiscloseCurrentValueTapped(_ viewController: DashboardViewController)
    func dashboardViewControllerDiscloseHighestValueTapped(_ viewController: DashboardViewController)
    func dashboardViewControllerDiscloseRecentlyAddedTapped(_ viewController: DashboardViewController)
}
