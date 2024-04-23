import UIKit
import SnapKit

final class PortfolioCardsView: UIView {

    lazy var stackView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }(UIStackView(arrangedSubviews: [infoView, cardStackView, categoriesCardsView]))

    lazy var cardStackView: UIStackView = { stackView in
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }(UIStackView(arrangedSubviews: [collectionButton, deckButton]))

    lazy var collectionView: DeckCollectionView = { view in
        view.subtitleCreate.text = L10n.Portfolio.Deck.description
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }(DeckCollectionView(setType: .collection))

    lazy var deckView: DeckCollectionView = { view in
        view.subtitleCreate.text = L10n.Portfolio.Collection.description
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }(DeckCollectionView(setType: .deck))

    lazy var collectionButton: CommonButton = .init(style: .custom(buttonAppearance))
    lazy var deckButton: CommonButton = .init(style: .custom(buttonAppearance))

    lazy var infoView: PortfolioInfoView = .init()

    lazy var categoriesCardsView: UIView = { view in
        view.backgroundColor = .clear
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var categoriesTableView: UITableView = { tableView in
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }(UITableView())

    private var categoriesCardsHeightConstraint: Constraint!

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func updateCategories(number: Int) {
        let height = 74 * CGFloat(number) + 74
        categoriesCardsHeightConstraint.update(offset: height)
        categoriesTableView.reloadData()
    }
}

private extension PortfolioCardsView {
    var buttonAppearance: CommonButton.SCSAppearance {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 16
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
        deckButton.addSubview(deckView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        deckView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cardStackView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
    }

    func setupCategoriesCardsView() {
        let allCardsLabel = UILabel()
        allCardsLabel.text = L10n.Portfolio.allCards
        allCardsLabel.font = .font(.ubuntuMedium500, size: 24)
        allCardsLabel.textColor = .black
        allCardsLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        allCardsLabel.setContentHuggingPriority(.required, for: .vertical)
        allCardsLabel.setLineHeight(25)

        categoriesCardsView.addSubviews(allCardsLabel, categoriesTableView)
        allCardsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview()
        }

        categoriesTableView.snp.makeConstraints {
            $0.top.equalTo(allCardsLabel.snp.bottom).offset(15)
            $0.horizontalEdges.bottom.equalToSuperview()
            categoriesCardsHeightConstraint = $0.height.equalTo(0).constraint
        }
    }
}
