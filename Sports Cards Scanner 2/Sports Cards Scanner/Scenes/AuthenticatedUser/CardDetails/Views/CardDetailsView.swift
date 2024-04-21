import UIKit
import SnapKit

final class CardDetailsView: UIView {

    lazy var backView: UIView = { view in
        view.setupBackView()
        return view
    }(UIView())

    lazy var cardContainerView: UIView = { view in
        view.backgroundColor = .red
        view.cornerRadius = 24
        return view
    }(UIView())

    lazy var cardImageView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 20
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageView.layer.shadowRadius = 5
        return imageView
    }(UIImageView())

    lazy var cardTitleLabel: UILabel = { label in
        label.textColor = .logInLabel
        label.font = .font(.ubuntuBold700, size: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setLineHeight(24)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardSubTitleLabel: UILabel = { label in
        label.textColor = .logInLabel
        label.font = .font(.ubuntuRegular400, size: 16)
        label.setLineHeight(24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardGraderButton: CardGraderButton = .init()

    lazy var pricingReportButton: PricingReportButton = .init()

    lazy var detailsListView: CardDetailsListView = .init()

    lazy var addCardButton: AddToPortfolioButton = { button in
        return button
    }(AddToPortfolioButton())

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
        backgroundColor = .clear
        addSubview(backView)
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        cardContainerView.addSubviews(cardTitleLabel, cardSubTitleLabel, cardImageView)
        cardContainerView.backgroundColor = .clear
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        cardSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cardTitleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        cardImageView.snp.makeConstraints {
            $0.top.equalTo(cardSubTitleLabel.snp.bottom).offset(20)
            $0.width.equalTo(263)
            $0.height.equalTo(379)

        }

        backView.addSubview(cardContainerView)
        cardContainerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(32)
            $0.width.greaterThanOrEqualTo(263)
            $0.centerX.equalToSuperview()
            $0.height.greaterThanOrEqualTo(400)
        }

        backView.addSubview(cardGraderButton)
        cardGraderButton.snp.makeConstraints {
            $0.top.equalTo(cardContainerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(39)
        }

        backView.addSubview(pricingReportButton)
        pricingReportButton.snp.makeConstraints {
            $0.top.equalTo(cardGraderButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(70)
        }

        backView.addSubview(detailsListView)
        detailsListView.snp.makeConstraints {
            $0.top.equalTo(pricingReportButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }

        backView.addSubview(editCardButton)
        editCardButton.snp.makeConstraints {
            $0.top.equalTo(detailsListView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }

        backView.addSubview(removeCardButtonContainer)
        removeCardButtonContainer.snp.makeConstraints {
            $0.top.equalTo(editCardButton.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview()
        }

        let stackView = UIStackView(arrangedSubviews: [
            pricingReportButton, addCardButton, detailsListView,
            cardGraderButton, pricingReportButton, addCardButton,
            editCardButton, findCardButtonContainer, removeCardButtonContainer
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(cardGraderButton.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(20)

        }

        cardGraderButton.snp.makeConstraints {
            $0.height.equalTo(39)
        }
        pricingReportButton.snp.makeConstraints {
            $0.height.equalTo(430)

        }
        addCardButton.snp.makeConstraints {
            $0.height.equalTo(430)
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
