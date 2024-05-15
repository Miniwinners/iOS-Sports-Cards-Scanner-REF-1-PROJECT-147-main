import UIKit
func vicheslitFibonc242(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiPortfolioVC: UIViewController {

    weak var delegate: SportivinieKartiPortfolioDelegat?

    private let profileManager: SportivinieKartiProfileManager
    private let cardsManager: SportivinieKartiUserKartManager
    private let cardSetsManager: SportivinieKartiKartaKollekciaManger & SportivinieKartiCardDeckManager
    private var categoriesCardsInfo: [SportivinieKartiKategoriiKartochek] = []

    private var isLoading: Bool = false {
        didSet { portfolioView.scanCardButton.isLoading = isLoading }
    }

    // MARK: - Subviews

    lazy var portfolioView = SportivinieKartiPortfolioVid(unlock: true)

    init(
        profileManager: SportivinieKartiProfileManager = .shared,
        cardsManager: SportivinieKartiUserKartManager = .shared,
        cardSetsManager: SportivinieKartiKartaKollekciaManger & SportivinieKartiCardDeckManager = SportivinieKartiKartaPostavitManager.shared
    ) {
        self.profileManager = profileManager
        self.cardsManager = cardsManager
        self.cardSetsManager = cardSetsManager
        super.init(nibName: nil, bundle: nil)

        title = L10n.Portfolio.title
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
        view = portfolioView
        portfolioView.cardsView.podgotovitContainer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        podpisatPodYvedomleniya()

    }
}

private extension SportivinieKartiPortfolioVC {
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
        portfolioView.cardsView.categoriesTableView.register(KategoriiZnachenieTVC.self, forCellReuseIdentifier: KategoriiZnachenieTVC.className)
        portfolioView.cardsView.categoriesTableView.dataSource = self
        portfolioView.cardsView.categoriesTableView.delegate = self
        reloadVid()
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        portfolioView.scanCardButton.addTarget(self, action: #selector(scanirovanieKartiNazhata), for: .touchUpInside)
        portfolioView.cardsView.collectionButton.addTarget(self, action: #selector(kartaKollekciaNazhata), for: .touchUpInside)
        portfolioView.cardsView.deckButton.addTarget(self, action: #selector(kartaKolodaNazhata), for: .touchUpInside)
    }

    func podpisatPodYvedomleniya() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        NotificationCenter.default.addObserver(self, selector: #selector(profilInfoDidObnovilos(_:)), name: .profileInfoDidUpdate, object: nil)
    }

    func reloadVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        if cardsManager.cards.isEmpty {
            portfolioView.pokazatBezKart()
        } else {
            portfolioView.pokazatKarti()

            portfolioView.updateCardCollection(cardSetsManager.cardCollection)
            portfolioView.updateCardDeck(cardSetsManager.cardDeck)
            portfolioView.updateCardsTotalValue(cardsManager.currentCardsValue)
            portfolioView.updateCardsNumber(cardsManager.cards.count, maxNumber: cardsManager.maxCardsNumber)

            categoriesCardsInfo = cardsManager.enabledCategories.map {
                SportivinieKartiKategoriiKartochek(
                    category: $0,
                    cardsValue: cardsManager.kartaZnachenie(of: $0),
                    cardsNumber: cardsManager.kartaNomer(of: $0)
                )
            }
            portfolioView.updateCategories(number: categoriesCardsInfo.count)
        }
    }

    func kategoriiKart(at indexPath: IndexPath) -> SportivinieKartiKategoriiKartochek? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categoriesCardsInfo[safe: indexPath.section]
    }

    func zagryzitInfoProfilya() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        if !profileManager.isProfileLoading {
            profileManager.zagryzitInfoProfil()
        }

        isLoading = true

        Task { @MainActor in
            defer { isLoading = false }

            try? await profileManager.profileLoadingTask?.result.get()
            guard profileManager.isProfileLoaded else { return }
            guard cardsManager.isScanEnabled else { return }
            guard isViewVisible else { return }
            delegate?.portfolioSkanirovanieKarti(self)
        }
    }

    // MARK: - Actions

    @objc func scanirovanieKartiNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard profileManager.isProfileLoaded else {
            zagryzitInfoProfilya()
            return
        }
        guard cardsManager.isScanEnabled else { return }
        delegate?.portfolioSkanirovanieKarti(self)
    }

    @objc func kartaKollekciaNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        if cardSetsManager.cardCollection.isNil {
            delegate?.portolioSozdatKollekciuNazhata(self)
        } else {
            delegate?.portfolioPokazatKollekciuNazhata(self)
        }
    }

    @objc func kartaKolodaNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if cardSetsManager.cardDeck.isNil {
            delegate?.portfolioSozdatKolodyNazhata(self)
        } else {
            delegate?.portfolioPokazatKolodyNazhata(self)
        }
    }

    @objc func profilInfoDidObnovilos(_ notification: Notification) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards)
                || fields.contains(.cardCategories)
                || fields.contains(.collection)
                || fields.contains(.deck)
        else { return }

        Task { @MainActor in
            reloadVid()
        }
    }
}

// MARK: - TableView DataSource

extension SportivinieKartiPortfolioVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categoriesCardsInfo.count

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let cell = tableView.dequeueReusableCell(withIdentifier: KategoriiZnachenieTVC.className, for: indexPath) as? KategoriiZnachenieTVC

        if let categoryCards = kategoriiKart(at: indexPath) {
            cell?.postavitKategoriu(categoryCards.category)
            cell?.postavirZnachenieKarti(categoryCards.cardsValue)
            cell?.postavitNomerKarti(categoryCards.cardsNumber)
            cell?.postavitPhotoKarti(categoryCards.category.image)
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        switch section {
        case 0: return 0
        default: return 9
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return UIDevice.isIpad ? 120 : 74
    }

}

// MARK: - TableView Delegate

extension SportivinieKartiPortfolioVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        tableView.deselectRow(at: indexPath, animated: true)

        guard let category = kategoriiKart(at: indexPath)?.category,
              !cardsManager.karti(of: category).isEmpty
        else {
            return
        }
        delegate?.portfolioKategoriiNazhata(category, in: self)
    }
}
