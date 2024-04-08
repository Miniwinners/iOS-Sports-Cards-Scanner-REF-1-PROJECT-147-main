import UIKit

final class HighestValueCardListViewController: UITableViewController {

    private let cardsManager: UserCardsManager
    private var highestValueCards: [CardRepresentable] = []

    weak var delegate: HighestValueListViewControllerDelegate?

    init(cardsManager: UserCardsManager = .shared) {
        self.cardsManager = cardsManager
        super.init(style: .plain)
        title = L10n.HighestValue.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()
        setupViews_unique()
        subscribeToNotifications()
        reloadData_unique()
    }

    override func viewWillAppear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

private extension HighestValueCardListViewController {
    func setupViews_unique() {
        navigationItem.rightBarButtonItem = .init(
            image: Images.close.image,
            style: .plain,
            target: self,
            action: #selector(closeTapped_unique)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black

        tableView.backgroundColor = .backColor
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 20
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.className)
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileInfoDidUpdate(_:)), name: .profileInfoDidUpdate, object: nil)
    }

    func reloadData_unique() {
        highestValueCards = cardsManager.highestValuedCards(count: 10)
        tableView.reloadData()
    }

    func getCard(at indexPath: IndexPath) -> CardRepresentable? {
        guard let card = highestValueCards[safe: indexPath.row] else { return nil }
        return card
    }

    // MARK: - Actions

    @objc func closeTapped_unique() {
        delegate?.highestValueListViewControllerCloseTapped(self)
    }

    @objc func profileInfoDidUpdate(_ notification: Notification) {
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards)
        else { return }

        Task { @MainActor in reloadData_unique() }
    }
}

// MARK: - TableView DataSource

extension HighestValueCardListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        highestValueCards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CardTableViewCell.className,
            for: indexPath
        ) as? CardTableViewCell

        if let card = getCard(at: indexPath) {
            cell?.setupCard(card)
        }
        cell?.setCardsNumber(indexPath.row + 1)
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: highestValueCards))

        return cell ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension HighestValueCardListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let card = getCard(at: indexPath) else { return }
        delegate?.highestValueListViewControllerDidSelectCard(card, in: self)
    }
}
