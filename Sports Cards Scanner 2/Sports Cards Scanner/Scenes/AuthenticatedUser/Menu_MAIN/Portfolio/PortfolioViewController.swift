import UIKit

final class PortfolioViewController: UIViewController {

    weak var delegate: PortfolioViewControllerDelegate?

    private let profileManager: ProfileManager
    private let cardsManager: UserCardsManager
    private let cardSetsManager: CardCollectionManager & CardDeckManager

    private var categoriesCardsInfo: [CategoryCards] = []

    private var isLoading: Bool = false {
        didSet { portfolioView.scanCardButton.isLoading = isLoading }
    }

    // MARK: - Subviews

    lazy var portfolioView = PortfolioView()

    init(
        profileManager: ProfileManager = .shared,
        cardsManager: UserCardsManager = .shared,
        cardSetsManager: CardCollectionManager & CardDeckManager = CardSetsManager.shared
    ) {
        self.profileManager = profileManager
        self.cardsManager = cardsManager
        self.cardSetsManager = cardSetsManager
        super.init(nibName: nil, bundle: nil)

        title = L10n.Portfolio.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = portfolioView
    }

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()

        setupViews_unique()
        setupActions_unique()
        subscribeToNotifications()
    }
}

private extension PortfolioViewController {
    func setupViews_unique() {
        portfolioView.cardsView.categoriesTableView.register(CategoryValueTableViewCell.self, forCellReuseIdentifier: CategoryValueTableViewCell.className)
        portfolioView.cardsView.categoriesTableView.dataSource = self
        portfolioView.cardsView.categoriesTableView.delegate = self

        reloadSubviews_unique()
    }

    func setupActions_unique() {
        portfolioView.scanCardButton.addTarget(self, action: #selector(scanCardTapped), for: .touchUpInside)
        portfolioView.cardsView.collectionButton.addTarget(self, action: #selector(cardCollectionTapped), for: .touchUpInside)
        portfolioView.cardsView.deckButton.addTarget(self, action: #selector(cardDeckTapped), for: .touchUpInside)
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileInfoDidUpdate(_:)), name: .profileInfoDidUpdate, object: nil)
    }

    func reloadSubviews_unique() {
        if cardsManager.cards.isEmpty {
            portfolioView.showNoCardView()
        } else {
            portfolioView.showCardsView()

            portfolioView.updateCardCollection(cardSetsManager.cardCollection)
            portfolioView.updateCardDeck(cardSetsManager.cardDeck)
            portfolioView.updateCardsTotalValue(cardsManager.currentCardsValue)
            portfolioView.updateCardsNumber(cardsManager.cards.count, maxNumber: cardsManager.maxCardsNumber)

            categoriesCardsInfo = cardsManager.enabledCategories.map {
                CategoryCards(
                    category: $0,
                    cardsValue: cardsManager.cardsValue(of: $0),
                    cardsNumber: cardsManager.cardsNumber(of: $0)
                )
            }
            portfolioView.updateCategories(number: categoriesCardsInfo.count)
        }
    }

    func categoryCards(at indexPath: IndexPath) -> CategoryCards? {
        categoriesCardsInfo[safe: indexPath.section]
    }

    func loadProfileInfo() {
        if !profileManager.isProfileLoading {
            profileManager.loadProfileInfo()
        }

        isLoading = true

        Task { @MainActor in
            defer { isLoading = false }

            try? await profileManager.profileLoadingTask?.result.get()
            guard profileManager.isProfileLoaded else { return }
            guard cardsManager.isScanEnabled else { return }
            guard isViewVisible else { return }
            delegate?.portfolioViewControllerScanCardTapped(self)
        }
    }

    // MARK: - Actions

    @objc func scanCardTapped() {
        guard profileManager.isProfileLoaded else {
            loadProfileInfo()
            return
        }
        guard cardsManager.isScanEnabled else { return }
        delegate?.portfolioViewControllerScanCardTapped(self)
    }

    @objc func cardCollectionTapped() {
        if cardSetsManager.cardCollection.isNil {
            delegate?.portfolioViewControllerCreateCollectionTapped(self)
        } else {
            delegate?.portfolioViewControllerShowCollectionTapped(self)
        }
    }

    @objc func cardDeckTapped() {
        if cardSetsManager.cardDeck.isNil {
            delegate?.portfolioViewControllerCreateDeckTapped(self)
        } else {
            delegate?.portfolioViewControllerShowDeckTapped(self)
        }
    }

    @objc func profileInfoDidUpdate(_ notification: Notification) {
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards)
                || fields.contains(.cardCategories)
                || fields.contains(.collection)
                || fields.contains(.deck)
        else { return }

        Task { @MainActor in
            reloadSubviews_unique()
        }
    }
}

// MARK: - TableView DataSource

extension PortfolioViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        categoriesCardsInfo.count

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryValueTableViewCell.className, for: indexPath) as? CategoryValueTableViewCell

        if let categoryCards = categoryCards(at: indexPath) {
            cell?.setCategory(categoryCards.category)
            cell?.setCardsValue(categoryCards.cardsValue)
            cell?.setCardsNumber(categoryCards.cardsNumber)
            cell?.setCardImage(categoryCards.category.image)
        }
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: categoriesCardsInfo))

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 0
        default: return 9
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }

}

// MARK: - TableView Delegate

extension PortfolioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let category = categoryCards(at: indexPath)?.category,
              !cardsManager.cards(of: category).isEmpty
        else {
            return
        }
        delegate?.portfolioViewControllerCategoryTapped(category, in: self)
    }
}
