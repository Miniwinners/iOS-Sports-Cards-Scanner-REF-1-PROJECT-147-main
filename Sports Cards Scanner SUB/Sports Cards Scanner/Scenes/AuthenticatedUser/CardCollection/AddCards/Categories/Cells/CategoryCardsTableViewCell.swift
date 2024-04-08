import UIKit
import SnapKit

final class CategoryCardsTableViewCell: UITableViewCell {

    private var topConstraint: Constraint!
    private var bottomConstraint: Constraint!

    lazy var categoryLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 16)
        label.textColor = .labelColor
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 14)
        label.textColor = .labelColor
        return label
    }(UILabel())

    lazy var separatorView: UIView = { view in
        view.backgroundColor = .dividerColor
        return view
    }(UIView())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCategory(_ category: CardCategory) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        categoryLabel.text = category.title
    }

    func setCards(number: Int) {
        switch number {
        case 1:
            cardsNumberLabel.text = L10n.Portfolio.oneCard.uppercased()
        default:
            cardsNumberLabel.text = L10n.Portfolio.numberOfCards(number).uppercased()
        }
    }

    func setCellPosition(_ cellPosition: CellPosition) {
        separatorView.isHidden = cellPosition.containsPosition(.atBottomPosition)
        topConstraint.update(inset: cellPosition.containsPosition(.onTopPosition) ? 10 : 0)
        bottomConstraint.update(inset: cellPosition.containsPosition(.atBottomPosition) ? 16 : 0)
    }
}

private extension CategoryCardsTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        selectedBackgroundView = highlightedView

        let containerView = UIView()
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            topConstraint = $0.top.equalToSuperview().constraint
            bottomConstraint = $0.bottom.equalToSuperview().constraint
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(36)
        }

        containerView.addSubviews(categoryLabel, cardsNumberLabel, separatorView)
        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        cardsNumberLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(0.5)
        }
    }
}
