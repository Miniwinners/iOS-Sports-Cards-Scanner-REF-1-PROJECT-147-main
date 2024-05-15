import UIKit
import SnapKit
func vicheslitFibonc191(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

final class SCDKartaKollekciiVc: UIViewController {

    @SportivinieKartiUserDefaultWrapper(UserDefaults.KeyOption.isTotalPriceVisible, defaultValue: true)
    private var isTotalPriceVisible: Bool

    @SportivinieKartiUserDefaultCodableWrapper(UserDefaults.KeyOption.selectedCardSortOption, defaultValue: KartaSortirovkaOpcii.default)

    private var selectedSortOption: KartaSortirovkaOpcii

    weak var delegate: SportivinieKartiKartaKollekciiDelegat?

    private let cardCollectionManager: SportivinieKartiKartaKollekciaManger

    private var cardCollection: SportivinieKartiKartaKollekcia? { cardCollectionManager.cardCollection }

    private var sortedCards: [SportivinieKartiKartaPredstavlenie] = []

    // MARK: - Subviews

    lazy var cardCollectionView: SportivinieKartiKartaKollekciiVid = .init()

    lazy var closeButton: CloseButton = .init(style: .close)

    lazy var scrollView: SportivinieKartiBSV = { scroll in
        scroll.alwaysBounceVertical = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .clear
        scroll.contentInset.bottom = 20
        return scroll
    }(SportivinieKartiBSV())

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
        cardCollectionView.cardsView.isShown = isTotalPriceVisible ? .show:.hide
        view = cardCollectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        postavitVid()
        postavidDeistviaUnicalno()
        obnovitDaty()
        podpisPodYvedomleniya()

        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
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

private extension SCDKartaKollekciiVc {
    func postavitVid() {

        let cardsDisplayOption = KartiDisplayOpcii.list
        cardCollectionView.cardsView.cardsDisplayControl.selectedSegmentIndex = cardsDisplayOption.index
        cardCollectionView.cardsView.postavitKartDisplay(option: cardsDisplayOption)

        let cardsTableView = cardCollectionView.cardsView.cardsTableView
        cardsTableView.register(SportivinieKartiCTVC.self, forCellReuseIdentifier: SportivinieKartiCTVC.className)
        cardsTableView.dataSource = self
        cardsTableView.delegate = self

        let cardsCollectionView = cardCollectionView.cardsView.cardsCollectionView
        cardsCollectionView.register(SportivinieKartiCardCVC.self, forCellWithReuseIdentifier: SportivinieKartiCardCVC.className)
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self

        let cardsSwipeableView = cardCollectionView.cardsView.cardsSwipeableView
        cardsSwipeableView.didVibranaKarta = { [unowned self, weak delegate] card in
            delegate?.cardCollectionViewControllerKartaNazhata(card, in: self)
        }
    }

    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardCollectionView.noCardsView.addCardsButton.addTarget(self, action: #selector(dobavitKarti), for: .touchUpInside)
        cardCollectionView.noCardsView.menuButton.addTarget(self, action: #selector(mneuNazhata), for: .touchUpInside)

        cardCollectionView.cardsView.menuButton.addTarget(self, action: #selector(mneuNazhata), for: .touchUpInside)
        cardCollectionView.cardsView.cardsDisplayControl.addTarget(self, action: #selector(opciiKartiIzmenilis(_:)), for: .valueChanged)
    }

    func obnovitDaty() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        sortedCards = cardCollectionManager.collectionCards.sortedElements(by: selectedSortOption)

        if cardCollectionManager.collectionCards.isEmpty {
            cardCollectionView.ybratKartiVid()
            cardCollectionView.noCardsView.postavitImyaKollekcii(cardCollection?.name)
            if isTotalPriceVisible {
                cardCollectionView.noCardsView.pokazatEstimateZnachenie()
            } else {
                cardCollectionView.noCardsView.spryataEstimaeZnachenie()
            }
        } else {
            cardCollectionView.pokazatKarti()
            cardCollectionView.cardsView.cardsSwipeableView.cards = sortedCards
            cardCollectionView.cardsView.reloadVidKart()
            cardCollectionView.cardsView.postavitImyaKollekcii(cardCollection?.name)
            cardCollectionView.cardsView.postavitKarti(count: sortedCards.count)
            cardCollectionView.cardsView.postavitKarti(price: cardCollectionManager.collectionCardsValue)
            if isTotalPriceVisible {
                cardCollectionView.cardsView.spryatatZnachenie()
            } else {
                cardCollectionView.cardsView.pokazatZnachenie()
            }
        }
    }

    func podpisPodYvedomleniya() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(profilInfoDidObnovilos(_:)), name: .profileInfoDidUpdate, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(polnayaCenaObnovilas),
            name: .init(rawValue: UserDefaults.KeyOption.isTotalPriceVisible),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(vibratOpciiSortirovki),
            name: .init(rawValue: UserDefaults.KeyOption.selectedCardSortOption),
            object: nil
        )
    }

    func kartaTablica(at indexPath: IndexPath) -> SportivinieKartiKartaPredstavlenie? {
        func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
            let a = 15
            let b = 32
            let c = a + b
            return Int.random(in: minValue...maxValue)
        }
        return sortedCards[safe: indexPath.section]
    }

    func kollekciaKart(at indexPath: IndexPath) -> SportivinieKartiKartaPredstavlenie? {
        func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
            let a = 15
            let b = 32
            let c = a + b
            return Int.random(in: minValue...maxValue)
        }
        return sortedCards[safe: indexPath.row]
    }
    // MARK: - Actions

    @objc func zakrit() {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        dismiss(animated: true)
    }

    @objc func zakritNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.cardCollectionViewControllerzakrtiNazhata(self)
    }

    @objc func dobavitKarti() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.cardCollectionViewControllerDobavitKarty(self)
    }

    @objc func mneuNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let cardCollection = cardCollection else { return }
        delegate?.kartaMenuNazhata(for: cardCollection, in: self)
    }

    @objc func opciiKartiIzmenilis(_ sender: UISegmentedControl) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let selectedIndex = sender.selectedSegmentIndex
        cardCollectionView.cardsView.index = selectedIndex
        guard let displayOption = KartiDisplayOpcii(by: selectedIndex) else { return }
        cardCollectionView.cardsView.postavitKartDisplay(option: displayOption)
    }

    @objc func profilInfoDidObnovilos(_ notification: Notification) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards) || fields.contains(.collection)
        else { return }

        Task { @MainActor in
            obnovitDaty()
        }
    }

    @objc func polnayaCenaObnovilas() {
        Task { @MainActor in
            obnovitDaty()
        }
    }

    @objc func vibratOpciiSortirovki() {
        Task { @MainActor in
            obnovitDaty()
        }
    }
}

