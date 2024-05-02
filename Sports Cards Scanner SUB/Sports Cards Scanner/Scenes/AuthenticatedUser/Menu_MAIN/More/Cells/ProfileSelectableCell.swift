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
        titleLabel.textColor = .tableViewTitleLabel
    }

    func setProfileItem(_ item: ProfileItem) {
        titleLabel.text = item.title

    }
}
