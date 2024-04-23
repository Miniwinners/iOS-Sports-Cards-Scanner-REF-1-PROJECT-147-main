import UIKit

final class CategoryCardsViewController: UIViewController {

    private let cardsManager: UserCardsManager

    private let category: CardCategory
    private var categoryCards: [CardRepresentable] = []

    weak var delegate: CategoryCardsViewControllerDelegate?

    lazy var backView: BackView = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    lazy var titleLabel: TitleLabel = .init()

    lazy var collectionCategory: UICollectionView = { collection in
        return collection
    }(UICollectionView(frame: .zero, collectionViewLayout: filterLayout()))

    init(category: CardCategory, cardsManager: UserCardsManager = .shared) {
        self.category = category
        self.cardsManager = cardsManager
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = category.shortTitle
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
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

private extension CategoryCardsViewController {
    func setupViews_unique() {
        view.backgroundColor = .clear
        backView.setupView(in: view)
        titleLabel.setupLabel(in: backView)
        backView.addSubview(collectionCategory)
        collectionCategory.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        collectionCategory.backgroundColor = .clear
        collectionCategory.delegate = self
        collectionCategory.dataSource = self
        collectionCategory.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.className)

        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(closeTapped_unique), for: .touchUpInside)
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileInfoDidUpdate(_:)), name: .profileInfoDidUpdate, object: nil)
    }

    func reloadData_unique() {
        categoryCards = cardsManager.cards(of: category)
        collectionCategory.reloadData()
    }

    func getCard(at indexPath: IndexPath) -> CardRepresentable? {
        guard let card = categoryCards[safe: indexPath.row] else { return nil }
        return card
    }

    func filterLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(162),
            heightDimension: .absolute(297)
        )

        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(297))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )

        return UICollectionViewCompositionalLayout(section: section)
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

extension CategoryCardsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCategory.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.className, for: indexPath) as? CardCollectionViewCell

        if let card = getCard(at: indexPath) {
            cell?.setupCard(card)
        }
//        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: categoryCards))

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension CategoryCardsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionCategory.deselectItem(at: indexPath, animated: true)

        guard let card = getCard(at: indexPath) else { return }
        delegate?.categoryCardsViewControllerDidSelectCard(card, in: self)
    }
}
