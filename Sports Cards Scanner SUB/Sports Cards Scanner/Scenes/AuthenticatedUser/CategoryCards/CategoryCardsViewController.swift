import UIKit

final class CategoryCardsViewController: UITableViewController {

    private let cardsManager: UserCardsManager

    private let category: CardCategory
    private var categoryCards: [CardRepresentable] = []

    weak var delegate: CategoryCardsViewControllerDelegate?

    init(category: CardCategory, cardsManager: UserCardsManager = .shared) {
        self.category = category
        self.cardsManager = cardsManager
        super.init(style: .plain)
        title = category.shortTitle
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

private extension CategoryCardsViewController {
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
        categoryCards = cardsManager.cards(of: category)
        tableView.reloadData()
    }

    func getCard(at indexPath: IndexPath) -> CardRepresentable? {
        guard let card = categoryCards[safe: indexPath.row] else { return nil }
        return card
    }

    // MARK: - Actions

    @objc func closeTapped_unique() {
        delegate?.categoryCardsViewControllerCloseTapped(self)
    }

    @objc func profileInfoDidUpdate(_ notification: Notification) {
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards)
        else { return }

        Task { @MainActor in reloadData_unique() }
    }
}

// MARK: - TableView DataSource

extension CategoryCardsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryCards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CardTableViewCell.className,
            for: indexPath
        ) as? CardTableViewCell

        if let card = getCard(at: indexPath) {
            cell?.setupCard(card)
        }
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: categoryCards))

        return cell ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension CategoryCardsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let card = getCard(at: indexPath) else { return }
        delegate?.categoryCardsViewControllerDidSelectCard(card, in: self)
    }
}
