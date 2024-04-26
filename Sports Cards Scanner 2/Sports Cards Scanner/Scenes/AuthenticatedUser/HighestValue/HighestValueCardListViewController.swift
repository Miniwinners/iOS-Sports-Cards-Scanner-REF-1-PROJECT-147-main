import UIKit
import SnapKit
final class HighestValueCardListViewController: UIViewController {

    private let cardsManager: UserCardsManager
    private var highestValueCards: [CardRepresentable] = []

    weak var delegate: HighestValueListViewControllerDelegate?

    lazy var closeButton: CloseButton = .init(style: .close)
    lazy var titleLabel: TitleLabel = .init()
    lazy var backView: BackView = .init()
    lazy var collectionViewValue: UICollectionView = { collection in

        return collection
    }(UICollectionView(frame: .zero, collectionViewLayout: filterLayout()))
    init(cardsManager: UserCardsManager = .shared) {
        self.cardsManager = cardsManager
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = L10n.HighestValue.title
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

private extension HighestValueCardListViewController {
    func setupViews_unique() {
        view.backgroundColor = .clear
        backView.setupView(in: view)
        titleLabel.setupLabel(in: backView)
        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(closeTapped_unique), for: .touchUpInside)

        backView.addSubview(collectionViewValue)
        collectionViewValue.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40 : 20)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80: 0)
        }
        collectionViewValue.delegate = self
        collectionViewValue.dataSource = self
        collectionViewValue.backgroundColor = .clear
        collectionViewValue.showsVerticalScrollIndicator = false
        collectionViewValue.contentInset.bottom = 20
        collectionViewValue.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.className)
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileInfoDidUpdate(_:)), name: .profileInfoDidUpdate, object: nil)
    }

    func reloadData_unique() {
        highestValueCards = cardsManager.highestValuedCards(count: 10)
        collectionViewValue.reloadData()
    }

    func getCard(at indexPath: IndexPath) -> CardRepresentable? {
        guard let card = highestValueCards[safe: indexPath.row] else { return nil }
        return card
    }

    func filterLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(UIDevice.isIpad ? 253: 162),
            heightDimension: .absolute(UIDevice.isIpad ? 464: 297)
        )

        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(UIDevice.isIpad ? 464:297))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: UIDevice.isIpad ? 3:2)
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

extension HighestValueCardListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return highestValueCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewValue.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell.className,
            for: indexPath
        ) as? CardCollectionViewCell

        if let card = getCard(at: indexPath) {
            cell?.setupCard(card)
        }
        cell?.setCardsNumber(indexPath.row + 1)
//        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: highestValueCards))

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension HighestValueCardListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewValue.deselectItem(at: indexPath, animated: true)

        guard let card = getCard(at: indexPath) else { return }
        delegate?.highestValueListViewControllerDidSelectCard(card, in: self)
    }
}
