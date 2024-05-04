import UIKit
import SnapKit
final class CardCollectionViewController: UIViewController {

    @UserDefault(UserDefaults.KeyOption.isTotalPriceVisible, defaultValue: true)
    private var isTotalPriceVisible: Bool

    @UserDefaultCodable(UserDefaults.KeyOption.selectedCardSortOption, defaultValue: CardSortOption.default)

    private var selectedSortOption: CardSortOption

    weak var delegate: CardCollectionViewControllerDelegate?

    private let cardCollectionManager: CardCollectionManager

    private var cardCollection: CardCollection? { cardCollectionManager.cardCollection }

    private var sortedCards: [CardRepresentable] = []

    // MARK: - Subviews

    lazy var cardCollectionView: CardCollectionView = .init()

    lazy var closeButton: CloseButton = .init(style: .close)

    lazy var scrollView: BaseScrollView = { scroll in
        scroll.alwaysBounceVertical = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .clear
        scroll.contentInset.bottom = 20
        return scroll
    }(BaseScrollView())

    init(cardCollectionManager: CardCollectionManager = CardSetsManager.shared) {
        self.cardCollectionManager = cardCollectionManager

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        cardCollectionView.cardsView.isShown = isTotalPriceVisible ? .show:.hide
        view = cardCollectionView
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
        reloadData()
        subscribeToNotifications()

        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(closeTapped_unique), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

private extension CardCollectionViewController {
    func setupViews_unique() {

        let cardsDisplayOption = CardsDisplayOption.list
        cardCollectionView.cardsView.cardsDisplayControl.selectedSegmentIndex = cardsDisplayOption.index
        cardCollectionView.cardsView.setCardsDisplay(option: cardsDisplayOption)

        let cardsTableView = cardCollectionView.cardsView.cardsTableView
        cardsTableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.className)
        cardsTableView.dataSource = self
        cardsTableView.delegate = self

        let cardsCollectionView = cardCollectionView.cardsView.cardsCollectionView
        cardsCollectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.className)
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self

        let cardsSwipeableView = cardCollectionView.cardsView.cardsSwipeableView
        cardsSwipeableView.didSelectCard = { [unowned self, weak delegate] card in
            delegate?.cardCollectionViewControllerCardDidSelect(card, in: self)
        }
    }

    func setupActions_unique() {
        cardCollectionView.noCardsView.addCardsButton.addTarget(self, action: #selector(addCardsTapped), for: .touchUpInside)
        cardCollectionView.noCardsView.menuButton.addTarget(self, action: #selector(menuTapped_unique), for: .touchUpInside)

        cardCollectionView.cardsView.menuButton.addTarget(self, action: #selector(menuTapped_unique), for: .touchUpInside)
        cardCollectionView.cardsView.cardsDisplayControl.addTarget(self, action: #selector(cardsDisplayOptionChanged(_:)), for: .valueChanged)
    }

    func reloadData() {
        sortedCards = cardCollectionManager.collectionCards.sortedElements(by: selectedSortOption)

        if cardCollectionManager.collectionCards.isEmpty {
            cardCollectionView.showNoCards()
            cardCollectionView.noCardsView.setCollectionName(cardCollection?.name)
            if isTotalPriceVisible {
                cardCollectionView.noCardsView.showEstimatedValue()
            } else {
                cardCollectionView.noCardsView.hideEstimatedValue()
            }
        } else {
            cardCollectionView.showCards()
            cardCollectionView.cardsView.cardsSwipeableView.cards = sortedCards
            cardCollectionView.cardsView.reloadCardsViews()
            cardCollectionView.cardsView.setCollectionName(cardCollection?.name)
            cardCollectionView.cardsView.setCards(count: sortedCards.count)
            cardCollectionView.cardsView.setCards(price: cardCollectionManager.collectionCardsValue)
            if isTotalPriceVisible {
                cardCollectionView.cardsView.showEstimatedValue()
            } else {
                cardCollectionView.cardsView.hideEstimatedValue()
            }
        }
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileInfoDidUpdate(_:)), name: .profileInfoDidUpdate, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(totalPriceVisibleDidUpdate),
            name: .init(rawValue: UserDefaults.KeyOption.isTotalPriceVisible),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectedSortOptionDidUpdate),
            name: .init(rawValue: UserDefaults.KeyOption.selectedCardSortOption),
            object: nil
        )
    }

    func cardTable(at indexPath: IndexPath) -> CardRepresentable? {
        sortedCards[safe: indexPath.section]
    }

    func cardCollection(at indexPath: IndexPath) -> CardRepresentable? {
        sortedCards[safe: indexPath.row]
    }
    // MARK: - Actions

    @objc func close() {
        dismiss(animated: true)
    }

    @objc func closeTapped_unique() {
        delegate?.cardCollectionViewControllerCloseTapped(self)
    }

    @objc func addCardsTapped() {
        delegate?.cardCollectionViewControllerAddCardsTapped(self)
    }

    @objc func menuTapped_unique() {
        guard let cardCollection = cardCollection else { return }
        delegate?.cardCollectionViewControllerMenuTapped(for: cardCollection, in: self)
    }

    @objc func cardsDisplayOptionChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        cardCollectionView.cardsView.index = selectedIndex
        guard let displayOption = CardsDisplayOption(by: selectedIndex) else { return }
        cardCollectionView.cardsView.setCardsDisplay(option: displayOption)
    }

