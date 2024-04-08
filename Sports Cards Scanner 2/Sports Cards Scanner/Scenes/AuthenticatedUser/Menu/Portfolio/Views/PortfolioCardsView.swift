import UIKit
import SnapKit

final class PortfolioCardsView: UIView {

    lazy var stackView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }(UIStackView(arrangedSubviews: [cardSetsView, infoView, categoriesCardsView]))

    lazy var cardSetsView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var collectionView: CardSetView = .init(setType: .collection)
    lazy var deckView: CardSetView = .init(setType: .deck)

    lazy var collectionButton: CommonButton = .init(style: .custom(buttonAppearance))
    lazy var deckButton: CommonButton = .init(style: .custom(buttonAppearance))

    lazy var infoView: PortfolioInfoView = .init()

    lazy var categoriesCardsView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var categoriesTableView: UITableView = { tableView in
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        return tableView
    }(UITableView())

    private var categoriesCardsHeightConstraint: Constraint!

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func updateCategories(number: Int) {
        let height = 74 * CGFloat(number) + 3
        categoriesCardsHeightConstraint.update(offset: height)
        categoriesTableView.reloadData()
    }
}

private extension PortfolioCardsView {
    var buttonAppearance: CommonButton.SCSAppearance {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 0
        return .init(
            configuration: configuration,
            backgroundColors: .init(primary: .white, highlighted: .highlightColor2)
        )
    }

    func setupSubviews_unique() {
        setupCardSetsView()
        setupCategoriesCardsView()

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }

    func setupCardSetsView() {
        collectionButton.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(10)
        }
        deckButton.addSubview(deckView)
        deckView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.verticalEdges.trailing.equalToSuperview().inset(16)
        }

        let verticalLineView = UIView()
        verticalLineView.backgroundColor = .dividerColor

        cardSetsView.addSubviews(collectionButton, deckButton, verticalLineView)
        collectionButton.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        deckButton.snp.makeConstraints {
            $0.verticalEdges.trailing.equalToSuperview()
            $0.leading.equalTo(collectionButton.snp.trailing)
        }
        verticalLineView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.width.equalTo(1)
        }

        cardSetsView.snp.makeConstraints {
            $0.height.equalTo(108)
        }
    }

    func setupCategoriesCardsView() {
        let allCardsLabel = UILabel()
        allCardsLabel.text = L10n.Portfolio.allCards
        allCardsLabel.font = .font(.interMedium, size: 20)
        allCardsLabel.textColor = .labelColor
        allCardsLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        allCardsLabel.setContentHuggingPriority(.required, for: .vertical)
        allCardsLabel.setLineHeight(24)

        let underlineView = UIView()
        underlineView.backgroundColor = .dividerColor

        categoriesCardsView.addSubviews(allCardsLabel, underlineView, categoriesTableView)
        allCardsLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        underlineView.snp.makeConstraints {
            $0.top.equalTo(allCardsLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        categoriesTableView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            categoriesCardsHeightConstraint = $0.height.equalTo(0).constraint
        }
    }
}
