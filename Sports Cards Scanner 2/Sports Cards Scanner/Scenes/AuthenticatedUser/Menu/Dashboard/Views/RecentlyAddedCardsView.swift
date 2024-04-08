import UIKit
import SnapKit

final class RecentlyAddedCardsView: UIView {

    weak var delegate: UICollectionViewDelegate?

    private static let itemInRow = 3

    private var recentlyAddedCards: [CardRepresentable] = []

    private var cardsViewHeightConstraint: Constraint?

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Dashboard.recentlyAdded
        label.textColor = .labelColor
        label.font = .font(.interMedium, size: 20)
        label.setLineHeight(22)
        return label
    }(UILabel())

    lazy var discloseButton: UIButton = { button in
        button.setImage(Images.disclose.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var underlineView: UIView = { view in
        view.backgroundColor = .dividerColor
        return view
    }(UIView())

    lazy var cardsCollectionView: UICollectionView = { collectionView in
        collectionView.register(CardPhotoCollectionViewCell.self, forCellWithReuseIdentifier: CardPhotoCollectionViewCell.className)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }(BaseCollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout()))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setRecentlyAddedCards(_ cards: [CardRepresentable]) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        self.recentlyAddedCards = cards
        cardsCollectionView.reloadData()
    }

    override func layoutSubviews() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.layoutSubviews()
        updateCardsViewHeight()
    }
}

private extension RecentlyAddedCardsView {
    var itemSize: CGSize {
        let layout = cardsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let spacing = layout?.minimumInteritemSpacing ?? 0
        let spacings = CGFloat(Self.itemInRow - 1) * spacing

        let collectionViewWidth = cardsCollectionView.bounds.width
        let itemsWidth = collectionViewWidth - spacings
        let itemWidth = itemsWidth / CGFloat(Self.itemInRow)
        let itemHeight = itemWidth * 1.388

        return .init(width: itemWidth, height: itemHeight)
    }

    func setupSubviews_unique() {
        backgroundColor = .white
        cornerRadius = 12

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }

        addSubview(discloseButton)
        discloseButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.top.trailing.equalToSuperview().inset(6)
        }

        addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        addSubview(cardsCollectionView)
        cardsCollectionView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview().inset(16)
            cardsViewHeightConstraint = $0.height.equalTo(0).constraint
        }
    }

    func updateCardsViewHeight() {
        cardsViewHeightConstraint?.update(offset: itemSize.height)
    }

    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 0
        return layout
    }

    func card(at indexPath: IndexPath) -> CardRepresentable? {
        recentlyAddedCards[safe: indexPath.row]
    }
}

extension RecentlyAddedCardsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return recentlyAddedCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardPhotoCollectionViewCell.className, for: indexPath) as? CardPhotoCollectionViewCell

        if let card = card(at: indexPath) {
            cell?.setCard(card)
        }

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoCollectionViewCell
        cell?.setCellHighlighted(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoCollectionViewCell
        cell?.setCellHighlighted(false)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
}
