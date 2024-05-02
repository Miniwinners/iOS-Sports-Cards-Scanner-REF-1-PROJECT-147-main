import UIKit
import SnapKit

final class HighestCardsValueView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Dashboard.highestValue
        label.textColor = .labelColor
        label.font = .font(.ubuntuMedium500, size: 24)
        return label
    }(UILabel())

    lazy var discloseButton: UIButton = { button in
        button.setImage(Images.disclose.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var cardButton: CommonButton = .init(style: .custom(createCardButtonAppearance()))
    lazy var cardButton2: CommonButton = .init(style: .custom(createCardButtonAppearance()))
    lazy var cardView: CardView = .init()
    lazy var cardView2: CardView = .init()

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
    private extension HighestCardsValueView {
        func setupSubviews_unique() {
            backgroundColor = .white
            cornerRadius = 12
            backgroundColor = .clear
            layer.cornerRadius = 12  // Предполагается, что HighestCardsValueView является UIView
            setupLabel()
            setupButton()
            setupStackView()
        }

        func setupLabel() {
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.top.leading.equalToSuperview().inset(16)
                $0.top.leading.equalToSuperview().inset(6)
                $0.height.equalTo(30)
            }
        }

        func setupButton() {
            addSubview(discloseButton)
            discloseButton.snp.makeConstraints {
                $0.size.equalTo(44)
                $0.top.trailing.equalToSuperview().inset(6)
            }

            addSubview(underlineView)
            underlineView.snp.makeConstraints {
                $0.height.equalTo(1)
                $0.top.equalToSuperview().inset(50)
                $0.horizontalEdges.equalToSuperview().inset(16)
                $0.trailing.equalToSuperview().inset(6)
                $0.centerY.equalTo(titleLabel)
            }
        }

            addSubview(cardButton)
            cardButton.snp.makeConstraints {
                $0.top.equalTo(underlineView.snp.bottom)
                $0.horizontalEdges.bottom.equalToSuperview()
        func setupStackView() {
            let stackView = UIStackView(arrangedSubviews: [configureCardButton(cardView, number: 1), configureCardButton(cardView2, number: 2)])
            stackView.spacing = 10
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.backgroundColor = .clear
            addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.horizontalEdges.equalToSuperview()
    //            make.height.greaterThanOrEqualTo(297)
            }
        }

        func configureCardButton(_ cardView: CardView, number: Int) -> UIButton {
            let cardButton = UIButton()
            cardButton.addSubview(cardView)
    //        cardButton.snp.makeConstraints {
    //            $0.height.equalTo(297)
    //        }
            cardView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(10)
                $0.horizontalEdges.bottom.equalToSuperview().inset(16)
    //            $0.height.equalTo(297)
                $0.top.equalToSuperview()
                $0.horizontalEdges.equalToSuperview().inset(16)
            }
            cardView.isUserInteractionEnabled = false
            cardView.setCardsNumber(1)
            cardView.setCardsNumber(number)
            return cardButton
        }


    private func createCardButtonAppearance() -> CommonButton.SCSAppearance {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 0

        return .init(configuration: configuration, backgroundColors: .init(highlighted: .highlightColor2))
    }
}
