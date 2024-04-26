import UIKit
import SnapKit

final class OptionTableViewCell: UITableViewCell {

    private var titleTopConstraint: Constraint!
    private var titleBottomConstraint: Constraint!

    lazy var titleLabel: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ?22:16)
        return label
    }(UILabel())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCellTitle(_ title: String) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        titleLabel.text = title
    }

//    func setCellPosition(_ cellPosition: CellPosition) {
//        titleTopConstraint.update(inset: cellPosition.containsPosition(.onTopPosition) ? 12 : 6)
//        titleBottomConstraint.update(inset: cellPosition.containsPosition(.atBottomPosition) ? 12 : 6)
//    }

}

private extension OptionTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .skyBlue

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        selectedBackgroundView = highlightedView

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ?26:22)
            $0.horizontalEdges.equalToSuperview().inset(16)
            titleTopConstraint = $0.top.equalToSuperview().inset(12).constraint
            titleBottomConstraint = $0.bottom.equalToSuperview().inset(12).constraint
        }

    }
}
