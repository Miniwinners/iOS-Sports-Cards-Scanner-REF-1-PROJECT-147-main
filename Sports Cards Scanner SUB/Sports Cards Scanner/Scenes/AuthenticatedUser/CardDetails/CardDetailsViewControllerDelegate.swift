import Foundation

protocol CardDetailsViewControllerDelegate: AnyObject {
    func cardDetailsViewControllerCloseTapped(_ viewController: CardDetailsViewController)
    func cardDetailsViewControllerBackTapped(_ viewController: CardDetailsViewController)

    func cardDetailsViewControllerSelectGraderTapped(_ viewController: CardDetailsViewController)
    func cardDetailsViewControllerPricingReportTapped(_ viewController: CardDetailsViewController)
    func cardDetailsViewControllerEditCardTapped(_ viewController: CardDetailsViewController)
    func cardDetailsViewControllerFindCardTapped(_ viewController: CardDetailsViewController)

    func cardDetailsViewControllerRemoveCardTapped(_ card: CardRepresentable, in viewController: CardDetailsViewController)

    func cardDetailsViewControllerCardDidAdd(_ viewController: CardDetailsViewController)
}
