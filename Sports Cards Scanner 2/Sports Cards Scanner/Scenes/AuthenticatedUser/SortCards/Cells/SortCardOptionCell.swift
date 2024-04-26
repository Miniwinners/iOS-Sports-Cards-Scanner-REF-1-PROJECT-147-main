import UIKit
import SnapKit

final class SortCardOptionCell: UITableViewCell {

    private var topConstraint: Constraint!
    private var bottomConstraint: Constraint!

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        label.textColor = .black
        return label
    }(UILabel())

    lazy var checkImageView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFit
        return imageView
    }(UIImageView())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSortOption(_ option: CardSortOption) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        titleLabel.text = option.localizable
    }

    func setChecked(_ checked: Bool) {
        checkImageView.image = checked ? Images.checked.image : Images.unchecked.image
    }

}

private extension SortCardOptionCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        let backgroundView = UIView()
        backgroundView.backgroundColor = .skyBlue
        backgroundView.layer.cornerRadius = UIDevice.isIpad ? 22:12
        self.backgroundView = backgroundView

        let highlightedView = UIView()
        highlightedView.layer.cornerRadius = UIDevice.isIpad ? 22:12
        highlightedView.backgroundColor = .highlightColor2
        self.selectedBackgroundView = highlightedView

        contentView.addSubviews(titleLabel, checkImageView)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 30:22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        checkImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(UIDevice.isIpad ? 40:24)
        }
    }
}
