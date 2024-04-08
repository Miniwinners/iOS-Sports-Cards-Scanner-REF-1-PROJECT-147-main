import UIKit

final class IdentifyingCardViewController: UIViewController {

    weak var delegate: IdentifyingCardViewControllerDelegate?
    private let identifyingCardService: CardIdentifiable

    private let scannedCard: ScannedCard

    private var cardIdentificationTask: Task<(), Never>?

    // MARK: - Subviews

    lazy var identifyingCardView: IdentifyingCardView = .init()

    init(scannedCard: ScannedCard, identifyingCardService: CardIdentifiable = IdentifyCardService()) {
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
    }

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()

        setupViews_unique()
        setupActions_unique()
    }

    override func viewDidAppear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidAppear(animated)
        startCardIdentification()
    }

    override func viewWillDisappear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewWillDisappear(animated)
        cardIdentificationTask?.cancel()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}

private extension IdentifyingCardViewController {
    func setupViews_unique() {
        identifyingCardView.cardImageView.image = UIImage(data: scannedCard.encodedCardImage)
        identifyingCardView.titleLabel.text = L10n.IdentifyingCard.title(scannedCard.cardCategory.title)
    }

    func setupActions_unique() {
        identifyingCardView.cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
    }

    func startCardIdentification() {
        guard NetworkMonitoringService.shared.isNetworkAvailable else {
            let alertType: SCSAlertType = .noInternetConnection { [unowned self, weak delegate] alertController, _ in
                alertController.dismiss(animated: true) {
                    delegate?.identifyingCardViewControllerCancelTapped(self)
                }
            }
            AlertService.shared.presentAC(type: alertType, in: self)
            return
        }
        cardIdentificationTask = Task { @MainActor in
            do {
                let identifiedCard = try await identifyingCardService.identify(by: scannedCard)
                if Task.isCancelled { return }
                delegate?.identifyingCardViewControllerDidIdentify(withCard: identifiedCard, in: self)
            } catch {
                if Task.isCancelled { return }
                delegate?.identifyingCardViewControllerDidIdentify(withError: error, in: self)
            }
        }
    }

    // MARK: - Actions

    @objc func cancelTapped_unique() {
        delegate?.identifyingCardViewControllerCancelTapped(self)
    }
}