extension SCDKartaKollekciiVc: SportivinieKartiSwaipProtocol {
    var isSwipeBackEnabled: Bool { false }
}

// MARK: - TableView DataSource

extension SCDKartaKollekciiVc: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedCards.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SportivinieKartiCTVC.className, for: indexPath) as? SportivinieKartiCTVC

        if let card = kartaTablica(at: indexPath) {
            cell?.podgotovitKarty(card)
            cell?.cardView.pricesLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIphone ? 18:22)
            cell?.cardView.titleLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIphone ? 20:26)
            cell?.cardView.subtitleLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIphone ? 16:20)

//            cell?.cardView.pricesLabel.setLineHeight(UIDevice.isIphone ? 22:24)
//            cell?.cardView.titleLabel.setLineHeight(UIDevice.isIphone ? 26:28)
//            cell?.cardView.subtitleLabel.setLineHeight(UIDevice.isIphone ? 22:24)
        }

        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if section == 0 { return 0 } else { return 8 }
    }
}

// MARK: - TableView Delegate

extension SCDKartaKollekciiVc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let card = kartaTablica(at: indexPath) else { return }
        delegate?.cardCollectionViewControllerKartaNazhata(card, in: self)
    }
}

// MARK: - CollectionView DataSource

extension SCDKartaKollekciiVc: UICollectionViewDataSource {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiCardCVC.className, for: indexPath) as? SportivinieKartiCardCVC
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if let card = kollekciaKart(at: indexPath) {
            cell?.postavitKarty(card)
//            cell?.cardView.pricesLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIphone ? 14 : 20)
//            cell?.cardView.titleLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIphone ? 18 : 24)
//            cell?.cardView.subtitleLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIphone ? 16 : 20)
//            cell?.cardView.pricesLabel.setLineHeight(UIDevice.isIphone ? 18:22)
//            cell?.cardView.titleLabel.setLineHeight(UIDevice.isIphone ? 22:26)
//            cell?.cardView.subtitleLabel.setLineHeight(UIDevice.isIphone ? 18:22)
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - CollectionView FlowLayout Delegate

extension SCDKartaKollekciiVc: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let card = kollekciaKart(at: indexPath) else { return }
        delegate?.cardCollectionViewControllerKartaNazhata(card, in: self)
    }
}
