import UIKit
import SnapKit

final class ProfileSelectableCell: SelectableTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        rightImageView.image = Images.disclosure.image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.prepareForReuse()
        titleLabel.textColor = .labelColor
    }

    func setProfileItem(_ item: ProfileItem) {
        titleLabel.text = item.title

        topConstraint.update(inset: item.isFirst ? 16 : 20)
        bottomConstraint.update(inset: item.isLast ? 16 : 20)

        separatorView.isHidden = item.isLast

        var corners = UIRectCorner()
        if item.isFirst { corners.insert([.topLeft, .topRight]) }
        if item.isLast { corners.insert([.bottomLeft, .bottomRight]) }
        backgroundView?.subviews.first?.roundCorners(corners, radius: 12)
        selectedBackgroundView?.subviews.first?.roundCorners(corners, radius: 12)
    }
}