    @objc func profileInfoDidUpdate(_ notification: Notification) {
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards) || fields.contains(.collection)
        else { return }

        Task { @MainActor in
            reloadData()
        }
    }

    @objc func totalPriceVisibleDidUpdate() {
        Task { @MainActor in
            reloadData()
        }
    }

    @objc func selectedSortOptionDidUpdate() {
        Task { @MainActor in
            reloadData()
        }
    }
}

extension CardCollectionViewController: SwipableController {
    var isSwipeBackEnabled: Bool { false }
}

// MARK: - TableView DataSource

extension CardCollectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedCards.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.className, for: indexPath) as? CardTableViewCell

        if let card = cardTable(at: indexPath) {
            cell?.setupCard(card)
            cell?.cardView.pricesLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIphone ? 18:22)
            cell?.cardView.titleLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIphone ? 20:26)
            cell?.cardView.subtitleLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIphone ? 16:20)

//            cell?.cardView.pricesLabel.setLineHeight(UIDevice.isIphone ? 22:24)
//            cell?.cardView.titleLabel.setLineHeight(UIDevice.isIphone ? 26:28)
//            cell?.cardView.subtitleLabel.setLineHeight(UIDevice.isIphone ? 22:24)
        }

        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 } else { return 8 }
    }
}

// MARK: - TableView Delegate

extension CardCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let card = cardTable(at: indexPath) else { return }
        delegate?.cardCollectionViewControllerCardDidSelect(card, in: self)
    }
}

// MARK: - CollectionView DataSource

extension CardCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sortedCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.className, for: indexPath) as? CardCollectionViewCell

        if let card = cardCollection(at: indexPath) {
            cell?.setupCard(card)
//            cell?.cardView.pricesLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIphone ? 14 : 20)
//            cell?.cardView.titleLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIphone ? 18 : 24)
//            cell?.cardView.subtitleLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIphone ? 16 : 20)
//            cell?.cardView.pricesLabel.setLineHeight(UIDevice.isIphone ? 18:22)
//            cell?.cardView.titleLabel.setLineHeight(UIDevice.isIphone ? 22:26)
//            cell?.cardView.subtitleLabel.setLineHeight(UIDevice.isIphone ? 18:22)
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - CollectionView FlowLayout Delegate

extension CardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let card = cardCollection(at: indexPath) else { return }
        delegate?.cardCollectionViewControllerCardDidSelect(card, in: self)
    }
}
