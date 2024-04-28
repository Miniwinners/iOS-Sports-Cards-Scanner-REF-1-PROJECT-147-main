import UIKit
import SnapKit

final class SortCardsViewController: UIViewController {

    weak var delegate: SortCardsViewControllerDelegate?

    private let sortOptions = CardSortOption.allCases

    @UserDefaultCodable(UserDefaults.KeyOption.selectedCardSortOption, defaultValue: CardSortOption.default)
    private var selectedSortOption: CardSortOption

    private lazy var newSelectedSortOption: CardSortOption = selectedSortOption

    // MARK: - Subviews

    lazy var titleLabel: TitleLabel = .init()
    lazy var backView: BackView = .init()
    lazy var closeButton: CloseButton = .init(style: .back)

    lazy var sortOptionsTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.cornerRadius = 12
        tableView.isScrollEnabled = true
        tableView.estimatedRowHeight = UIDevice.isIpad ? 80:50

        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }(UITableView())

    lazy var cancelButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(CommonButton(style: .cancel))

    lazy var doneButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(CommonButton(style: .default))

    init() {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = L10n.SortCards.title
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

        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupViews_unique()
        setupActions_unique()
    }

}

private extension SortCardsViewController {
    func setupViews_unique() {
        view.backgroundColor = .clear
        backView.setupView(in: view)
        titleLabel.setupLabel(in: backView)
        sortOptionsTableView.register(SortCardOptionCell.self, forCellReuseIdentifier: SortCardOptionCell.className)
        sortOptionsTableView.dataSource = self
        sortOptionsTableView.delegate = self

        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 10
        buttonsStackView.distribution = .fillEqually

        backView.addSubviews(sortOptionsTableView, buttonsStackView)
        sortOptionsTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40:30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.height.equalTo(calculateOptionsHeight())
        }
        buttonsStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
            $0.height.equalTo(UIDevice.isIpad ? 172:128)
        }
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
    }

    func setupActions_unique() {
        cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneTapped_unique), for: .touchUpInside)
    }

    func setupNavigationItem() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil
    }

    func sortOption(at indexPath: IndexPath) -> CardSortOption? {
        sortOptions[safe: indexPath.section]
    }

    func indexPath(of sortOption: CardSortOption) -> IndexPath {
        .init(row: 0, section: sortOption.index)
    }

    func calculateOptionsHeight() -> CGFloat {
        let inset: CGFloat = UIDevice.isIpad ? 80:46
        return inset * CGFloat(sortOptions.count) + inset
    }

    // MARK: - Actions

    @objc func cancelTapped_unique() {
        delegate?.sortCardsViewControllerCancelTapped(self)
    }

    @objc func doneTapped_unique() {
        selectedSortOption = newSelectedSortOption
        delegate?.sortCardsViewControllerDoneTapped(self)
    }
}

// MARK: - TableView DataSource

extension SortCardsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return sortOptions.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SortCardOptionCell.className, for: indexPath) as? SortCardOptionCell

        if let sortOption = sortOption(at: indexPath) {
            cell?.setSortOption(sortOption)
            cell?.setChecked(sortOption == newSelectedSortOption)
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 } else { return 8 }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.isIpad ? 80:50
    }
}

// MARK: - TableView Delegate

extension SortCardsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let oldCheckedCellIndexPath = self.indexPath(of: newSelectedSortOption)
        let oldCheckedCell = tableView.cellForRow(at: oldCheckedCellIndexPath) as? SortCardOptionCell
        let newCheckedCell = tableView.cellForRow(at: indexPath) as? SortCardOptionCell
        oldCheckedCell?.setChecked(false)
        newCheckedCell?.setChecked(true)

        newSelectedSortOption = sortOption(at: indexPath) ?? newSelectedSortOption
    }
}

extension SortCardsViewController: SwipableController {
    var isSwipeBackEnabled: Bool { false }
}
