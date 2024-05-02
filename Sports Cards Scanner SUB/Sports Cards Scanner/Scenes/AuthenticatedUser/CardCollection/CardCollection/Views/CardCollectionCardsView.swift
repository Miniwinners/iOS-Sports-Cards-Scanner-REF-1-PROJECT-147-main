import UIKit
import SnapKit
enum ShowHide {
    case show
    case hide
}
final class CardCollectionCardsView: UIView {

    private var topConstraint: CGFloat?
    var index: Int = 2
    var isShown: ShowHide?
    lazy var titleView: TitleLabel = .init()

    lazy var customContainer: CustomContainerView = .init()

    lazy var infoContainerView: UIView = { view in
        view.backgroundColor = .white
        return view
    }(UIView())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 28:22)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var menuButton: UIButton = { button in
        button.setImage(Images.menuDots.image, for: .normal)
        button.tintColor = .black
        return button
    }(UIButton(type: .system))

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
    }(BaseCollectionView(frame: .zero, collectionViewLayout: filterLayout()))
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
        cardsNumberLabel.setLineHeight(UIDevice.isIpad ? 28:22)
    }

    func setCards(price: Double) {
        customContainer.priceLabel.text = price.formattedAsPrice
        customContainer.priceLabel.setLineHeight(UIDevice.isIpad ? 28:22)
    }

    func setCardsDisplay(option: CardsDisplayOption) {
        print("Текущий индекс: \(index)")

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
        isShown = .show
        topConstraint = UIDevice.isIpad ? 200 : 160
        customContainer.setupLayout(in: self, top: infoContainerView)
        bringSubviewToFront(menuButton)
        reloadMaket()
        setNeedsLayout()
        layoutIfNeeded()
    }

    func hideEstimatedValue() {
        isShown = .hide
        topConstraint = UIDevice.isIpad ? 40 : 20
        customContainer.removeFromSuperview()
        reloadMaket()
        setNeedsLayout()
        layoutIfNeeded()
    }

    func reloadMaket() {
        let displayOption = CardsDisplayOption(by: index)!
        setCardsDisplay(option: displayOption)
    }

}

private extension CardCollectionCardsView {
    func setupSubviews_unique() {
        backgroundColor = .clear

        setupInfoContainer()
        setupPriceContainer()

        titleView.setupLabel(in: self)

        addSubview(infoContainerView)
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        addSubview(menuButton)
        menuButton.snp.makeConstraints { make in
            make.top.equalTo(infoContainerView.snp.bottom).offset(UIDevice.isIpad ? 50 : 30)
            make.size.equalTo(UIDevice.isIpad ? 40:24)
            make.right.equalToSuperview().inset(UIDevice.isIpad ? 90:30)
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
            $0.width.equalTo(UIDevice.isIpad ? 195:116)
            $0.height.equalTo(UIDevice.isIpad ? 60:36)
        }
    }

    func setupPriceContainer() {
        customContainer.estimatedValueLabel.text = L10n.CardCollection.estimatedValue
    }

    func setupCardsViewIfNeeded(_ cardsView: UIView) {
//        guard cardsView.superview == nil else { return }
        addSubview(cardsView)
        let insetShow: CGFloat = UIDevice.isIpad ? 180:160
        let insetHide: CGFloat = UIDevice.isIpad ? 40:20
        cardsView.snp.remakeConstraints {

            switch isShown {
            case .show:
                $0.top.equalTo(menuButton.snp.bottom).offset(topConstraint ?? insetShow)
            case .hide:
                $0.top.equalTo(menuButton.snp.bottom).offset(topConstraint ?? insetHide)
            default: break
            }
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 60:0)
            if cardsView === cardsSwipeableView {
                $0.bottom.equalTo(safeAreaLayoutGuide)
            } else {
                $0.bottom.equalToSuperview()
            }
        }
    }
}
extension CardCollectionCardsView {
    func filterLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(UIDevice.isIpad ? 253: 162),
            heightDimension: .absolute(UIDevice.isIpad ? 464: 317)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(UIDevice.isIpad ? 464:317))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: UIDevice.isIpad ? 3:2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(
            top: 0,
            leading: 20,
            bottom: 0,
            trailing: 20
        )
        return UICollectionViewCompositionalLayout(section: section)
    }
}
