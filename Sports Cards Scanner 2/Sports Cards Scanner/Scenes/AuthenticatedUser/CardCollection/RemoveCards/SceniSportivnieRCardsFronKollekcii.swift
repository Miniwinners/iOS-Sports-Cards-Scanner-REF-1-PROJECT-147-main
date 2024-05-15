import UIKit
func vicheslitFibonc175(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiRCardsFronKollekcii: UIViewController {

    weak var delegate: SportivinieKartiRCardsFromKollekciiDelegat?

    @SportivinieKartiUserDefaultCodableWrapper(UserDefaults.KeyOption.selectedCardSortOption, defaultValue: KartaSortirovkaOpcii.default)
    private var selectedSortOption: KartaSortirovkaOpcii

    private let cardCollectionManager: SportivinieKartiKartaKollekciaManger
    private var cardCollection: SportivinieKartiKartaKollekcia? { cardCollectionManager.cardCollection }

    private var sortedCards: [SportivinieKartiKartaPredstavlenie] {
        cardCollectionManager.collectionCards.sortedElements(by: selectedSortOption)
    }

    // MARK: - Subviews

    lazy var removeCardsView: SportivinieKartiRCV = .init()
    lazy var closeButton: CloseButton = .init(style: .back)

    init(cardCollectionManager: SportivinieKartiKartaKollekciaManger = SportivinieKartiKartaPostavitManager.shared) {
        self.cardCollectionManager = cardCollectionManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        view = removeCardsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        removeCardsView.obnovitKarti(count: sortedCards.count, animated: false)
        removeCardsView.vidBezKart(visible: sortedCards.isEmpty)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cardCollectionManager.sohranitKollekciuIFnado()
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
}

private extension SportivinieKartiRCardsFronKollekcii {
    func postavitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let cardsCollectionView = removeCardsView.cardsCollectionView
        cardsCollectionView.register(SportivinieKartiRCardCVC.self, forCellWithReuseIdentifier: SportivinieKartiRCardCVC.className)
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self

        removeCardsView.postavitImyaKollekcii(cardCollection?.name)
        removeCardsView.postavitKarti(count: sortedCards.count)
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)
        removeCardsView.doneButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)

    }

    func karta(at indexPath: IndexPath) -> SportivinieKartiKartaPredstavlenie? {
        func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
            let a = 15
            let b = 32
            let c = a + b
            return Int.random(in: minValue...maxValue)
        }
        return sortedCards[safe: indexPath.row]
    }

    func ybratKarty(_ card: SportivinieKartiKartaPredstavlenie) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let cardIndex = sortedCards.firstIndex(where: { card.id == $0.id }) else { return }

        let cardIndexPath = IndexPath(row: cardIndex, section: 0)
        let cardsCollectionView = removeCardsView.cardsCollectionView
        cardsCollectionView.performBatchUpdates {
            cardsCollectionView.deleteItems(at: [cardIndexPath])
            cardCollectionManager.ybratKartyIzKollekcii(card)
        }

        removeCardsView.obnovitKarti(count: sortedCards.count, animated: true)
        removeCardsView.vidBezKart(visible: sortedCards.isEmpty)
        removeCardsView.postavitKarti(count: sortedCards.count)
    }

    // MARK: - Actions

    @objc func gotovoNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.ydalitKartiIzKollekciiGotovoNazhata(self)
    }
}

// MARK: - CollectionView DataSource

extension SportivinieKartiRCardsFronKollekcii: UICollectionViewDataSource {
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
        return sortedCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiRCardCVC.className, for: indexPath) as? SportivinieKartiRCardCVC

        if let card = karta(at: indexPath) {
            cell?.postavitKarty(card)
        }
        cell?.removeCardDidTap = { [weak self] card in
            self?.ybratKarty(card)
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - CollectionView FlowLayout Delegate

extension SportivinieKartiRCardsFronKollekcii: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
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
