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
        label.setSize(fontS: .ubuntuMedium500, phone: 24, iPad: 30)
        return label
    }(UILabel())

    lazy var discloseButton: UIButton = { button in
        return button
    }(UIButton(type: .system))

    lazy var coverButton: UIImageView = { image in
        image.layer.cornerRadius = 14
        image.image = Images.disclose.image
        return image
    }(UIImageView())

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
        let coef = UIDevice.isIpad ? 1.5 : 1.388
        let itemHeight = itemWidth * coef

        return .init(width: itemWidth, height: itemHeight)
    }

    func setupSubviews_unique() {
        backgroundColor = .white
        cornerRadius = 12

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 24 : 16)
        }

        addSubview(discloseButton)
        discloseButton.snp.makeConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 40 : 28)
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
        }
        discloseButton.addSubview(coverButton)
        coverButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        addSubview(cardsCollectionView)
        cardsCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 30 : 20)
            $0.horizontalEdges.bottom.equalToSuperview()
            cardsViewHeightConstraint = $0.height.equalTo(0).constraint
        }
    }

    func updateCardsViewHeight() {
        cardsViewHeightConstraint?.update(offset: itemSize.height)
    }

    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = UIDevice.isIpad ? 20 : 12
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
