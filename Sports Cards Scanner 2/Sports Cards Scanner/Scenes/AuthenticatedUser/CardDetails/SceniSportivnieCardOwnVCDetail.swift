import UIKit
import SnapKit
import Kingfisher
import Foundation
func vicheslitFibonc272(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum PreviousVC {
    case search
    case common
}

final class SportivinieKartiCardOwnVCDetail: UIViewController {

    private let searchCardService: SportivinieKartiKartaPoiskovaya
    private let cardPhotoService: SportivinieKartiPhotoKartiSc
    private let cardsManager: SportivinieKartiUserKartManager
    weak var delegate: SportivinieKartiCardOwnVCDetailDelegate?
    private var previousVC: PreviousVC
    private var locked: Bool
    private(set) lazy var searchedCardsManager: SportivinieKartiKartUpdater = SportivinieKartiPoiskKartManager(card: card)

    private(set) lazy var selectedGrader: SportivinieKartiKartaGrader = .RAW

    private(set) var card: SportivinieKartiKartaPredstavlenie
    let cardType: KartaType
    let encodedCardImage: Data?

    private var isLoading = false {
        didSet {
             cardDetailsView.removeCardButton.isLoading = isLoading
        }
    }

    // MARK: - Subviews

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceVertical = false
        return scrollView
    }(SportivinieKartiBSV())

    lazy var cardDetailsView: SportivinieKartiCardOwnView = .init(locked: locked)

    lazy var backGroundView: UIView = .init()
    lazy var indicatorImageView: UIImageView = .init(image: SportivinieKartiImages.loading.image)

    lazy var overlayView: UIView = .init()

    init(
        card: SportivinieKartiKartaPredstavlenie,
        cardType: KartaType = .addedCard,
        encodedCardImage: Data? = nil,
        searchCardService: SportivinieKartiKartaPoiskovaya = SportivinieKartiPoiskKarti(),
        cardPhotoService: SportivinieKartiPhotoKartiSc = .init(),
        cardsManager: SportivinieKartiUserKartManager = .shared,
        previousVC: PreviousVC,
        locked: Bool
    ) {
        self.card = card
        self.cardType = cardType
        self.encodedCardImage = encodedCardImage
        self.searchCardService = searchCardService
        self.cardPhotoService = cardPhotoService
        self.cardsManager = cardsManager
        self.previousVC = previousVC
        self.locked = locked
        super.init(nibName: nil, bundle: nil)
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
        postavitDatyVida()
        postavidDeistviaUnicalno()
        subscribeToNotifications()

    }

    override func viewWillAppear(_ animated: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func gradeDidVibrana(_ grader: SportivinieKartiKartaGrader) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        selectedGrader = grader

        cardDetailsView.cardGraderButton.cardGrader = selectedGrader
        cardDetailsView.pricingReportButton.reportMode = getPricingReportMode()
    }

}

