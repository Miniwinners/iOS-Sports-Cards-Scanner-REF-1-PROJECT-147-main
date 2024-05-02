import UIKit
import SnapKit

final class CardCollectionNoCardsView: UIView {

    lazy var containerView: UIView = { view in
        view.backgroundColor = .skyBlue
        view.cornerRadius = UIDevice.isIpad ? 26:16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        return view
    }(UIView())

    lazy var nameLabel: UILabel = { label in
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ? 30:24)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var titleLabel: TitleLabel = { label in
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(TitleLabel())

    lazy var menuButton: UIButton = { button in
        button.setImage(Images.menuDots.image, for: .normal)
        button.tintColor = .black
        return button
    }(UIButton(type: .system))

    lazy var priceContainerView: UIView = .init()

    lazy var priceLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 28:22)
        label.textColor = .black
        label.text = Double.zero.formattedAsPrice
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var estimatedValueLabel: UILabel = { label in
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ? 22:16)
        label.textColor = .black
        label.text = L10n.CardCollection.estimatedValue
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
        button.setImage(Images.addPlus2.image, for: .normal)
        button.configuration?.imagePadding = 20
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCollectionName(_ name: String?) {
        titleLabel.text = name
    }

    func showEstimatedValue() {

        guard priceContainerView.superview == nil else { return }

        containerView.addSubview(priceContainerView)
        priceContainerView.snp.makeConstraints {
//            $0.top.bottom.equalToSuperview().inset(20)
            $0.center.equalToSuperview()
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
        backgroundColor = .clear
        titleLabel.setupLabel(in: self)

        priceContainerView.addSubviews(estimatedValueLabel, priceLabel)

        estimatedValueLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 30:20)
        }

        priceLabel.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.top.equalTo(estimatedValueLabel.snp.bottom).offset(5)
        }

        containerView.addSubview(menuButton)

        menuButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
            $0.size.equalTo(UIDevice.isIpad ? 42:24)
        }

        addSubviews(containerView, noCardsView, addCardsButton)
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.height.equalTo(UIDevice.isIpad ? 216:125)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        noCardsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 124:70)
        }
        addCardsButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 80:54)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
        }
    }
}
