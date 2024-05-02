import UIKit
import SnapKit

final class ProfileSwitchableCell: SwitchableTableViewCell {
    func setProfileItem(_ item: ProfileItem, selected: Bool) {
        titleLabel.text = item.title
        switchView.setOn(selected, animated: false)
        titleLabel.textColor = .tableViewTitleLabel
    }
}
