import UIKit

final class AddCardsToCollectionCategoriesVC: UIViewController {

    weak var delegate: AddCardsToCollectionCategoriesVCDelegate?

    let helper: AddCardToCollectionHelper

    private let categoriesInfo: [CategoryCards]

    // MARK: - Subviews

    lazy var addCardsView: AddCardsToCollectionCategoriesView = .init()

    lazy var closeButton: CloseButton = .init(style: .back)

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

        navigationController?.setNavigationBarHidden(true, animated: false)
        setupViews_unique()
        setupActions_unique()
        setupNavigationItem()
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addCardsView.setSelectedCards(number: helper.allSelectedCards.count)
    }

}

private extension AddCardsToCollectionCategoriesVC {
    func setupViews_unique() {
        addCardsView.categoriesTableView.register(CategoryValueTableViewCell.self, forCellReuseIdentifier: CategoryValueTableViewCell.className)
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
            self.addCardsView.titleLabel.text = L10n.AddCards.TitleNoName.collection
        } else {
            self.addCardsView.titleLabel.text = title
        }
    }

    func setupNavigationItem() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil
    }

    func categoryInfo(at indexPath: IndexPath) -> CategoryCards? {
        categoriesInfo[safe: indexPath.section]
    }

    // MARK: - Actions

    @objc func close() {
        navigationController?.popViewController(animated: true)
    }

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

        return categoriesInfo.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryValueTableViewCell.className, for: indexPath) as? CategoryValueTableViewCell

        if let categoryCards = categoryInfo(at: indexPath) {
            cell?.setCategory(categoryCards.category)
            cell?.setCardsValue(categoryCards.cardsValue)
            cell?.setCardsNumber(categoryCards.cardsNumber)
            cell?.setCardImage(categoryCards.category.image)
        }
        cell?.backgroundColor = .skyBlue
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: categoriesInfo))

        return cell ?? UITableViewCell()

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 } else { return 9 }

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
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
