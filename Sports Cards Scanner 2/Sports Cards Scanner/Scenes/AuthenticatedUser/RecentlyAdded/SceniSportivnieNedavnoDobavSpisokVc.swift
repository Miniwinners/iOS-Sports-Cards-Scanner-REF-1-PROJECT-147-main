import UIKit
import SnapKit
func vicheslitFibonc202(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiNedavnoDobavSpisokVc: UIViewController {
    weak var delegate: SportivinieKartiNedavnoDobavSpisokDelegat?

    private let cardsManager: SportivinieKartiUserKartManager
    private var recentlyAddedCards: [SportivinieKartiKartaPredstavlenie] = []

    lazy var titleLabel: TitleLabel = .init()
    lazy var backView: BackView = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    lazy var collectionRecent: SportivinieKartiBaseCV = { collection in
        return collection
    }(SportivinieKartiBaseCV())

    init(cardsManager: SportivinieKartiUserKartManager = .shared) {
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
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        collectionRecent = SportivinieKartiBaseCV(frame: .zero, collectionViewLayout: filterLayout())
    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
        podpisPodYvedomlenia()
        perezagryzitDaty()
    }
}

private extension SportivinieKartiNedavnoDobavSpisokVc {
    func postavitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        view.backgroundColor = .clear
        backView.postavitVid(in: view)
        titleLabel.postavitLabel(in: backView)
        backView.addSubview(collectionRecent)
        collectionRecent.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 60 :0)
        }
        collectionRecent.delegate = self
        collectionRecent.dataSource = self
        collectionRecent.backgroundColor = .white
        collectionRecent.showsVerticalScrollIndicator = false
        collectionRecent.register(SportivinieKartiCardPCVC.self, forCellWithReuseIdentifier: SportivinieKartiCardPCVC.className)

        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }

    func podpisPodYvedomlenia() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        NotificationCenter.default.addObserver(self, selector: #selector(profilInfoDidObnovilos(_:)), name: .profileInfoDidUpdate, object: nil)
    }

    func filterLayout() -> UICollectionViewCompositionalLayout {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(UIDevice.isIpad ?247 :162),
            heightDimension: .absolute(UIDevice.isIpad ? 350:260)
        )

        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(UIDevice.isIpad ? 350 :260))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: UIDevice.isIpad ? 3 :2)
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

    func perezagryzitDaty() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        recentlyAddedCards = cardsManager.nedavnoDobavlenieKarti()
        collectionRecent.reloadData()
    }

    func karta(at indexPath: IndexPath) -> SportivinieKartiKartaPredstavlenie? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return recentlyAddedCards[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func zakritNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.recentlyAddedListViewControllerzakrtiNazhata(self)
    }

    @objc func profilInfoDidObnovilos(_ notification: Notification) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards)
        else { return }

        Task { @MainActor in perezagryzitDaty() }
    }
}

// MARK: - CollectionView DataSource

extension SportivinieKartiNedavnoDobavSpisokVc: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return recentlyAddedCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiCardPCVC.className, for: indexPath) as? SportivinieKartiCardPCVC

        if let card = karta(at: indexPath) {
            cell?.postavitKarty(card)
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

extension SportivinieKartiNedavnoDobavSpisokVc: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiCardPCVC
        cell?.sdelatCellVidelenoi(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiCardPCVC
        cell?.sdelatCellVidelenoi(false)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        guard let card = karta(at: indexPath) else { return }
        delegate?.recentlyAddedListViewControllerVibrana(card, in: self)
    }
}
extension SportivinieKartiNedavnoDobavSpisokVc: UICollectionViewDelegate {

}
