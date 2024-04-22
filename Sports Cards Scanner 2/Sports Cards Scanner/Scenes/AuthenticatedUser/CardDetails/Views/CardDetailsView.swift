import UIKit
import SnapKit

final class CardDetailsView: UIView {

    lazy var backView: BackView = .init()

    lazy var cardContainerView: UIView = { view in
        view.backgroundColor = .clear
        view.cornerRadius = 24
        return view
    }(UIView())

    lazy var containerStackPriceAdd: UIStackView = { stackView in
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }(UIStackView(arrangedSubviews: [pricingReportButton, addCardButton]))

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

    lazy var pricingReportButton: PricingReportButton = .init(priceButtonType: .main)

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

        pricingReportButton.graderPriceView.type = cardType == .addedCard ? .main: .add
        pricingReportButton.graderPriceView.updateConstraints()
        containerStackPriceAdd.snp.remakeConstraints { make in
               make.height.equalTo(cardType == .addedCard ? 65 : 130)
           }
        containerStackPriceAdd.superview?.layoutIfNeeded()
    }
}
private extension CardDetailsView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        backView.setupView(in: self)

        cardContainerView.addSubviews(cardImageView, cardTitleLabel, cardSubTitleLabel)
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        cardSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(cardTitleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
        }
        cardImageView.snp.makeConstraints {
            $0.width.equalTo(235)
            $0.height.equalTo(330)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cardSubTitleLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(5)
        }

        backView.addSubview(cardContainerView)
        cardContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(48)
            $0.centerX.equalToSuperview()
        }

        backView.addSubview(cardGraderButton)
        cardGraderButton.snp.makeConstraints { make in
            make.top.equalTo(cardContainerView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        let containerStackEditRemove = UIStackView(arrangedSubviews: [editCardButton, removeCardButtonContainer])
        containerStackEditRemove.axis = .vertical
        containerStackEditRemove.spacing = 10
        containerStackEditRemove.distribution = .fillEqually

        let stackView = UIStackView(arrangedSubviews: [
           containerStackPriceAdd, detailsListView, containerStackEditRemove
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        backView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(cardGraderButton.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview().inset(20)

        }

        containerStackEditRemove.snp.makeConstraints { make in
            make.height.equalTo(130)
        }

        cardGraderButton.snp.makeConstraints {
            $0.height.equalTo(39)
        }

        findCardButton.snp.makeConstraints {
            $0.height.equalTo(42)
        }
    }

    func getButtonContainer(for cancelTypedButton: UIButton) -> UIView {
        let containerView = UIView()
        containerView.addSubview(cancelTypedButton)
        cancelTypedButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return containerView
    }
}
