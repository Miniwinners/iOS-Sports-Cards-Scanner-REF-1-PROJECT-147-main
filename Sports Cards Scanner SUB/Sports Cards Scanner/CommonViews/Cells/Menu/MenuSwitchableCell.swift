import UIKit
import SnapKit

final class MenuSwitchableCell: SwitchableTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setMenuItem(_ menuItem: MenuItem, selected: Bool) {
        titleLabel.text = menuItem.localizable
        switchView.setOn(selected, animated: false)
    }

    func setCellPosition(_ cellPosition: CellPosition) {
        topConstraint.update(inset: cellPosition.containsPosition(.onTopPosition) ? 20 : 24)
        bottomConstraint.update(inset: cellPosition.containsPosition(.atBottomPosition) ? 20 : 24)
        separatorView.isHidden = cellPosition.containsPosition(.atBottomPosition)

        var corners = UIRectCorner()
        if cellPosition.containsPosition(.onTopPosition) { corners.insert([.topLeft, .topRight]) }
        if cellPosition.containsPosition(.atBottomPosition) { corners.insert([.bottomLeft, .bottomRight]) }
        backgroundView?.subviews.first?.roundCorners(corners, radius: 14)
    }

}

private extension MenuSwitchableCell {
    func setupSubviews_unique() {
        titleLabel.snp.updateConstraints {
            $0.leading.equalToSuperview().inset(12)
        }
        switchView.snp.updateConstraints {
            $0.trailing.equalToSuperview().inset(12)
        }
        separatorView.snp.updateConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
    }
}
