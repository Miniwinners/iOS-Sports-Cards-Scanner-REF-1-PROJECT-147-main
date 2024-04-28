import UIKit

final class CardCategoriesViewController: UIViewController {

    private let cardCategoriesManager: CardCategoriesManager
    weak var delegate: CardCategoriesViewControllerDelegate?

    // MARK: - Subviews

    lazy var cardCategoriesView: CardCategoriesView = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    init(cardCategoriesManager: CardCategoriesManager = .shared) {
        self.cardCategoriesManager = cardCategoriesManager

        super.init(nibName: nil, bundle: nil)
        cardCategoriesView.titleLabel.text = L10n.CardCategories.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = cardCategoriesView
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
    }

    override func viewDidDisappear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidDisappear(animated)
        cardCategoriesManager.saveCategoriesIfNeeded()
    }
}

private extension CardCategoriesViewController {
    func setupViews_unique() {

        let tableView = cardCategoriesView.tableView
        tableView.register(CardCategoryTableViewCell.self, forCellReuseIdentifier: CardCategoryTableViewCell.className)
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.delegate = self
        tableView.dragInteractionEnabled = true

        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(closeTapped_unique), for: .touchUpInside)
    }

    func cardCategoryModel(for indexPath: IndexPath) -> CardCategoryModel? {
        cardCategoriesManager.switchableCardCategories[safe: indexPath.row]
    }

    func setCategory(_ category: CardCategory, enabled: Bool) {
        var sourceIndex: Int?
        var destinationIndex: Int?

        self.cardCategoriesManager.setCategory(
            category,
            enabled: enabled,
            movedFrom: &sourceIndex,
            to: &destinationIndex
        )
        guard let fromIndex = sourceIndex, let toIndex = destinationIndex else { return }

        let fromIndexPath: IndexPath = .init(row: fromIndex, section: 0)
        let toIndexPath: IndexPath = .init(row: toIndex, section: 0)

        cardCategoriesView.tableView.moveRow(at: fromIndexPath, to: toIndexPath)
        updateCellsAppearance()
        updateSwitchOffAvailability()
    }

    func updateCellsAppearance() {
        let tableView = cardCategoriesView.tableView

        let categoryCells = tableView.visibleCells.compactMap { $0 as? CardCategoryTableViewCell }
        let indexPaths = categoryCells.compactMap { tableView.indexPath(for: $0) }

        zip(categoryCells, indexPaths).forEach { _, _ in
//            cell.updateCellPosition(UITableView.cellPosition(for: indexPath, basedOn: cardCategoriesManager.allCardCategories))
        }
    }

    func updateCellsAppearanceAfterMovement(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let tableView = cardCategoriesView.tableView

        var categoryCells = tableView.visibleCells.compactMap { $0 as? CardCategoryTableViewCell }
        let indexPaths = categoryCells.compactMap { tableView.indexPath(for: $0) }

        guard let fromIndex = indexPaths.firstIndex(of: fromIndexPath),
              let toIndex = indexPaths.firstIndex(of: toIndexPath)
        else {
            return
        }

        categoryCells.moveElement(from: fromIndex, to: toIndex)

        zip(categoryCells, indexPaths).forEach { _, _ in
//            cell.updateCellPosition(UITableView.cellPosition(for: indexPath, basedOn: cardCategoriesManager.allCardCategories))
        }
    }

    func updateSwitchOffAvailability() {
        cardCategoriesView.tableView
            .visibleCells
            .compactMap { $0 as? CardCategoryTableViewCell }
            .forEach { $0.setSwitchOff(available: cardCategoriesManager.isAvailableToSwitchOff) }
    }

    @objc func closeTapped_unique() {
        delegate?.cardCategoriesViewControllerCloseTapped(self)
    }
}

// MARK: - Table View Data Source

extension CardCategoriesViewController: UITableViewDataSource {
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

        return cardCategoriesManager.allCardCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryModel = cardCategoryModel(for: indexPath) else {
            return .init()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: CardCategoryTableViewCell.className, for: indexPath) as? CardCategoryTableViewCell

        cell?.setupCategoryCell(with: categoryModel, onCategoryDidSwitch: { [weak self] isEnabled in
            self?.setCategory(categoryModel.category, enabled: isEnabled)
        })
//        cell?.updateCellPosition(UITableView.cellPosition(for: indexPath, basedOn: cardCategoriesManager.allCardCategories))
        cell?.setSwitchOff(available: cardCategoriesManager.isAvailableToSwitchOff)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        indexPath.row <= cardCategoriesManager.lastEnabledCategoryIndex
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        cardCategoriesManager.moveCategory(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }

}

// MARK: - Table View Drag Delegate

extension CardCategoriesViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, dragSessionIsRestrictedToDraggingApplication session: UIDragSession) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.row <= cardCategoriesManager.lastEnabledCategoryIndex else {
            return []
        }

        let item = UIDragItem(itemProvider: .init())
        item.localObject = indexPath
        return [item]
    }

    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }

        let preview = UIDragPreviewParameters()
        preview.visiblePath = UIBezierPath(roundedRect: cell.bounds.insetBy(dx: 20, dy: 3), cornerRadius: 16)
        return preview
    }

}

// MARK: - Table View Drop Delegate

extension CardCategoriesViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if let item = session.items.first,
           let fromIndexPath = item.localObject as? IndexPath,
           let toIndexPath = destinationIndexPath,
           toIndexPath.row <= cardCategoriesManager.lastEnabledCategoryIndex {
            updateCellsAppearanceAfterMovement(from: fromIndexPath, to: toIndexPath)
            return .init(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            updateCellsAppearance()
            return .init(operation: .cancel)
        }
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }

    func tableView(_ tableView: UITableView, dropSessionDidEnd session: UIDropSession) {

        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        updateCellsAppearance()
    }

    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }

        let preview = UIDragPreviewParameters()
        preview.visiblePath = UIBezierPath(roundedRect: cell.bounds.insetBy(dx: 20, dy: 0), cornerRadius: 0)
        return preview
    }
}

extension CardCategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
}
