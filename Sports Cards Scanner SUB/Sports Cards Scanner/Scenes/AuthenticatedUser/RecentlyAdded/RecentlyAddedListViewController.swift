import UIKit

final class RecentlyAddedListViewController: UICollectionViewController {
    weak var delegate: RecentlyAddedListViewControllerDelegate?

    private let cardsManager: UserCardsManager
    private var recentlyAddedCards: [CardRepresentable] = []

    init(cardsManager: UserCardsManager = .shared) {
        self.cardsManager = cardsManager

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 0, left: 20, bottom: 20, right: 20)
        super.init(collectionViewLayout: layout)

        title = L10n.RecentlyAdded.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        collectionView = BaseCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }

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

private extension RecentlyAddedListViewController {
    func setupViews_unique() {
        navigationItem.rightBarButtonItem = .init(
            image: Images.close.image,
            style: .plain,
            target: self,
            action: #selector(closeTapped_unique)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black

        collectionView.backgroundColor = .backColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CardPhotoCollectionViewCell.self, forCellWithReuseIdentifier: CardPhotoCollectionViewCell.className)
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileInfoDidUpdate(_:)), name: .profileInfoDidUpdate, object: nil)
    }

    func reloadData_unique() {
        recentlyAddedCards = cardsManager.recentlyAddedCards()
        collectionView.reloadData()
    }

    func card(at indexPath: IndexPath) -> CardRepresentable? {
        recentlyAddedCards[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func closeTapped_unique() {
        delegate?.recentlyAddedListViewControllerCloseTapped(self)
    }

    @objc func profileInfoDidUpdate(_ notification: Notification) {
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards)
        else { return }

        Task { @MainActor in reloadData_unique() }
    }
}

// MARK: - CollectionView DataSource

extension RecentlyAddedListViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recentlyAddedCards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardPhotoCollectionViewCell.className, for: indexPath) as? CardPhotoCollectionViewCell

        if let card = card(at: indexPath) {
            cell?.setCard(card)
        }

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let inRowItems: CGFloat = 3
        let interitemSpace = flowLayout?.minimumInteritemSpacing ?? 0
        let interitemSpaces = interitemSpace * (inRowItems - 1)
        let horizontalSpaces = (flowLayout?.sectionInset.left ?? 0) + (flowLayout?.sectionInset.right ?? 0)
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = (collectionViewWidth - interitemSpaces - horizontalSpaces) / inRowItems
        let itemHeight = itemWidth * 1.39
        return .init(width: itemWidth, height: itemHeight)
    }
}

// MARK: - CollectionView Layout Delegate

extension RecentlyAddedListViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoCollectionViewCell
        cell?.setCellHighlighted(true)
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoCollectionViewCell
        cell?.setCellHighlighted(false)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let card = card(at: indexPath) else { return }
        delegate?.recentlyAddedListViewControllerDidSelectCard(card, in: self)
    }
}
