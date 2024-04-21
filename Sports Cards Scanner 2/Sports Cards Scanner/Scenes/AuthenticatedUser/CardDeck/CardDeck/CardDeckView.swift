import UIKit
import SnapKit

final class CardDeckView: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var menuButton: UIButton = { button in
        button.setImage(Images.menuDots.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 16)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var nameSecondaryLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 22)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var priceLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 16)
        label.textColor = .greenColor
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }(UILabel())

    lazy var cardsTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 20
        return tableView
    }(UITableView())

    lazy var noCardsView: CommonMessageView = { view in
        view.setMessageTitle(L10n.CardDeck.noCards)
        return view
    }(CommonMessageView())

    lazy var addCardsButton: CommonButton = { button in
        button.setButtonTitle(L10n.CardDeck.Action.addCards)
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setDeck(name: String?) {
        titleLabel.text = name
        nameSecondaryLabel.text = name
        nameSecondaryLabel.setLineHeight(22)
    }

    func setCards(count: Int) {
        switch count {
        case 1:
            cardsNumberLabel.text = L10n.Portfolio.oneCard
        default:
            cardsNumberLabel.text = L10n.Portfolio.numberOfCards(count)
        }
        cardsNumberLabel.setLineHeight(22)

        noCardsView.isHidden = count != 0
        addCardsButton.isHidden = count != 0
    }

    func setCards(price: Double) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        priceLabel.text = price.formattedAsPrice
    }

}

private extension CardDeckView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        backView.setupView(in: self)

        titleLabel.setupLabel(in: backView)

        addSubviews(menuButton, cardsNumberLabel, nameSecondaryLabel, priceLabel, cardsTableView, noCardsView, addCardsButton)

        cardsNumberLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(20)
        }

        nameSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(cardsNumberLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(cardsNumberLabel)
            $0.leading.equalTo(cardsNumberLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
        cardsTableView.snp.makeConstraints {
            $0.top.equalTo(nameSecondaryLabel.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        noCardsView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        addCardsButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(54)
        }

        menuButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.centerY.equalTo(nameSecondaryLabel)
            $0.trailing.equalToSuperview().inset(30)
            $0.leading.equalTo(nameSecondaryLabel.snp.trailing).offset(8)
        }
    }
}
