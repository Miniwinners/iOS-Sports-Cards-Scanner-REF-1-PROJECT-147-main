import UIKit
import SnapKit

final class CardCollectionCardsView: UIView {

    lazy var nameLabel: UILabel = { label in
        label.font = .font(.interBold, size: 24)
        label.textColor = .labelColor
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var menuButton: UIButton = { button in
        button.setImage(Images.menuDots.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var infoContainerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var priceContainerView: UIView = .init()

    lazy var priceLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 16)
        label.textColor = .greenColor
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 16)
        label.textColor = .labelColor4
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardsTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 20
        return tableView
    }(UITableView())
    lazy var cardsCollectionView: UICollectionView = { collectionView in
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .clear
        return collectionView
    }(BaseCollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout()))
    lazy var cardsSwipeableView: SwipeableCardsView = .init()

    lazy var cardsDisplayControl: UISegmentedControl = CardsRepresentSegmentedControl(
        items: CardsDisplayOption.allCases.map { $0.image }
    )

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCollectionName(_ name: String?) {
        nameLabel.text = name
        nameLabel.setLineHeight(28)
    }

    func setCards(count: Int) {
        switch count {
        case 1:
            cardsNumberLabel.text = L10n.Portfolio.oneCard
        default:
            cardsNumberLabel.text = L10n.Portfolio.numberOfCards(count)
        }
        cardsNumberLabel.setLineHeight(22)
    }

    func setCards(price: Double) {
        priceLabel.text = price.formattedAsPrice
        priceLabel.setLineHeight(22)
    }

    func setCardsDisplay(option: CardsDisplayOption) {
        switch option {
        case .swipable: setupCardsViewIfNeeded(cardsSwipeableView)
        case .collection: setupCardsViewIfNeeded(cardsCollectionView)
        case .list: setupCardsViewIfNeeded(cardsTableView)
        }

        cardsSwipeableView.isHidden = option != .swipable
        cardsCollectionView.isHidden = option != .collection
        cardsTableView.isHidden = option != .list
    }

    func reloadCardsViews() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardsTableView.reloadData()
        cardsCollectionView.reloadData()
        cardsSwipeableView.reloadCardsData()
    }

    func showEstimatedValue() {
        guard priceContainerView.superview == nil else { return }

        infoContainerView.addSubview(priceContainerView)

        priceContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(cardsNumberLabel.snp.top).inset(-12)
        }
    }

    func hideEstimatedValue() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        priceContainerView.removeFromSuperview()
    }
}

private extension CardCollectionCardsView {
    func setupSubviews_unique() {
        backgroundColor = .backColor

        setupInfoContainer()
        setupPriceContainer()

        addSubviews(nameLabel, menuButton, infoContainerView)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(20)
        }
        menuButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(-10)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(44)
        }
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }

    func setupInfoContainer() {
        infoContainerView.addSubviews(cardsNumberLabel, cardsDisplayControl)
        cardsNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16).priority(.high)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(30)
        }
        cardsDisplayControl.snp.makeConstraints {
            $0.top.equalTo(cardsNumberLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(116)
            $0.height.equalTo(36)
        }
    }

    func setupPriceContainer() {
        let estimatedValueLabel = UILabel()
        estimatedValueLabel.font = .font(.interMedium, size: 16)
        estimatedValueLabel.text = L10n.CardCollection.estimatedValue
        estimatedValueLabel.textColor = .labelColor4
        estimatedValueLabel.setLineHeight(22)
        estimatedValueLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        estimatedValueLabel.setContentHuggingPriority(.required, for: .vertical)

        let underlineView = UIView()
        underlineView.backgroundColor = .dividerColor

        priceContainerView.addSubviews(estimatedValueLabel, priceLabel, underlineView)
        estimatedValueLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(estimatedValueLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }
        underlineView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(9)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func setupCardsViewIfNeeded(_ cardsView: UIView) {
        guard cardsView.superview == nil else { return }

        addSubview(cardsView)
        cardsView.snp.makeConstraints {
            $0.top.equalTo(infoContainerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            if cardsView === cardsSwipeableView {
                $0.bottom.equalTo(safeAreaLayoutGuide)
            } else {
                $0.bottom.equalToSuperview()
            }
        }
    }

    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 0, left: 20, bottom: 20, right: 20)
        return layout
    }
}
