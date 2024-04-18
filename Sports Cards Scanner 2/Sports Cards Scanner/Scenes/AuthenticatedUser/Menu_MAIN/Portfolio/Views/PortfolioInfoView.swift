import UIKit
import SnapKit

final class PortfolioInfoView: UIView {

    lazy var cardsValueLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 24)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var containerView: UIView = { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        return view
    }(UIView())

    lazy var estimatedValueLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: 14)
        label.text = L10n.Portfolio.estimatedValue
        label.textColor = .black
        return label
    }(UILabel())

    lazy var cardsLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: 14)
        label.text = L10n.Portfolio.cards
        label.textColor = .black
        return label
    }(UILabel())

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 24)
        label.text = L10n.Portfolio.title
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 24)
        label.textColor = .black
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
        backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(26)
        }
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        snp.makeConstraints {
            $0.height.equalTo(148)
        }
        containerView.addSubviews(estimatedValueLabel, cardsLabel)
        estimatedValueLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(15)
            $0.height.equalTo(18)
        }

        containerView.addSubviews(cardsValueLabel, cardsNumberLabel)
        cardsValueLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.height.equalTo(26)
            $0.top.equalTo(estimatedValueLabel.snp.bottom).offset(5)
        }
        cardsNumberLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(cardsValueLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(30)
            $0.height.equalTo(26)
        }
        cardsLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(cardsNumberLabel.snp.bottom).offset(5)
            $0.height.equalTo(20)
        }
    }
}
