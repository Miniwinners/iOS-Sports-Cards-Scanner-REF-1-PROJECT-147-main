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

    init(cardCollectionManager: CardCollectionManager = CardSetsManager.shared) {
        self.cardCollectionManager = cardCollectionManager

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
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
//        setupNavigationItem()

        let cardsDisplayOption = CardsDisplayOption.list
        cardCollectionView.cardsView.cardsDisplayControl.selectedSegmentIndex = cardsDisplayOption.index
        cardCollectionView.cardsView.setCardsDisplay(option: cardsDisplayOption)

        let cardsTableView = cardCollectionView.cardsView.cardsTableView
        cardsTableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.className)
        cardsTableView.dataSource = self
        cardsTableView.delegate = self

        let cardsCollectionView = cardCollectionView.cardsView.cardsCollectionView
        cardsCollectionView.register(CardPhotoInfoCollectionViewCell.self, forCellWithReuseIdentifier: CardPhotoInfoCollectionViewCell.className)
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

        cardCollectionView.cardsView.customContainer.menuButton.addTarget(self, action: #selector(menuTapped_unique), for: .touchUpInside)
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

    func setupNavigationItem() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil

        navigationItem.rightBarButtonItem = .init(
            image: Images.close.image,
            style: .plain,
            target: self,
            action: #selector(closeTapped_unique)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    func card(at indexPath: IndexPath) -> CardRepresentable? {
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
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.className, for: indexPath) as? CardTableViewCell

        if let card = card(at: indexPath) {
            cell?.setupCard(card)
        }
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: sortedCards))

        return cell ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension CardCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let card = card(at: indexPath) else { return }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardPhotoInfoCollectionViewCell.className, for: indexPath) as? CardPhotoInfoCollectionViewCell

        if let card = card(at: indexPath) {
            cell?.setCard(card)
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - CollectionView FlowLayout Delegate

extension CardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let horizontalSpacing = (flowLayout?.sectionInset.left ?? 0) + (flowLayout?.sectionInset.right ?? 0)
        let itemsInRow: CGFloat = 2
        let interitemSpacing = flowLayout?.minimumInteritemSpacing ?? 0
        let itemWidth = (collectionViewWidth - horizontalSpacing - interitemSpacing * (itemsInRow - 1)) / itemsInRow
        let itemHeight = CardPhotoInfoCollectionViewCell.calculateCellHeight(for: itemWidth)
        return .init(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoInfoCollectionViewCell
        cell?.setCellHighlighted(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoInfoCollectionViewCell
        cell?.setCellHighlighted(false)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let card = card(at: indexPath) else { return }
        delegate?.cardCollectionViewControllerCardDidSelect(card, in: self)
    }
}
