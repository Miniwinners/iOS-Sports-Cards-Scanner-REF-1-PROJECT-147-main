import UIKit
import SnapKit

final class CurrentValueDetailsViewController: UIViewController {

    private let cardsManager: UserCardsManager

    weak var delegate: CurrentValueDetailsViewControllerDelegate?

    // MARK: - Subviews
    lazy var backView: BackView = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.contentInset.bottom = 20
        return scrollView
    }(BaseScrollView())

    lazy var currentValueDetailsView: CurrentValueDetailsView = .init()

    init(cardsManager: UserCardsManager = .shared) {
        self.cardsManager = cardsManager
        super.init(nibName: nil, bundle: nil)
        currentValueDetailsView.titleLabel.text = L10n.CurrentValue.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        setupViews_unique()
        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(closeTapped_unique), for: .touchUpInside)
    }

}

private extension CurrentValueDetailsViewController {
    var categoryValues: [(CardCategory, Double)] {
        CardCategory.allCases
            .map { ($0, cardsManager.cardsValue(of: $0)) }
            .filter { $0.1 != 0 }
    }

    func setupViews_unique() {
        view.backgroundColor = .clear
        backView.setupView(in: view)

        currentValueDetailsView.categoryValuesTable.delegate = self
        currentValueDetailsView.categoryValuesTable.dataSource = self

        backView.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        scrollView.addSubview(currentValueDetailsView)
        currentValueDetailsView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.high)
        }

        currentValueDetailsView.setCategoriesValues(current: cardsManager.currentCardsValue, categories: categoryValues)
    }

    func categoryValue(at indexPath: IndexPath) -> (CardCategory, Double)? {

        categoryValues[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func closeTapped_unique() {
        delegate?.currentValueDetailsViewControllerCloseTapped(self)
    }
}

// MARK: - UITableViewDataSource

extension CurrentValueDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsManager.enabledCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentValuesDetailsTableViewCell.cellIdentifier, for: indexPath) as? CurrentValuesDetailsTableViewCell else { fatalError() }

        if let categoryValue = categoryValue(at: indexPath) {
            cell.set(category: categoryValue.0, value: categoryValue.1)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.sectionHeaderHeight))

        lazy var categoryValueLabel: UILabel = { label in
            label.text = L10n.CurrentValue.valueByCategory
            label.font = .font(.ubuntuRegular400, size: 21)
            label.textColor = .labelColor
            label.setLineHeight(32)
            label.setContentHuggingPriority(.required, for: .vertical)
            return label
        }(UILabel())

        headerView.text = categoryValueLabel.text
        headerView.addSubview(categoryValueLabel)
        headerView.textAlignment = .center
        headerView.font = categoryValueLabel.font
        if UIDevice.isIpad {
            headerView.font = .font(.ubuntuRegular400, size: 24)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.isIphone {
            return 25
        } else {
            return 30
        }
    }
}

// MARK: - UITableViewDelegate

extension CurrentValueDetailsViewController: UITableViewDelegate {

}
