import UIKit
import SnapKit

final class CategoryValueTableViewCell: UITableViewCell {

    lazy var categoryLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 16)
        label.textColor = .labelColor
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }(UILabel())

    lazy var valueLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 20)
        label.textColor = .greenColor
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 14)
        label.textColor = .labelColor
        label.numberOfLines = 0
        return label
    }(UILabel())

    lazy var separatorView: UIView = { view in
        view.backgroundColor = .dividerColor
        return view
    }(UIView())

    private var selfHeightConstraint: Constraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCategory(_ category: CardCategory) {
        categoryLabel.text = category.shortTitle
        categoryLabel.setLineHeight(22)
    }

    func setCardsValue(_ value: Double) {
        valueLabel.text = value.formattedAsPrice
        valueLabel.setLineHeight(22)
    }

    func setCardsNumber(_ number: Int) {
        switch number {
        case 0:
            cardsNumberLabel.text = L10n.Portfolio.scanToAdd
        case 1:
            cardsNumberLabel.text = L10n.Portfolio.oneCard.uppercased()
        default:
            cardsNumberLabel.text = L10n.Portfolio.numberOfCards(number).uppercased()
        }
        cardsNumberLabel.setLineHeight(17)
        cardsNumberLabel.textAlignment = .right
    }

    func setCellPosition(_ cellPosition: CellPosition) {
        separatorView.isHidden = cellPosition.containsPosition(.atBottomPosition)
        selfHeightConstraint.update(offset: cellPosition.containsPosition(.atBottomPosition) ? 77 : 74)
    }
}

private extension CategoryValueTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        selectedBackgroundView = highlightedView

        let containerView = UIView()
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview()
            selfHeightConstraint = $0.height.equalTo(0).offset(74).constraint
        }

        containerView.addSubviews(categoryLabel, valueLabel, cardsNumberLabel, separatorView)
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
        }
        valueLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
        }
        cardsNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(30)
            $0.trailing.equalToSuperview()
        }
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
