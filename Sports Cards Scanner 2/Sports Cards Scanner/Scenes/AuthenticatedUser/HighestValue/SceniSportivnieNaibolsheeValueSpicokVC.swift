import UIKit
import SnapKit
func vicheslitFibonc270(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiNaibolsheeValueSpicokController: UIViewController {

    private let cardsManager: SportivinieKartiUserKartManager
    private var highestValueCards: [SportivinieKartiKartaPredstavlenie] = []

    weak var delegate: SportivinieKartiNaibolsheeValueSpicokDelegat?

    lazy var closeButton: CloseButton = .init(style: .close)
    lazy var titleLabel: TitleLabel = .init()
    lazy var backView: BackView = .init()
    lazy var collectionViewValue: UICollectionView = { collection in

        return collection
    }(UICollectionView(frame: .zero, collectionViewLayout: filterLayout()))
    init(cardsManager: SportivinieKartiUserKartManager = .shared) {
        self.cardsManager = cardsManager
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = L10n.HighestValue.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        super.viewDidLoad()
        postavitVid()
        subscribeToNotifications()
        perezagryzitDaty()
    }

    override func viewWillAppear(_ animated: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

private extension SportivinieKartiNaibolsheeValueSpicokController {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        view.backgroundColor = .clear
        backView.postavitVid(in: view)
        titleLabel.postavitLabel(in: backView)
        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)

        backView.addSubview(collectionViewValue)
        collectionViewValue.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40 : 20)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 60: 0)
        }
        collectionViewValue.delegate = self
        collectionViewValue.dataSource = self
        collectionViewValue.backgroundColor = .clear
        collectionViewValue.showsVerticalScrollIndicator = false
        collectionViewValue.contentInset.bottom = 25
        collectionViewValue.register(SportivinieKartiCardCollectionKletka.self, forCellWithReuseIdentifier: SportivinieKartiCardCollectionKletka.className)
    }

    func subscribeToNotifications() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        NotificationCenter.default.addObserver(self, selector: #selector(profilInfoDidObnovilos(_:)), name: .profileInfoDidUpdate, object: nil)
    }

    func perezagryzitDaty() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        highestValueCards = cardsManager.naibolsheeZnachenieKarti(count: 10)
        collectionViewValue.reloadData()
    }

    func getCard(at indexPath: IndexPath) -> SportivinieKartiKartaPredstavlenie? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let card = highestValueCards[safe: indexPath.row] else { return nil }
        return card
    }

    func filterLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(UIDevice.isIpad ? 270: 162),
            heightDimension: .absolute(UIDevice.isIpad ? 455: 317)

        )

        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(UIDevice.isIpad ? 455:317))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: UIDevice.isIpad ? 3:2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(20)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = .init(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )

        return UICollectionViewCompositionalLayout(section: section)
    }
    // MARK: - Actions

    @objc func zakritNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.highestValueListViewControllerzakrtiNazhata(self)
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

// MARK: - TableView DataSource

extension SportivinieKartiNaibolsheeValueSpicokController: UICollectionViewDataSource {
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
        return highestValueCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let cell = collectionViewValue.dequeueReusableCell(
            withReuseIdentifier: SportivinieKartiCardCollectionKletka.className,
            for: indexPath
        ) as? SportivinieKartiCardCollectionKletka

        if let card = getCard(at: indexPath) {
            cell?.postavitKarty(card)
        }
        cell?.postavitKarteChislo(indexPath.row + 1)

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiNaibolsheeValueSpicokController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        collectionViewValue.deselectItem(at: indexPath, animated: true)

        guard let card = getCard(at: indexPath) else { return }
        delegate?.highestValueListViewControllerDidSelectCard(card, in: self)
    }
}
