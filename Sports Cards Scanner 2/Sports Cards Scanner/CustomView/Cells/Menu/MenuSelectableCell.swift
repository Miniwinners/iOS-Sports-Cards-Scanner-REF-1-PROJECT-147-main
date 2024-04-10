import UIKit
import SnapKit

final class MenuSelectableCell: SelectableTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setMenuItem(_ item: MenuItem) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        titleLabel.text = item.localizable
        rightImageView.image = item.image
    }

    func setCellPosition(_ cellPosition: CellPosition) {
        topConstraint.update(inset: cellPosition.containsPosition(.onTopPosition) ? 20 : 24)
        bottomConstraint.update(inset: cellPosition.containsPosition(.atBottomPosition) ? 20 : 24)

        var corners = UIRectCorner()
        if cellPosition.containsPosition(.onTopPosition) { corners.insert([.topLeft, .topRight]) }
        if cellPosition.containsPosition(.atBottomPosition) { corners.insert([.bottomLeft, .bottomRight]) }
        backgroundView?.subviews.first?.roundCorners(corners, radius: 14)
        selectedBackgroundView?.subviews.first?.roundCorners(corners, radius: 14)
    }

}

private extension MenuSelectableCell {
    func setupSubviews_unique() {
        titleLabel.snp.updateConstraints {
            $0.leading.equalToSuperview().inset(12)
        }
        rightImageView.snp.updateConstraints {
            $0.trailing.equalToSuperview().inset(12)
        }

    }
}
