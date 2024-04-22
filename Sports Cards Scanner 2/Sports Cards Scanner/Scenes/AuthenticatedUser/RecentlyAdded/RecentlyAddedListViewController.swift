import UIKit
import SnapKit

final class RecentlyAddedListViewController: UIViewController {
    weak var delegate: RecentlyAddedListViewControllerDelegate?

    private let cardsManager: UserCardsManager
    private var recentlyAddedCards: [CardRepresentable] = []

    lazy var titleLabel: TitleLabel = .init()
    lazy var backView: BackView = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    lazy var collectionRecent: BaseCollectionView = { collection in
        return collection
    }(BaseCollectionView())

    init(cardsManager: UserCardsManager = .shared) {
        self.cardsManager = cardsManager
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = L10n.RecentlyAdded.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        collectionRecent = BaseCollectionView(frame: .zero, collectionViewLayout: filterLayout())
    }

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
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
    }
}

private extension RecentlyAddedListViewController {
    func setupViews_unique() {
        view.backgroundColor = .clear
        backView.setupView(in: view)
        titleLabel.setupLabel(in: backView)
        backView.addSubview(collectionRecent)
        collectionRecent.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        collectionRecent.delegate = self
        collectionRecent.dataSource = self
        collectionRecent.backgroundColor = .white
        collectionRecent.showsVerticalScrollIndicator = false
        collectionRecent.register(CardPhotoCollectionViewCell.self, forCellWithReuseIdentifier: CardPhotoCollectionViewCell.className)

        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(closeTapped_unique), for: .touchUpInside)
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileInfoDidUpdate(_:)), name: .profileInfoDidUpdate, object: nil)
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

    func reloadData_unique() {
        recentlyAddedCards = cardsManager.recentlyAddedCards()
        collectionRecent.reloadData()
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

extension RecentlyAddedListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recentlyAddedCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardPhotoCollectionViewCell.className, for: indexPath) as? CardPhotoCollectionViewCell

        if let card = card(at: indexPath) {
            cell?.setCard(card)
        }

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let inRowItems: CGFloat = 2
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
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoCollectionViewCell
        cell?.setCellHighlighted(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoCollectionViewCell
        cell?.setCellHighlighted(false)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let card = card(at: indexPath) else { return }
        delegate?.recentlyAddedListViewControllerDidSelectCard(card, in: self)
    }
}
extension RecentlyAddedListViewController: UICollectionViewDelegate {

}
