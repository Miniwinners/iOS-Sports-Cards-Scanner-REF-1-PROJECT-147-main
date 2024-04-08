import UIKit
import SnapKit

final class ProfileSwitchableCell: SwitchableTableViewCell {
    func setProfileItem(_ item: ProfileItem, selected: Bool) {
        titleLabel.text = item.title
        switchView.setOn(selected, animated: false)

        topConstraint.update(inset: item.isFirst ? 16 : 20)
        bottomConstraint.update(inset: item.isLast ? 16 : 20)

        separatorView.isHidden = item.isLast

        var corners = UIRectCorner()
        if item.isFirst { corners.insert([.topLeft, .topRight]) }
        if item.isLast { corners.insert([.bottomLeft, .bottomRight]) }
        backgroundView?.subviews.first?.roundCorners(corners, radius: 12)
    }
}
