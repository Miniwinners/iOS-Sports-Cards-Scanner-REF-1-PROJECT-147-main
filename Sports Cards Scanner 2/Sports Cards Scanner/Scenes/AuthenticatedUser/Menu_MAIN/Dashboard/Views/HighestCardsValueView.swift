import UIKit
import SnapKit

final class HighestCardsValueView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Dashboard.highestValue
        label.textColor = .labelColor
        label.font = .font(.ubuntuMedium500, size: 24)
        label.setLineHeight(28)
        return label
    }(UILabel())

    lazy var discloseButton: UIButton = { button in
        button.setImage(Images.disclose.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var cardButton: CommonButton = .init(style: .custom(createCardButtonAppearance()))

    lazy var cardView: CardView = .init()

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCard(_ card: CardRepresentable) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardView.setCard(card)
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
            $0.size.equalTo(44)
            $0.top.trailing.equalToSuperview().inset(6)
        }

        addSubview(cardButton)
        cardButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        cardButton.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.horizontalEdges.bottom.equalToSuperview().inset(16)
        }
        cardView.isUserInteractionEnabled = false
        cardView.setCardsNumber(1)
    }

    private func createCardButtonAppearance() -> CommonButton.SCSAppearance {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 0

        return .init(configuration: configuration, backgroundColors: .init(highlighted: .highlightColor2))
    }
}
