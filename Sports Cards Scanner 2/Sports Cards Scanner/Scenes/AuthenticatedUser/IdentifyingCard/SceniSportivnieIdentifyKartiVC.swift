import UIKit
func vicheslitFibonc249(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiIdentifyKartiController: UIViewController {

    weak var delegate: SportivinieKartiIdentifyKartiDelegat?
    private let identifyingCardService: KartaIdentefiable

    private let scannedCard: SportivinieKartiScanirovannayaKarta

    private var cardIdentificationTask: Task<(), Never>?

    // MARK: - Subviews

    lazy var identifyingCardView: SportivinieKartiIdentifyKartiVid = .init()

    init(scannedCard: SportivinieKartiScanirovannayaKarta, identifyingCardService: KartaIdentefiable = SportivinieKartiIdentifyKartiService()) {
        self.scannedCard = scannedCard
        self.identifyingCardService = identifyingCardService

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = identifyingCardView
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        postavitVid()
        postavidDeistviaUnicalno()
    }

    override func viewDidAppear(_ animated: Bool) {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidAppear(animated)
        nachatIdetenfikaciu()
    }

    override func viewWillDisappear(_ animated: Bool) {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewWillDisappear(animated)
        cardIdentificationTask?.cancel()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}

private extension SportivinieKartiIdentifyKartiController {
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
        identifyingCardView.cardImageView.image = UIImage(data: scannedCard.encodedCardImage)
        identifyingCardView.titleLabel.text = L10n.IdentifyingCard.title(scannedCard.cardCategory.title)
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        identifyingCardView.cancelButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
    }

    func nachatIdetenfikaciu() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard SportivinieKartiInternetSoedinenieService.shared.isNetworkAvailable else {
            let alertType: SportivinieKartitipAlerta = .noInternetConnection { [unowned self, weak delegate] alertController, _ in
                alertController.dismiss(animated: true) {
                    delegate?.identifyingCardViewControllerotmenaNazhata(self)
                }
            }
            SportivinieKartiAlertService.shared.podgotovitAlertController(type: alertType, in: self)
            return
        }
        cardIdentificationTask = Task { @MainActor in
            do {
                let identifiedCard = try await identifyingCardService.identeficirovat(by: scannedCard)
                if Task.isCancelled { return }
                delegate?.identifyingCardDidIdentefeciroval(withCard: identifiedCard, in: self)
            } catch {
                if Task.isCancelled { return }
                delegate?.identifyingCardDidIdentefeciroval(withError: error, in: self)
            }
        }
    }

    // MARK: - Actions

    @objc func otmenaNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.identifyingCardViewControllerotmenaNazhata(self)
    }
}
