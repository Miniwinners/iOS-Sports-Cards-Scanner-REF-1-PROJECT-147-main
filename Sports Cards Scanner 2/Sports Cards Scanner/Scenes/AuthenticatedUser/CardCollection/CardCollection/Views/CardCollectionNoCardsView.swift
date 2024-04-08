import UIKit
import SnapKit

final class CardCollectionNoCardsView: UIView {

    lazy var infoContainerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var nameLabel: UILabel = { label in
        label.font = .font(.interBold, size: 24)
        label.textColor = .labelColor
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var menuButton: UIButton = { button in
        button.setImage(Images.menuDots.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var priceContainerView: UIView = .init()

    lazy var priceLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 24)
        label.textColor = .labelColor
        label.text = Double.zero.formattedAsPrice
        label.setLineHeight(28)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var estimatedValueLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 14)
        label.textColor = .labelColor
        label.text = L10n.CardCollection.estimatedValue
        label.setLineHeight(22)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var noCardsView: CommonMessageView = { view in
        view.setMessageTitle(L10n.CardCollection.noCards)
        return view
    }(CommonMessageView())

    lazy var addCardsButton: CommonButton = { button in
        button.setButtonTitle(L10n.CardCollection.Action.addCards)
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCollectionName(_ name: String?) {
        nameLabel.text = name
        nameLabel.setLineHeight(28)
    }

    func showEstimatedValue() {
        guard priceContainerView.superview == nil else { return }

        infoContainerView.addSubview(priceContainerView)

        priceContainerView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.leading.bottom.equalToSuperview().inset(16)
        }
    }

    func hideEstimatedValue() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        priceContainerView.removeFromSuperview()
    }
}

private extension CardCollectionNoCardsView {
    func setupSubviews_unique() {
        backgroundColor = .backColor

        priceContainerView.addSubviews(priceLabel, estimatedValueLabel)
        priceLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        estimatedValueLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(4)
            $0.leading.bottom.equalToSuperview()
        }

        infoContainerView.addSubviews(nameLabel, menuButton)
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16).priority(.high)
        }
        menuButton.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8)
            $0.top.trailing.equalToSuperview().inset(6)
            $0.size.equalTo(44)
        }

        addSubviews(infoContainerView, noCardsView, addCardsButton)
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        noCardsView.snp.makeConstraints {
            $0.top.equalTo(infoContainerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        addCardsButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
