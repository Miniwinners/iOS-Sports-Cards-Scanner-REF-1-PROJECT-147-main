import UIKit
import SnapKit
import Foundation
final class PortfolioCardsView: UIView {
    private var unlock: Bool
    private var previousHeight: CGFloat?

    lazy var stackView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.spacing = UIDevice.isIpad ? 30:20
        return stackView
    }(UIStackView(arrangedSubviews: [infoView, cardContainerView, categoriesCardsView]))

    lazy var cardContainerView: UIView = { view in
        backgroundColor = .clear
        return view
    }(UIView())

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
//        view.lockImageView.isHidden = true
        return view
    }(DeckCollectionView(setType: .deck))

    lazy var collectionButton: CommonButton = .init(style: .custom(buttonAppearance))
    lazy var deckButton: CommonButton = .init(style: .custom(buttonAppearance))

    lazy var infoView: PortfolioInfoView = .init()

    lazy var categoriesCardsView: UIView = { view in
        view.backgroundColor = .clear
        view.cornerRadius = UIDevice.isIpad ? 30:12
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

    init(unlock: Bool) {
        self.unlock = unlock
        print("unlock status - \(unlock)")
        super.init(frame: .zero)
        setupSubviews_unique()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCategories(number: Int) {
//        let inset: CGFloat = UIDevice.isIpad ? 120:74
//        let height = UIDevice.isIpad ? 120:74 * CGFloat(number) + inset
//        categoriesCardsHeightConstraint.update(offset: height)
//        categoriesTableView.reloadData()
    }
}

private extension PortfolioCardsView {
    var buttonAppearance: CommonButton.SCSAppearance {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = UIDevice.isIpad ? 20:16
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
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 50:40)
            $0.bottom.equalToSuperview()
        }
    }

    func setupCardSetsView() {
        addSubview(cardContainerView)
        cardContainerView.addSubviews(collectionButton, deckButton)

        collectionButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.equalTo(deckButton.snp.left).offset(UIDevice.isIpad ? -20 : -10)
            make.width.equalTo(deckButton.snp.width)
        }

        deckButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.left.equalTo(collectionButton.snp.right).offset(UIDevice.isIpad ?20:10)
            make.width.equalTo(collectionButton.snp.width)

        }
        collectionButton.addSubview(collectionView)
        deckButton.addSubview(deckView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        deckView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    func setupCategoriesCardsView() {
        let allCardsLabel = UILabel()
        allCardsLabel.text = L10n.Portfolio.allCards
        allCardsLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ?30:24)
        allCardsLabel.textColor = .black
        allCardsLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        allCardsLabel.setContentHuggingPriority(.required, for: .vertical)
        allCardsLabel.setLineHeight(UIDevice.isIpad ?31:25)

        categoriesCardsView.addSubviews(allCardsLabel, categoriesTableView)
        allCardsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview()
        }

        categoriesTableView.snp.makeConstraints {
            $0.top.equalTo(allCardsLabel.snp.bottom).offset(15)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 120 * 8 - 8 * 7 : 74 * 8 - 8 * 7 + 60)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 70 : 30)
        }
    }
}

extension PortfolioCardsView {
    func configureContainer() {
        cardContainerView.snp.updateConstraints { make in
            let maxButtonHeight = max(collectionButton.frame.height, deckButton.frame.height)
//            print("collectionButton - \(collectionButton.frame.height)")
//            print("deckButton - \(deckButton.frame.height)")
//            print("Current max height container: \(maxButtonHeight), Previous height: \(previousHeight)")

            if maxButtonHeight != previousHeight {
                previousHeight = maxButtonHeight
                make.height.equalTo(previousHeight ?? 0)
            }
        }
    }
}
