import UIKit

final class AddCardsToCollectionCategoriesVC: UIViewController {

    weak var delegate: AddCardsToCollectionCategoriesVCDelegate?

    let helper: AddCardToCollectionHelper

    private let categoriesInfo: [CategoryCards]

    // MARK: - Subviews

    lazy var addCardsView: AddCardsToCollectionCategoriesView = .init()

    init(helper: AddCardToCollectionHelper = .init()) {
        self.helper = helper
        self.categoriesInfo = helper.categoriesCardsInfo

        super.init(nibName: nil, bundle: nil)
        setupVCTitle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = addCardsView
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
        setupNavigationItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addCardsView.setSelectedCards(number: helper.allSelectedCards.count)
    }

}

private extension AddCardsToCollectionCategoriesVC {
    func setupViews_unique() {
        addCardsView.categoriesTableView.register(CategoryCardsTableViewCell.self, forCellReuseIdentifier: CategoryCardsTableViewCell.className)
        addCardsView.categoriesTableView.dataSource = self
        addCardsView.categoriesTableView.delegate = self

        addCardsView.updateCategories(count: categoriesInfo.count)
    }

    func setupActions_unique() {
        addCardsView.cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
        addCardsView.doneButton.addTarget(self, action: #selector(doneTapped_unique), for: .touchUpInside)
    }

    func setupVCTitle() {
        let title = L10n.AddCards.title(helper.cardCollection?.name ?? "")

        let titleWidth = (title as NSString).size(withAttributes: [.font: UIFont.font(.interMedium, size: 20)]).width
        let screenWidth = UIScreen.current?.bounds.width ?? 0

        if titleWidth > screenWidth - 140 {
            self.title = L10n.AddCards.TitleNoName.collection
        } else {
            self.title = title
        }
    }

    func setupNavigationItem() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil
    }

    func categoryInfo(at indexPath: IndexPath) -> CategoryCards? {
        categoriesInfo[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func cancelTapped_unique() {
        delegate?.addCardsToCollectionCategoriesVCCancelTapped(self)
    }

    @objc func doneTapped_unique() {
        helper.saveCardsToCollection()
        delegate?.addCardsToCollectionCategoriesVCDoneTapped(self)
    }
}

extension AddCardsToCollectionCategoriesVC: UITableViewDataSource {
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

        return categoriesInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCardsTableViewCell.className, for: indexPath) as? CategoryCardsTableViewCell

        if let categoryInfo = categoryInfo(at: indexPath) {
            cell?.setCategory(categoryInfo.category)
            cell?.setCards(number: categoryInfo.cardsNumber)
        }
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: categoriesInfo))

        return cell ?? UITableViewCell()
    }
}

extension AddCardsToCollectionCategoriesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let categoryInfo = categoryInfo(at: indexPath) else { return }
        delegate?.addCardsToCollectionCategoriesVCCategoryDidSelect(categoryInfo.category, in: self)
    }
}

extension AddCardsToCollectionCategoriesVC: SwipableController {
    var isSwipeBackEnabled: Bool {
        false
    }
}