private extension SportivinieKartiCardOwnVCDetail {
    func postavitVid() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        view.backgroundColor = .clear
        view.addSubview(backGroundView)
        backGroundView.layer.cornerRadius = UIDevice.isIpad ? 34:24
        backGroundView.backgroundColor = .white
        backGroundView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().inset(UIDevice.isIpad ? 40:30)
        }
        backGroundView.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 30:22)
            $0.bottom.horizontalEdges.equalToSuperview()
        }

        scrollView.addSubview(cardDetailsView)
        cardDetailsView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.high)
        }

        cardDetailsView.hidesNoNeededViews(for: cardType)
        setupButton()
        view.addSubview(overlayView)
        view.addSubview(indicatorImageView)
        overlayView.alpha = 0
        indicatorImageView.alpha = 0
    }

    func setupButton() {
        if isRootViewController() {
            stilZakritiya(style: previousVC)
        } else {
            if previousVC == .search { stilZakritiya(style: previousVC) } else {
                let closeButton = CloseButton(style: .back)
                closeButton.setLeft(in: view)
                closeButton.addTarget(self, action: #selector(nazadNazhata), for: .touchUpInside)
            }
        }
    }

    func stilZakritiya(style: PreviousVC) {
        let closeButton = CloseButton(style: .close)
        closeButton.setCenter(in: view)
        if style == .search { closeButton.addTarget(self, action: #selector(zakritPoslePoiska), for: .touchUpInside) } else {
            closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
        }
    }

    func isRootViewController() -> Bool {
           return navigationController?.viewControllers.first == self
    }
    func postavitDatyVida() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardDetailsView.cardTitleLabel.text = "\(card.title)"
        cardDetailsView.cardSubTitleLabel.text = "\(card.subtitle)"
        selectedGrader = card.customPrice.isNil ? card.selectedGrader : .CUSTOM

        cardDetailsView.cardGraderButton.cardGrader = selectedGrader
        cardDetailsView.pricingReportButton.reportMode = getPricingReportMode()

        switch cardType {
        case .addedCard:
            cardDetailsView.detailsListView.obnovitDetaliItem(card.detailItemsList)
            cardDetailsView.cardImageView.kf.setImage(with: card.imageURL)
        default:
            guard let imageData = encodedCardImage else { return }
            cardDetailsView.cardImageView.image = .init(data: imageData) ?? .init()
        }
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardDetailsView.cardGraderButton.addTarget(self, action: #selector(vibranGraderNazhata), for: .touchUpInside)
        cardDetailsView.pricingReportButton.addTarget(self, action: #selector(ocenkaCeniNazhata), for: .touchUpInside)
        cardDetailsView.addCardButton.addTarget(self, action: #selector(dobavitNazhata), for: .touchUpInside)
        cardDetailsView.editCardButton.addTarget(self, action: #selector(redaktirovatKartyNazhata), for: .touchUpInside)
        cardDetailsView.findCardButton.addTarget(self, action: #selector(naitiKartyNazhata), for: .touchUpInside)
        cardDetailsView.removeCardButton.addTarget(self, action: #selector(ydalitKartyNazhata), for: .touchUpInside)
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func subscribeToNotifications() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        NotificationCenter.default.addObserver(self, selector: #selector(profilInfoDidObnovilos(_:)), name: .profileInfoDidUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(poiskKartaDidNazhata), name: .searchedCardDidUpdate, object: nil)
    }

    func getPricingReportMode() -> SportivinieKartiPricingRB.OvetMod {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if selectedGrader == .CUSTOM {
            let customPrice = card.diapazonCen(of: .CUSTOM)
            return .customPrice(price: customPrice)
        }

        if let graderPrices = card.diapazonCen(of: selectedGrader) {
            return .graderPrice(priceRange: graderPrices)
        } else {
            return .noPrice
        }
    }

    // MARK: - Actions

    @objc func zakritNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.cardDetailsViewControllerzakrtiNazhata(self)
    }

    @objc func nazadNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.nazadNazhata(self)
    }

    @objc func zakritPoslePoiska() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.zakritPoslePoiska(self)
    }

    @objc func vibranGraderNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.graderNazhat(self)
    }

    @objc func ocenkaCeniNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let reportMode = cardDetailsView.pricingReportButton.reportMode else {
            return
        }

        switch reportMode {
        case .noPrice:
            return
        case .customPrice:
            delegate?.izmenitKartuNazhata(self)
        case .graderPrice:
            delegate?.cenaObzorNazhata(self)
        }
    }

    func setupLoadingScreen() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }

        overlayView = UIView(frame: window.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        overlayView.addSubview(indicatorImageView)
        indicatorImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(95)
        }
        window.addSubview(overlayView)

        UIView.animate(withDuration: 0.3) {
            self.overlayView.alpha = 1
            self.indicatorImageView.alpha = 1
            self.animirovatIndicator()

        }
    }

    func animirovatIndicator() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.indicatorImageView.transform = self.indicatorImageView.transform.rotated(by: .pi)
        } completion: { _ in
            self.animirovatIndicator()
        }
    }

    @objc func dobavitNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        setupLoadingScreen()
        guard SportivinieKartiInternetSoedinenieSc.shared.isNetworkAvailable else {
            let alertType: SportivinieKartitipAlerta = .noInternetConnection(okAction: nil)
            SportivinieKartiAlertSc.shared.podgotovitAlertController(type: alertType, in: self)
            return
        }

        isLoading = true

        Task { @MainActor in
            defer { isLoading = false }

            guard var detailedCard = try? await searchCardService.poluchitPolnieDannie(of: card),
                  let imageData = encodedCardImage,
                  let imageURL = try? await cardPhotoService.zagruzitPhotoKarti(data: imageData, named: detailedCard.id)
            else {
                return
            }

            detailedCard.imageSource = imageURL.absoluteString
            cardsManager.dobavitNovuuKarty(detailedCard)
            cardsManager.sohranitKartiEsliNado()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIView.animate(withDuration: 0.3, animations: {
                    self.overlayView.alpha = 0
                }) { _ in
                    self.overlayView.removeFromSuperview()

                    self.delegate?.kartaDobavlenaNazhata(self)

                }
            }
        }
    }

    @objc func redaktirovatKartyNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if locked == false {
            delegate?.izmenitKartyPodbischik(self)
        } else {
            delegate?.izmenitKartuNazhata(self)
        }
    }

    @objc func naitiKartyNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.naitiKartyNazhata(self)
    }

    @objc func ydalitKartyNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.ybratKartyNazhata(card, in: self)
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

        Task { @MainActor in
            guard let updatedCard = cardsManager.cards.first(where: { card.id == $0.id }) else {
                return
            }
            card = updatedCard
            postavitDatyVida()
        }
    }

    @objc func poiskKartaDidNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        Task { @MainActor in
            guard let updatedCard = searchedCardsManager.cards.first else { return }
            card = updatedCard
            postavitDatyVida()
        }
    }
}
