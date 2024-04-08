import UIKit

final class PricingReportViewController: UIViewController {

    private let card: CardRepresentable
    private let grader: CardGrader
    private let encodedCardImage: Data?

    private lazy var recentSales = card.recentSales(of: grader)

    // MARK: - Subviews

    lazy var pricingReportView: PricingReportView = .init()

    init(card: CardRepresentable, grader: CardGrader, encodedCardImage: Data?) {
        self.card = card
        self.grader = grader
        self.encodedCardImage = encodedCardImage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = pricingReportView
    }

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()

        setupViews_unique()
    }

    override func viewWillAppear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pricingReportView.salesTableView.sizeTableViewHeaderToFit()
        pricingReportView.updateSubviewsPositions()
    }

}

private extension PricingReportViewController {
    func setupViews_unique() {
        let detailsView = pricingReportView.detailsView
        detailsView.set(card: card, grader: grader)
        if let imageData = encodedCardImage {
            detailsView.set(encodedCardImage: imageData)
        } else if let imageURL = card.imageURL {
            detailsView.set(imageURL: imageURL)
        }

        pricingReportView.salesTableView.register(CardSaleTableViewCell.self, forCellReuseIdentifier: CardSaleTableViewCell.className)
        pricingReportView.salesTableView.dataSource = self
        pricingReportView.salesTableView.delegate = self

        if recentSales.isEmpty {
            pricingReportView.showNoSales()
        }
    }

    func getCardSale(at indexPath: IndexPath) -> CardSale? {
        recentSales[safe: indexPath.row]
    }
}

// MARK: - TableView DataSource

extension PricingReportViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return recentSales.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardSaleTableViewCell.className, for: indexPath) as? CardSaleTableViewCell

        if let sale = getCardSale(at: indexPath) {
            cell?.setSale(sale)
        }

        let isLast = indexPath.row == recentSales.count - 1
        cell?.setBottomSpace(hidden: isLast)

        return cell ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension PricingReportViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let sale = getCardSale(at: indexPath),
              let sourceURL = sale.sourceURL
        else {
            return
        }

        UIApplication.shared.open(sourceURL)
    }
}
