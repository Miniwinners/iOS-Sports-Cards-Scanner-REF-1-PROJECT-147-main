import UIKit
import SnapKit
func vicheslitFibonc194(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

enum ShowHide {
    case show
    case hide
}
final class SportivinieKartiKartaKollekciiKartiVid: UIView {

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
        button.setImage(SportivinieKartiImages.menuDots.image, for: .normal)
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
    }(SportivinieKartiBaseCV(frame: .zero, collectionViewLayout: filterLayout()))
    lazy var cardsSwipeableView: SportivinieKartiSwipeKartiVide = .init()

    lazy var cardsDisplayControl: UISegmentedControl = SportivinieKartiKartiSegmentPresentCl(
        items: KartiDisplayOpcii.allCases.map { $0.image }
    )

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    override func layoutSubviews() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        super.layoutSubviews()
        customContainer.sdelatGranici()
    }

    func postavitImyaKollekcii(_ name: String?) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        titleView.text = name
    }

    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }

    func postavitKarti(count: Int) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        switch count {
        case 1:
            cardsNumberLabel.text = L10n.Portfolio.oneCard
        default:
            cardsNumberLabel.text = L10n.Portfolio.numberOfCards(count)
        }
        cardsNumberLabel.setVisotaLabla(UIDevice.isIpad ? 28:22)
    }

    func postavitKarti(price: Double) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        customContainer.priceLabel.text = price.formattedAsPrice
        customContainer.priceLabel.setVisotaLabla(UIDevice.isIpad ? 28:22)
    }

    func postavitKartDisplay(option: KartiDisplayOpcii) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        print("Текущий индекс: \(index)")

        switch option {
        case .swipable: postavitVidKartiIFnedded(cardsSwipeableView)
        case .collection: postavitVidKartiIFnedded(cardsCollectionView)
        case .list: postavitVidKartiIFnedded(cardsTableView)
        }
        cardsSwipeableView.isHidden = option != .swipable
        cardsCollectionView.isHidden = option != .collection
        cardsTableView.isHidden = option != .list
    }

    func reloadVidKart() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardsTableView.reloadData()
        cardsCollectionView.reloadData()
        cardsSwipeableView.obnovitDatyKart()
    }

    func spryatatZnachenie() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        isShown = .show
        topConstraint = UIDevice.isIpad ? 130 : 90
        customContainer.postavitLayout(in: self, top: infoContainerView)
        bringSubviewToFront(menuButton)
        reloadMaket()
        setNeedsLayout()
        layoutIfNeeded()
    }

    func pokazatZnachenie() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        isShown = .hide
        topConstraint = UIDevice.isIpad ? 40 : 20
        customContainer.removeFromSuperview()
        reloadMaket()
        setNeedsLayout()
        layoutIfNeeded()
    }

    func reloadMaket() {
        let displayOption = KartiDisplayOpcii(by: index)!
        postavitKartDisplay(option: displayOption)
    }

}

private extension SportivinieKartiKartaKollekciiKartiVid {
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear

        postavitContainer()
        postavitContainerCeni()

        titleView.postavitLabel(in: self)

        addSubview(infoContainerView)
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        addSubview(menuButton)
        menuButton.snp.makeConstraints { make in
            make.top.equalTo(infoContainerView.snp.bottom).offset(UIDevice.isIpad ? 60 : 40)
            make.size.equalTo(UIDevice.isIpad ? 40:24)
            make.right.equalToSuperview().inset(UIDevice.isIpad ? 90:30)
        }

        customContainer.postavitLayout(in: self, top: infoContainerView)

    }

    func postavitContainer() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
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

    func postavitContainerCeni() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        customContainer.estimatedValueLabel.text = L10n.CardCollection.estimatedValue
    }

    func postavitVidKartiIFnedded(_ cardsView: UIView) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
//        guard cardsView.superview == nil else { return }
        addSubview(cardsView)
        let insetShow: CGFloat = UIDevice.isIpad ? 130:90
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
extension SportivinieKartiKartaKollekciiKartiVid {
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
