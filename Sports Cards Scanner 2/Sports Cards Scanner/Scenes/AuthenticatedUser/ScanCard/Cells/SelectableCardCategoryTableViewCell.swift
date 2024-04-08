import UIKit
import SnapKit

final class SelectableCardCategoryTableViewCell: UITableViewCell {
    enum CellSide {
        case top
        case bottom
    }

    private var topConstraint: Constraint!
    private var bottomConstraint: Constraint!

    private let verticalSpace: CGFloat = 6

    lazy var categoryLabel: UILabel = { label in
        label.textColor = .labelColor
        label.font = .font(.interRegular, size: 14)
        return label
    }(UILabel())

    lazy var checkImageView: UIImageView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        topConstraint.update(inset: verticalSpace)
        bottomConstraint.update(inset: verticalSpace)
    }

    func setCategory(_ category: CardCategory) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        categoryLabel.text = category.title
    }

    func setSelected(_ isSelected: Bool) {
        checkImageView.image = isSelected ? Images.checked.image : Images.unchecked.image
    }

    func setExtraSpace(_ space: CGFloat, to side: CellSide) {
        switch side {
        case .top:
            topConstraint.update(inset: verticalSpace + space)
        case .bottom:
            bottomConstraint.update(inset: verticalSpace + space)
        }
    }
}

private extension SelectableCardCategoryTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        checkImageView.snp.makeConstraints {
            $0.size.equalTo(18)
        }

        let stackView = UIStackView(arrangedSubviews: [categoryLabel, checkImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            topConstraint = $0.top.equalToSuperview().inset(verticalSpace).constraint
            bottomConstraint = $0.bottom.equalToSuperview().inset(verticalSpace).constraint
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(22)
        }
    }
}
