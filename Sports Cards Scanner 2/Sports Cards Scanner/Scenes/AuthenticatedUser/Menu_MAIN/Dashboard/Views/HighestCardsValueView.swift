import UIKit
import SnapKit

final class HighestCardsValueView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Dashboard.highestValue
        label.textColor = .black
        label.font = .font(.ubuntuMedium500, size: 24)
        label.setLineHeight(28)
        return label
    }(UILabel())

    lazy var stackView: UIStackView = { stackView in
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }(UIStackView(arrangedSubviews: [cardButton, cardButtonTwo]))

    lazy var discloseButton: UIButton = { button in
        button.setImage(Images.disclose.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var cardButton: CommonButton = .init(style: .custom(createCardButtonAppearance()))
    lazy var cardButtonTwo: CommonButton = .init(style: .custom(createCardButtonAppearance()))

    lazy var cardView: CardView = .init()
    lazy var cardViewTwo: CardView = .init()

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCard(_ card: CardRepresentable, _ cardTwo: CardRepresentable) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardView.setCard(card)
        cardViewTwo.setCard(cardTwo)
    }

}

private extension HighestCardsValueView {
    func setupSubviews_unique() {
        backgroundColor = .white
        cornerRadius = 12
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }

        addSubview(discloseButton)
        discloseButton.snp.makeConstraints {
            $0.size.equalTo(28)
            $0.trailing.equalToSuperview().inset(6)
            $0.centerY.equalTo(titleLabel)
        }

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        cardButton.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        cardView.isUserInteractionEnabled = false
        cardView.setCardsNumber(1)

        cardButtonTwo.addSubview(cardViewTwo)
        cardViewTwo.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        cardViewTwo.isUserInteractionEnabled = false
        cardViewTwo.setCardsNumber(2)
    }

    private func createCardButtonAppearance() -> CommonButton.SCSAppearance {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 16
        return .init(configuration: configuration, backgroundColors: .init(primary: .skyBlue, highlighted: .highlightColor2))
    }
}
