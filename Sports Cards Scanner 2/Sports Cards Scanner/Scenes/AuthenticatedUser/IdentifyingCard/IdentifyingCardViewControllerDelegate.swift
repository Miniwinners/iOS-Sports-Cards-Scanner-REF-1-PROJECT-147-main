import Foundation

protocol IdentifyingCardViewControllerDelegate: AnyObject {
    func identifyingCardViewControllerCancelTapped(_ viewController: IdentifyingCardViewController)
    func identifyingCardViewControllerDidIdentify(withError error: Error, in viewController: IdentifyingCardViewController)
    func identifyingCardViewControllerDidIdentify(withCard identifiedCard: CardRepresentable, in viewController: IdentifyingCardViewController)
}
