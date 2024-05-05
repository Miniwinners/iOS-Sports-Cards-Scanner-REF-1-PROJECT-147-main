import UIKit

protocol PortfolioViewControllerDelegate: AnyObject {
    func portfolioViewControllerScanCardTapped(_ viewController: PortfolioViewController)
    func portfolioViewControllerCreateCollectionTapped(_ viewController: PortfolioViewController)
    func portfolioViewControllerCreateDeckTapped(_ viewController: PortfolioViewController)
    func portfolioDeckSubscribe(_ viewController: PortfolioViewController)
    func portfolioViewControllerShowCollectionTapped(_ viewController: PortfolioViewController)
    func portfolioViewControllerShowDeckTapped(_ viewController: PortfolioViewController)
    func portfolioViewControllerCategoryTapped(_ category: CardCategory, in viewController: PortfolioViewController)
}
