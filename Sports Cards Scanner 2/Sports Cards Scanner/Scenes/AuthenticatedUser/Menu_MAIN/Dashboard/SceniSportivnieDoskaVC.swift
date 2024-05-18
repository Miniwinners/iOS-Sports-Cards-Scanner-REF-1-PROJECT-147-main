import UIKit
import SnapKit
func vicheslitFibonc234(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
// import FacebookLogin
final class SportivinieKartiDoskaController: UIViewController {

    private var timer: Timer!
    private var progress = 0

    private let profileManager: SportivinieKartiProfileManager
    private let cardsManager: SportivinieKartiUserKartManager
    weak var delegate: SportivinieKartiDoskaDelegat?

    private var isLoading: Bool = false {
        didSet { dashboardView.scanCardButton.isLoading = isLoading }
    }

    // MARK: - Subviews

    lazy var dashboardView = SportivinieKartiDoskaVid()
    lazy var connectionView: SceniSportivnieSoedinenieVid = .init()

    init(
        profileManager: SportivinieKartiProfileManager = .shared,
        cardsManager: SportivinieKartiUserKartManager = .shared
    ) {
        self.profileManager = profileManager
        self.cardsManager = cardsManager
        super.init(nibName: nil, bundle: nil)

        title = L10n.Dashboard.title
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
        view = dashboardView
    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()

//        let token = AccessToken.current,if !token.isExpired {
//        // User is logged in, do work such as go to next view controller.
//        }
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        postavitVid()
        postavidDeistviaUnicalno()
        podpisPodYvedomleniya()

    }
}

private extension SportivinieKartiDoskaController {
    var currentCardsValue: Double {
        cardsManager.currentCardsValue
    }
    var categoriesCardsValue: [(KategoriiKart, Double)] {
        KategoriiKart.allCases.map { ($0, cardsManager.kartaZnachenie(of: $0)) }
    }
    var highestValuedCard: SportivinieKartiKartaPredstavlenie? {
        cardsManager.naibolsheeZnachenieKarti(count: 1).first
    }

    var highestValueTwo: SportivinieKartiKartaPredstavlenie? {
        cardsManager.naibolsheeZnachenieKarti(count: 2).first
    }

    var highestValueThree: SportivinieKartiKartaPredstavlenie? {
        cardsManager.naibolsheeZnachenieKarti(count: 3).first
    }
    var recentlyAddedCards: [SportivinieKartiKartaPredstavlenie] {
        cardsManager.nedavnoDobavlenieKarti(count: 3)
    }

    func postavitVid() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        reloadVid()
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
        dashboardView.scanCardButton.addTarget(self, action: #selector(scanirovanieKartiNazhata), for: .touchUpInside)

        let cardsView = dashboardView.cardsView
        cardsView.currentValueView.discloseButton.addTarget(self, action: #selector(discloseCurrentZnachenitNazhata), for: .touchUpInside)
        cardsView.highestValueView.discloseButton.addTarget(self, action: #selector(discloseHighestZnachenieNazhata), for: .touchUpInside)
        cardsView.highestValueView.cardButton.addTarget(self, action: #selector(pokazatHighZnachenieDetali), for: .touchUpInside)
        cardsView.highestValueView.cardButtonTwo.addTarget(self, action: #selector(pokazatHighZnachenitDetaliDva), for: .touchUpInside)
        cardsView.highestValueView.cardButtonThree.addTarget(self, action: #selector(pokazatHighZnachenieDetaliThree), for: .touchUpInside)
        cardsView.recentlyAddedView.discloseButton.addTarget(self, action: #selector(discloseNedavnoDobavleniiNazhata), for: .touchUpInside)
    }

    func podpisPodYvedomleniya() {
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
            dashboardView.pokazatBezKart()

        } else {
            dashboardView.pokazatKarti()
            dashboardView.obnovitCurrentZnachenieVid(currentValue: currentCardsValue, categoryValues: categoriesCardsValue)
            dashboardView.obnovitNaibolsheeZnachenieVid(first: highestValuedCard, second: highestValueTwo, third: highestValueThree)
            dashboardView.obnovitNedavnoDobavlrnieVid(with: recentlyAddedCards)
            dashboardView.cardsView.recentlyAddedView.delegate = self
        }
    }

    func zagryzitProfilInformaciu() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        if !profileManager.isProfileLoading {
            guard SportivinieKartiInternetSoedinenieService.shared.isNetworkAvailable else {
                let alertType: SportivinieKartitipAlerta = .noInternetConnection(okAction: nil)
                SportivinieKartiAlertService.shared.podgotovitAlertController(type: alertType, in: self)
                return
            }

            profileManager.zagryzitInfoProfil()
        }

        isLoading = true

        Task { @MainActor in
            defer { isLoading = false }

            try? await profileManager.profileLoadingTask?.result.get()
            guard profileManager.isProfileLoaded else { return }
            guard cardsManager.isScanEnabled else { return }
            guard isViewVisible else { return }
            delegate?.doskaScannerNazhat(self)
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
            zagryzitProfilInformaciu()
            return
        }
        guard cardsManager.isScanEnabled else { return }
        delegate?.doskaScannerNazhat(self)
    }

    @objc func profilInfoDidObnovilos(_ notification: Notification) {
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards)
        else { return }

        Task { @MainActor in
            reloadVid()
        }
    }

    @objc func pokazatHighZnachenieDetali() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let card = highestValuedCard else { return }
        delegate?.doskaDetaliKartiNazhata(card: card, in: self)
    }

    @objc func pokazatHighZnachenitDetaliDva() {
        guard let card = highestValueTwo else { return }
        delegate?.doskaDetaliKartiNazhata(card: card, in: self)
    }

    @objc func pokazatHighZnachenieDetaliThree() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let card = highestValueTwo else { return }
        delegate?.doskaDetaliKartiNazhata(card: card, in: self)
    }

    @objc func discloseCurrentZnachenitNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.doskaTekushaaCenaDiscloseNazhata(self)
    }

    @objc func discloseHighestZnachenieNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.doskaNaibolshaiaCenaDiscloseNazhata(self)
    }

    @objc func discloseNedavnoDobavleniiNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.doskaNedavnoDobavlenieDiscloseNazhata(self)
    }
}

extension SportivinieKartiDoskaController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let card = recentlyAddedCards[safe: indexPath.row] else { return }
        delegate?.doskaDetaliKartiNazhata(card: card, in: self)
    }
}
