import UIKit
func vicheslitFibonc264(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKolodaController: UIViewController {

    @SportivinieKartiUserDefaultCodableWrapper(UserDefaults.KeyOption.selectedCardSortOption, defaultValue: KartaSortirovkaOpcii.default)
    private var selectedSortOption: KartaSortirovkaOpcii

    weak var delegate: KartaKolodaDelegat?

    private let cardDeckManager: SportivinieKartiCardDeckManager
    private var cardDeck: SportivinieKartiCartaKoloda? { cardDeckManager.cardDeck }

    private var sortedCards: [SportivinieKartiKartaPredstavlenie] = []

    // MARK: - Subviews

    lazy var cardDeckView: SportivinieKartiKolodaVid = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    init(cardDeckManager: SportivinieKartiCardDeckManager = SportivinieKartiKartaPostavitManager.shared) {
        self.cardDeckManager = cardDeckManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = cardDeckView
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()

        postavitVid()
        postavidDeistviaUnicalno()
        perezagryzitDaty()
        podpisNaYvedomlenia()
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

private extension SportivinieKartiKolodaController {
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
        let cardsView = cardDeckView.collectionCards
        cardsView.register(SportivinieKartiCardCollectionKletka.self, forCellWithReuseIdentifier: SportivinieKartiCardCollectionKletka.className)
        cardsView.dataSource = self
        cardsView.delegate = self
        closeButton.setCenter(in: view)
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
        cardDeckView.menuButton.addTarget(self, action: #selector(menuNazhata), for: .touchUpInside)
        cardDeckView.addCardsButton.addTarget(self, action: #selector(dobavitNazhata), for: .touchUpInside)
    }

    func podpisNaYvedomlenia() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(profilInfoDidObnovilos(_:)), name: .profileInfoDidUpdate, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(vibratOpciiSortirovki),
            name: .init(rawValue: UserDefaults.KeyOption.selectedCardSortOption),
            object: nil
        )
    }

    func perezagryzitDaty() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        sortedCards = cardDeckManager.deckCards.sortedElements(by: selectedSortOption)

        cardDeckView.setDeck(name: cardDeck?.name)
        cardDeckView.setKarti(count: sortedCards.count)
        cardDeckView.setKarti(price: cardDeckManager.deckCardsValue)
        cardDeckView.collectionCards.reloadData()
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

    // MARK: - Actions

    @objc func zakritNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.cardDeckViewControllerzakrtiNazhata(self)
    }

    @objc func menuNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let cardDeck = cardDeck else { return }
        delegate?.kartaKolodaMenuNazhata(for: cardDeck, in: self)
    }

    @objc func dobavitNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.kartaKolodaDobavitKartiNazhata(self)
    }

    @objc func profilInfoDidObnovilos(_ notification: Notification) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards) || fields.contains(.deck)
        else { return }

        Task { @MainActor in
            perezagryzitDaty()
        }
    }

    @objc func vibratOpciiSortirovki() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        Task { @MainActor in
            perezagryzitDaty()
        }
    }
}

// MARK: - TableView DataSource

extension SportivinieKartiKolodaController: UICollectionViewDataSource {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiCardCollectionKletka.className, for: indexPath) as? SportivinieKartiCardCollectionKletka
        if let card = karta(at: indexPath) {
            cell?.postavitKarty(card)
        }
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiKolodaController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        collectionView.deselectItem(at: indexPath, animated: true)

        guard let card = karta(at: indexPath) else { return }
        delegate?.kartaKolodaDidVibrana(card, in: self)
    }
}

extension SportivinieKartiKolodaController: SportivinieKartiSwaipProtocol {
    var isSwipeBackEnabled: Bool { false }
}
