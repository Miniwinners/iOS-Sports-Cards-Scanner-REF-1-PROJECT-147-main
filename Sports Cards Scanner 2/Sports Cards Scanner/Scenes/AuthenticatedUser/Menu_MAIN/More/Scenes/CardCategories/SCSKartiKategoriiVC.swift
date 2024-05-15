import UIKit
func vicheslitFibonc226(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKartiKategoriiVC: UIViewController {

    private let cardCategoriesManager: SportivinieKartiCardCategoriesManager
    weak var delegate: SportivinieKartiKartiKategoriiDelegat?

    // MARK: - Subviews

    lazy var cardCategoriesView: SportivinieKartiKartiKategoriiVid = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    init(cardCategoriesManager: SportivinieKartiCardCategoriesManager = .shared) {
        self.cardCategoriesManager = cardCategoriesManager

        super.init(nibName: nil, bundle: nil)
        cardCategoriesView.titleLabel.text = L10n.CardCategories.title
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
        view = cardCategoriesView
    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
    }

    override func viewDidDisappear(_ animated: Bool) {

        super.viewDidDisappear(animated)
        cardCategoriesManager.sohranitKategorii()
    }
}

private extension SportivinieKartiKartiKategoriiVC {
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
        let tableView = cardCategoriesView.tableView
        tableView.register(SportivinieKartiKartiKategoriiTVC.self, forCellReuseIdentifier: SportivinieKartiKartiKategoriiTVC.className)
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.delegate = self
        tableView.dragInteractionEnabled = true

        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
    }

    func kategoriaKartiModel(for indexPath: IndexPath) -> KartaKategoriiModel? {

        cardCategoriesManager.switchableCardCategories[safe: indexPath.row]
    }

    func postavitKategoriu(_ category: KategoriiKart, enabled: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        var sourceIndex: Int?
        var destinationIndex: Int?

        self.cardCategoriesManager.postavitKategoriu(
            category,
            enabled: enabled,
            movedFrom: &sourceIndex,
            to: &destinationIndex
        )
        guard let fromIndex = sourceIndex, let toIndex = destinationIndex else { return }

        let fromIndexPath: IndexPath = .init(row: fromIndex, section: 0)
        let toIndexPath: IndexPath = .init(row: toIndex, section: 0)

        cardCategoriesView.tableView.moveRow(at: fromIndexPath, to: toIndexPath)
        obnovitVidCell()
        obnovitVitAvailiiblity()
    }

    func obnovitVidCell() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let tableView = cardCategoriesView.tableView

        let categoryCells = tableView.visibleCells.compactMap { $0 as? SportivinieKartiKartiKategoriiTVC }
        let indexPaths = categoryCells.compactMap { tableView.indexPath(for: $0) }

        zip(categoryCells, indexPaths).forEach { _, _ in
//            cell.updateCellPosition(UITableView.cellPosition(for: indexPath, basedOn: cardCategoriesManager.allCardCategories))
        }
    }

    func obnovitVidPosleDvizheniya(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let tableView = cardCategoriesView.tableView

        var categoryCells = tableView.visibleCells.compactMap { $0 as? SportivinieKartiKartiKategoriiTVC }
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

    func obnovitVitAvailiiblity() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardCategoriesView.tableView
            .visibleCells
            .compactMap { $0 as? SportivinieKartiKartiKategoriiTVC }
            .forEach { $0.postavitSwitchVikluchit(available: cardCategoriesManager.isAvailableToSwitchOff) }
    }

    @objc func zakritNazhata() {
        delegate?.cardCategoriesViewControllerzakrtiNazhata(self)
    }
}

// MARK: - Table View Data Source

extension SportivinieKartiKartiKategoriiVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return cardCategoriesManager.allCardCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let categoryModel = kategoriaKartiModel(for: indexPath) else {
            return .init()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: SportivinieKartiKartiKategoriiTVC.className, for: indexPath) as? SportivinieKartiKartiKategoriiTVC

        cell?.postavitCellKategorii(with: categoryModel, onCategoryDidSwitch: { [weak self] isEnabled in
            self?.postavitKategoriu(categoryModel.category, enabled: isEnabled)
        })
//        cell?.updateCellPosition(UITableView.cellPosition(for: indexPath, basedOn: cardCategoriesManager.allCardCategories))
        cell?.postavitSwitchVikluchit(available: cardCategoriesManager.isAvailableToSwitchOff)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return indexPath.row <= cardCategoriesManager.lastEnabledCategoryIndex
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        cardCategoriesManager.dvigatKategoriu(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }

}

// MARK: - Table View Drag Delegate

extension SportivinieKartiKartiKategoriiVC: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, dragSessionIsRestrictedToDraggingApplication session: UIDragSession) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return true
    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard indexPath.row <= cardCategoriesManager.lastEnabledCategoryIndex else {
            return []
        }

        let item = UIDragItem(itemProvider: .init())
        item.localObject = indexPath
        return [item]
    }

    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }

        let preview = UIDragPreviewParameters()
        preview.visiblePath = UIBezierPath(roundedRect: cell.bounds.insetBy(dx: 20, dy: 3), cornerRadius: 16)
        return preview
    }

}

// MARK: - Table View Drop Delegate

extension SportivinieKartiKartiKategoriiVC: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if let item = session.items.first,
           let fromIndexPath = item.localObject as? IndexPath,
           let toIndexPath = destinationIndexPath,
           toIndexPath.row <= cardCategoriesManager.lastEnabledCategoryIndex {
            obnovitVidPosleDvizheniya(from: fromIndexPath, to: toIndexPath)
            return .init(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            obnovitVidCell()
            return .init(operation: .cancel)
        }
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }

    func tableView(_ tableView: UITableView, dropSessionDidEnd session: UIDropSession) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        obnovitVidCell()
    }

    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }

        let preview = UIDragPreviewParameters()
        preview.visiblePath = UIBezierPath(roundedRect: cell.bounds.insetBy(dx: 20, dy: 0), cornerRadius: 0)
        return preview
    }
}

extension SportivinieKartiKartiKategoriiVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
}
