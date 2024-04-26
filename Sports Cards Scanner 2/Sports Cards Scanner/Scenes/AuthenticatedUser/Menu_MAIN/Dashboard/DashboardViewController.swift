import UIKit

final class DashboardViewController: UIViewController {

    private let profileManager: ProfileManager
    private let cardsManager: UserCardsManager
    weak var delegate: DashboardViewControllerDelegate?

    private var isLoading: Bool = false {
        didSet { dashboardView.scanCardButton.isLoading = isLoading }
    }

    // MARK: - Subviews

    lazy var dashboardView = DashboardView()

    init(
        profileManager: ProfileManager = .shared,
        cardsManager: UserCardsManager = .shared
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
        view = dashboardView
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
        subscribeToNotifications()
    }
}

private extension DashboardViewController {
    var currentCardsValue: Double {
        cardsManager.currentCardsValue
    }
    var categoriesCardsValue: [(CardCategory, Double)] {
        CardCategory.allCases.map { ($0, cardsManager.cardsValue(of: $0)) }
    }
    var highestValuedCard: CardRepresentable? {
        cardsManager.highestValuedCards(count: 1).first
    }

    var highestValueTwo: CardRepresentable? {
        cardsManager.highestValuedCards(count: 2).first
    }

    var recentlyAddedCards: [CardRepresentable] {
        cardsManager.recentlyAddedCards(count: 3)
    }

    func setupViews_unique() {
        reloadSubviews_unique()
    }

    func setupActions_unique() {
        dashboardView.scanCardButton.addTarget(self, action: #selector(scanCardTapped), for: .touchUpInside)

        let cardsView = dashboardView.cardsView
        cardsView.currentValueView.discloseButton.addTarget(self, action: #selector(discloseCurrentValueTapped), for: .touchUpInside)
        cardsView.highestValueView.discloseButton.addTarget(self, action: #selector(discloseHighestValueTapped), for: .touchUpInside)
        cardsView.highestValueView.cardButton.addTarget(self, action: #selector(showHighestValuedCardDetailsTapped), for: .touchUpInside)
        cardsView.highestValueView.cardButtonTwo.addTarget(self, action: #selector(showHighestValuedCardDetailsTappedTwo), for: .touchUpInside)
        cardsView.recentlyAddedView.discloseButton.addTarget(self, action: #selector(discloseRecentlyAddedTapped), for: .touchUpInside)
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileInfoDidUpdate(_:)), name: .profileInfoDidUpdate, object: nil)
    }

    func reloadSubviews_unique() {
        if cardsManager.cards.isEmpty {
            dashboardView.showNoCardView()

        } else {
            dashboardView.showCardsView()
            dashboardView.updateCurrentValueView(currentValue: currentCardsValue, categoryValues: categoriesCardsValue)
            dashboardView.updateHighestValueView(first: highestValuedCard, second: highestValueTwo, third: highestValueTwo)
            dashboardView.updateRecentlyAddedView(with: recentlyAddedCards)
            dashboardView.cardsView.recentlyAddedView.delegate = self
        }
    }

    func loadProfileInfo() {
        if !profileManager.isProfileLoading {
            guard NetworkMonitoringService.shared.isNetworkAvailable else {
                let alertType: SCSAlertType = .noInternetConnection(okAction: nil)
                AlertService.shared.presentAC(type: alertType, in: self)
                return
            }

            profileManager.loadProfileInfo()
        }

        isLoading = true

        Task { @MainActor in
            defer { isLoading = false }

            try? await profileManager.profileLoadingTask?.result.get()
            guard profileManager.isProfileLoaded else { return }
            guard cardsManager.isScanEnabled else { return }
            guard isViewVisible else { return }
            delegate?.dashboardViewControllerScanCardTapped(self)
        }
    }

    // MARK: - Actions

    @objc func scanCardTapped() {
        guard profileManager.isProfileLoaded else {
            loadProfileInfo()
            return
        }
        guard cardsManager.isScanEnabled else { return }
        delegate?.dashboardViewControllerScanCardTapped(self)
    }

    @objc func profileInfoDidUpdate(_ notification: Notification) {
        guard let fields = notification.object as? [ProfileField],
              fields.contains(.cards)
        else { return }

        Task { @MainActor in
            reloadSubviews_unique()
        }
    }

    @objc func showHighestValuedCardDetailsTapped() {
        guard let card = highestValuedCard else { return }
        delegate?.dashboardViewControllerCardDetailsTapped(card: card, in: self)
    }

    @objc func showHighestValuedCardDetailsTappedTwo() {
        guard let card = highestValueTwo else { return }
        delegate?.dashboardViewControllerCardDetailsTapped(card: card, in: self)
    }

    @objc func discloseCurrentValueTapped() {
        delegate?.dashboardViewControllerDiscloseCurrentValueTapped(self)
    }

    @objc func discloseHighestValueTapped() {
        delegate?.dashboardViewControllerDiscloseHighestValueTapped(self)
    }

    @objc func discloseRecentlyAddedTapped() {
        delegate?.dashboardViewControllerDiscloseRecentlyAddedTapped(self)
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let card = recentlyAddedCards[safe: indexPath.row] else { return }
        delegate?.dashboardViewControllerCardDetailsTapped(card: card, in: self)
    }
}
