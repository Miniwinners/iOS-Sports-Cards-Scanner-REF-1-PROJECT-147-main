import UIKit

final class RemoveCardsFromCollectionVC: UIViewController {

    weak var delegate: RemoveCardsFromCollectionVCDelegate?

    @UserDefaultCodable(UserDefaults.KeyOption.selectedCardSortOption, defaultValue: CardSortOption.default)
    private var selectedSortOption: CardSortOption

    private let cardCollectionManager: CardCollectionManager
    private var cardCollection: CardCollection? { cardCollectionManager.cardCollection }

    private var sortedCards: [CardRepresentable] {
        cardCollectionManager.collectionCards.sortedElements(by: selectedSortOption)
    }

    // MARK: - Subviews

    lazy var removeCardsView: RemoveCardsView = .init()

    init(cardCollectionManager: CardCollectionManager = CardSetsManager.shared) {
        self.cardCollectionManager = cardCollectionManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = removeCardsView
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        removeCardsView.updateCards(count: sortedCards.count, animated: false)
        removeCardsView.setNoCardsView(visible: sortedCards.isEmpty)
    }

    override func viewWillDisappear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewWillDisappear(animated)
        cardCollectionManager.saveCollectionIfNeeded()
    }

}

private extension RemoveCardsFromCollectionVC {
    func setupViews_unique() {
        let cardsCollectionView = removeCardsView.cardsCollectionView
        cardsCollectionView.register(RemovableCardCollectionViewCell.self, forCellWithReuseIdentifier: RemovableCardCollectionViewCell.className)
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self

        removeCardsView.setCollectionName(cardCollection?.name)
        removeCardsView.setCards(count: sortedCards.count)
    }

    func setupActions_unique() {
        removeCardsView.doneButton.addTarget(self, action: #selector(doneTapped_unique), for: .touchUpInside)
    }

    func card(at indexPath: IndexPath) -> CardRepresentable? {
        sortedCards[safe: indexPath.row]
    }

    func removeCard(_ card: CardRepresentable) {
        guard let cardIndex = sortedCards.firstIndex(where: { card.id == $0.id }) else { return }

        let cardIndexPath = IndexPath(row: cardIndex, section: 0)
        let cardsCollectionView = removeCardsView.cardsCollectionView
        cardsCollectionView.performBatchUpdates {
            cardsCollectionView.deleteItems(at: [cardIndexPath])
            cardCollectionManager.removeCardFromCollection(card)
        }

        removeCardsView.updateCards(count: sortedCards.count, animated: true)
        removeCardsView.setNoCardsView(visible: sortedCards.isEmpty)
        removeCardsView.setCards(count: sortedCards.count)
    }

    // MARK: - Actions

    @objc func doneTapped_unique() {
        delegate?.removeCardsFromCollectionVCDoneTapped(self)
    }
}

// MARK: - CollectionView DataSource

extension RemoveCardsFromCollectionVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return sortedCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RemovableCardCollectionViewCell.className, for: indexPath) as? RemovableCardCollectionViewCell

        if let card = card(at: indexPath) {
            cell?.setCard(card)
        }
        cell?.removeCardDidTap = { [weak self] card in
            self?.removeCard(card)
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - CollectionView FlowLayout Delegate

extension RemoveCardsFromCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let horizontalSpacing = (flowLayout?.sectionInset.left ?? 0) + (flowLayout?.sectionInset.right ?? 0)
        let itemsInRow: CGFloat = 3
        let interitemSpacing = flowLayout?.minimumInteritemSpacing ?? 0
        let itemWidth = (collectionViewWidth - horizontalSpacing - interitemSpacing * (itemsInRow - 1)) / itemsInRow
        let photoWidth = itemWidth - 6
        let photoHeight = photoWidth * 1.388
        let itemHeight = photoHeight + 6
        return .init(width: itemWidth, height: itemHeight)
    }
}
