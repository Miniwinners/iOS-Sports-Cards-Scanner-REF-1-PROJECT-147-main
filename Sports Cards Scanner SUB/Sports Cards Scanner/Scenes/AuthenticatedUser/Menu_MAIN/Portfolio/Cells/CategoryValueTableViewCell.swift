import UIKit
import SnapKit

final class CategoryValueTableViewCell: UITableViewCell {

    lazy var categoryLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 20: 14)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }(UILabel())

    lazy var valueLabel: UILabel = { label in
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ?26:20)
        label.textColor = .greenColor
        label.textAlignment = .right
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ?20:14)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }(UILabel())

    lazy var cardImageView: UIImageView = { imageView in
        return imageView
    }(UIImageView())

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
        categoryLabel.setLineHeight(UIDevice.isIpad ?28:22)
    }

    func setCardsValue(_ value: Double) {
        valueLabel.text = value.formattedAsPrice
        valueLabel.setLineHeight(UIDevice.isIpad ?28:22)
    }

    func setCardImage(_ image: UIImage) {
        cardImageView.image = image
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
        cardsNumberLabel.setLineHeight(UIDevice.isIpad ?23:17)
        cardsNumberLabel.textAlignment = .right
    }

//    func setCellPosition(_ cellPosition: CellPosition) {
//        selfHeightConstraint.update(offset: cellPosition.containsPosition(.atBottomPosition) ? 78 : 74)
//    }
    lazy var containerView: UIView = .init()

}

extension CategoryValueTableViewCell {

    func setupSubviews_unique() {
        backgroundColor = .white
        layer.cornerRadius = UIDevice.isIpad ? 26:16
        layer.masksToBounds = true
        let highlightedView = UIView()
        highlightedView.layer.cornerRadius = UIDevice.isIpad ? 26:16
        highlightedView.backgroundColor = .highlightColor2
        selectedBackgroundView = highlightedView

        containerView.layer.cornerRadius = UIDevice.isIpad ? 26:16
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
//            selfHeightConstraint = $0.height.equalTo(0).offset(UIDevice.isIpad ?200:100).constraint
            $0.height.equalTo(UIDevice.isIpad ? 120: 78)
        }

        containerView.addSubviews(cardImageView, categoryLabel, valueLabel, cardsNumberLabel)
        cardImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
            make.size.equalTo(UIDevice.isIpad ? 36:22)
        }
        categoryLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(10)
            $0.leading.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
        }

        valueLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
            $0.right.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
        }
        cardsNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(categoryLabel)
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(10)
            $0.right.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
        }

    }
}
