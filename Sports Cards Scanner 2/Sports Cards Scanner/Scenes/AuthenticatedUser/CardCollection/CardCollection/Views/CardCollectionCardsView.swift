import UIKit
import SnapKit

final class CardCollectionCardsView: UIView {

    lazy var titleView: TitleLabel = .init()

    lazy var customContainer: CustomContainerView = .init()

    lazy var infoContainerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 22)
        label.textColor = .black
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
        tableView.sectionHeaderTopPadding = 8
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
        titleView.text = name
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
        customContainer.priceLabel.text = price.formattedAsPrice
        customContainer.priceLabel.setLineHeight(22)
    }

    func setCardsDisplay(option: CardsDisplayOption) {
        switch option {
        case .swipable: setupCardsViewIfNeeded(cardsSwipeableView)
        case .collection: setupCardsViewIfNeeded(cardsCollectionView)
        case .list: setupCardsViewIfNeeded(cardsTableView)
        }
//        cardsSwipeableView.backgroundColor = .red
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
        guard customContainer.priceContainerView.superview == nil else { return }

    }

    func hideEstimatedValue() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        customContainer.priceContainerView.removeFromSuperview()
    }
}

private extension CardCollectionCardsView {
    func setupSubviews_unique() {
        backgroundColor = .clear

        setupInfoContainer()
        setupPriceContainer()

        titleView.setupLabel(in: self)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
        }
        addSubview(infoContainerView)
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        customContainer.setupLayout(in: self, top: infoContainerView)

    }

    func setupInfoContainer() {
        infoContainerView.addSubviews(cardsNumberLabel, cardsDisplayControl)
        cardsNumberLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        cardsDisplayControl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(116)
            $0.height.equalTo(36)
        }
    }

    func setupPriceContainer() {
        customContainer.estimatedValueLabel.text = L10n.CardCollection.estimatedValue

    }

    func setupCardsViewIfNeeded(_ cardsView: UIView) {
        guard cardsView.superview == nil else { return }

        addSubview(cardsView)
        cardsView.snp.makeConstraints {
            $0.top.equalTo(customContainer.snp.bottom).offset(20)
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
