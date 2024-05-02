import UIKit

protocol MoreViewControllerDelegate: AnyObject {
    func moreViewControllerDidPressItem(_ item: ProfileItem, in viewController: MoreViewController)
}
