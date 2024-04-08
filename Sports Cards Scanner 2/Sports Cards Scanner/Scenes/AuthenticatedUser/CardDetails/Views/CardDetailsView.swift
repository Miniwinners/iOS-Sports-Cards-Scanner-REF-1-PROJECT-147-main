import UIKit
import SnapKit

final class CardDetailsView: UIView {

    lazy var cardContainerView: UIView = { view in
        view.backgroundColor = .cardBackColor
        view.cornerRadius = 24
        return view
    }(UIView())

    lazy var cardImageView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 20
        return imageView
    }(UIImageView())

    lazy var cardTitleLabel: UILabel = { label in
        label.textColor = .white
        label.font = .font(.interMedium, size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardGraderButton: CardGraderButton = .init()

    lazy var pricingReportButton: PricingReportButton = .init()

    lazy var detailsListView: CardDetailsListView = .init()

    lazy var addCardButton: CommonButton = { button in
        button.setButtonTitle(L10n.CardDetails.Action.addCard)
        return button
    }(CommonButton(style: .default))

    lazy var editCardButton: CommonButton = { button in
        button.setButtonTitle(L10n.CardDetails.Action.editCard)
        return button
    }(CommonButton(style: .default))

    lazy var removeCardButtonContainer: UIView = getButtonContainer(for: removeCardButton)
    lazy var removeCardButton: CommonButton = { button in
        button.setButtonTitle(L10n.CardDetails.Action.removeCard)
        return button
    }(CommonButton(style: .cancel))

    lazy var findCardButtonContainer: UIView = getButtonContainer(for: findCardButton)
    lazy var findCardButton: CommonButton = { button in
        button.setButtonTitle(L10n.CardDetails.Action.findCard)
        return button
    }(CommonButton(style: .cancel))

    init() {
        super.init(frame: .zero)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func hidesNoNeededViews(for cardType: CardType) {
        detailsListView.isHidden = cardType != .addedCard
        addCardButton.isHidden = cardType == .addedCard
        editCardButton.isHidden = cardType != .addedCard
        findCardButtonContainer.isHidden = cardType != .identifiedCard
        removeCardButtonContainer.isHidden = cardType != .addedCard
    }
}

private extension CardDetailsView {
    func setupSubviews_unique() {
        backgroundColor = .white

        cardContainerView.addSubviews(cardImageView, cardTitleLabel)
        cardImageView.snp.makeConstraints {
            $0.width.equalTo(235)
            $0.height.equalTo(330)
            $0.top.horizontalEdges.equalToSuperview().inset(12)
        }
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }

        addSubview(cardContainerView)
        cardContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.centerX.equalToSuperview()
        }

        let stackView = UIStackView(arrangedSubviews: [
            cardGraderButton, pricingReportButton, detailsListView, addCardButton,
            editCardButton, findCardButtonContainer, removeCardButtonContainer
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(cardContainerView.snp.bottom).offset(50)
            $0.horizontalEdges.bottom.equalToSuperview().inset(20)
        }

        cardGraderButton.snp.makeConstraints {
            $0.height.equalTo(39)
        }
        pricingReportButton.snp.makeConstraints {
            $0.height.equalTo(75)
        }
        addCardButton.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        editCardButton.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        findCardButton.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        removeCardButton.snp.makeConstraints {
            $0.height.equalTo(42)
        }
    }

    func getButtonContainer(for cancelTypedButton: UIButton) -> UIView {
        let containerView = UIView()
        containerView.addSubview(cancelTypedButton)
        cancelTypedButton.snp.makeConstraints {
            $0.centerX.verticalEdges.equalToSuperview()
        }
        return containerView
    }
}
