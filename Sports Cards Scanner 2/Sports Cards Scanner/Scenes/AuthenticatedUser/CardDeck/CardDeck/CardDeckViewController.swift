import UIKit

final class CardDeckViewController: UIViewController {

    @UserDefaultCodable(UserDefaults.KeyOption.selectedCardSortOption, defaultValue: CardSortOption.default)
    private var selectedSortOption: CardSortOption

    weak var delegate: CardDeckViewControllerDelegate?

    private let cardDeckManager: CardDeckManager
    private var cardDeck: CardDeck? { cardDeckManager.cardDeck }

    private var sortedCards: [CardRepresentable] = []

    // MARK: - Subviews

    lazy var cardDeckView: CardDeckView = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    init(cardDeckManager: CardDeckManager = CardSetsManager.shared) {
        self.cardDeckManager = cardDeckManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = cardDeckView
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
        reloadData_unique()
        subscribeToNotifications()
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

private extension CardDeckViewController {
    func setupViews_unique() {
//        setupNavigationItem()

        let cardsView = cardDeckView.cardsTableView
        cardsView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.className)
        cardsView.dataSource = self
        cardsView.delegate = self
        closeButton.setCenter(in: view)
    }

    func setupActions_unique() {
        closeButton.addTarget(self, action: #selector(closeTapped_unique), for: .touchUpInside)
        cardDeckView.menuButton.addTarget(self, action: #selector(menuTapped_unique), for: .touchUpInside)
        cardDeckView.addCardsButton.addTarget(self, action: #selector(addCardTapped), for: .touchUpInside)
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileInfoDidUpdate(_:)), name: .profileInfoDidUpdate, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectedSortOptionDidUpdate),
            name: .init(rawValue: UserDefaults.KeyOption.selectedCardSortOption),
            object: nil
        )
    }

//    func setupNavigationItem() {
//        navigationItem.setHidesBackButton(true, animated: false)
//        navigationItem.leftBarButtonItem = nil
//
//        navigationItem.rightBarButtonItem = .init(
//            image: Images.close.image,
//            style: .plain,
//            target: self,
//            action: #selector(closeTapped_unique)
//        )
//        navigationItem.rightBarButtonItem?.tintColor = .black
//    }

    func reloadData_unique() {
        sortedCards = cardDeckManager.deckCards.sortedElements(by: selectedSortOption)

        cardDeckView.setDeck(name: cardDeck?.name)
        cardDeckView.setCards(count: sortedCards.count)
        cardDeckView.setCards(price: cardDeckManager.deckCardsValue)
        cardDeckView.cardsTableView.reloadData()
    }

    func card(at indexPath: IndexPath) -> CardRepresentable? {
        sortedCards[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func closeTapped_unique() {
        delegate?.cardDeckViewControllerCloseTapped(self)
    }

    @objc func menuTapped_unique() {
        guard let cardDeck = cardDeck else { return }
        delegate?.cardDeckViewControllerMenuTapped(for: cardDeck, in: self)
    }

    @objc func addCardTapped() {
        delegate?.cardDeckViewControllerAddCardsTapped(self)
    }

    @objc func profileInfoDidUpdate(_ notification: Notification) {
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards) || fields.contains(.deck)
        else { return }

        Task { @MainActor in
            reloadData_unique()
        }
    }

    @objc func selectedSortOptionDidUpdate() {
        Task { @MainActor in
            reloadData_unique()
        }
    }
}

// MARK: - TableView DataSource

extension CardDeckViewController: UITableViewDataSource {
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

extension CardDeckViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let card = card(at: indexPath) else { return }
        delegate?.cardDeckViewControllerCardDidSelect(card, in: self)
    }
}

extension CardDeckViewController: SwipableController {
    var isSwipeBackEnabled: Bool { false }
}
