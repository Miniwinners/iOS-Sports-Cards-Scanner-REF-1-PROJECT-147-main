import UIKit
import SnapKit

final class PortfolioInfoView: UIView {

    lazy var cardsValueLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 24)
        label.textColor = .labelColor
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 24)
        label.textColor = .labelColor
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCardsValue(_ cardsValue: Double) {
        cardsValueLabel.text = cardsValue.formattedAsPrice
        cardsValueLabel.setLineHeight(28)
        cardsValueLabel.lineBreakMode = .byTruncatingMiddle
    }

    func setCardsNumber(_ number: Int, maxNumber: Int) {
        cardsNumberLabel.text = "\(number)/\(maxNumber)"
        cardsNumberLabel.setLineHeight(28)
    }

}

private extension PortfolioInfoView {
    func setupSubviews_unique() {
        backgroundColor = .white
        cornerRadius = 12
        snp.makeConstraints {
            $0.height.equalTo(122)
        }

        setupStaticLabels()

        addSubviews(cardsValueLabel, cardsNumberLabel)
        cardsValueLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(58)
        }
        cardsNumberLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(cardsValueLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(58)
        }
    }

    func setupStaticLabels() {
        let titleLabel = UILabel()
        titleLabel.font = .font(.interBold, size: 24)
        titleLabel.text = L10n.Portfolio.title
        titleLabel.textColor = .labelColor
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setLineHeight(28)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }

        let estimatedValueLabel = UILabel()
        estimatedValueLabel.font = .font(.interRegular, size: 14)
        estimatedValueLabel.text = L10n.Portfolio.estimatedValue
        estimatedValueLabel.textColor = .labelColor
        estimatedValueLabel.setLineHeight(22)
        addSubview(estimatedValueLabel)
        estimatedValueLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
        }

        let cardsLabel = UILabel()
        cardsLabel.font = .font(.interRegular, size: 14)
        cardsLabel.text = L10n.Portfolio.cards
        cardsLabel.textColor = .labelColor
        cardsLabel.setLineHeight(22)
        addSubview(cardsLabel)
        cardsLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
