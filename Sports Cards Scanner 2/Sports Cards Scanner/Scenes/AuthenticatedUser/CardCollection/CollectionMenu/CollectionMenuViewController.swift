import UIKit

final class CollectionMenuViewController: UIViewController {
    weak var delegate: CollectionMenuViewControllerDelegate?

    @UserDefault(UserDefaults.KeyOption.isTotalPriceVisible, defaultValue: true)
    private var isTotalPriceVisible: Bool

    private let menuItems: [CollectionMenuItem]

    // MARK: - Subviews

    lazy var collectionMenuView: MenuView = .init()

    init(menuItems: [CollectionMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = collectionMenuView
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

//    override var preferredContentSize: CGSize {
//        get {
//            let edgesButtonsHeightDiff: CGFloat = 8
//            let menuBottomSpace: CGFloat = 122
//            let height: CGFloat = (collectionMenuView.menuTableView.estimatedRowHeight * CGFloat(menuItems.count)) - edgesButtonsHeightDiff + menuBottomSpace
//            view.layoutIfNeeded()
//            return .init(width: view.frame.width, height: height)
//        }
//        set {
//            super.preferredContentSize = newValue
//        }
//    }
}

private extension CollectionMenuViewController {
    func setupViews_unique() {
        let menuCollectionView = collectionMenuView.menuCollectionView
        menuCollectionView.register(MenuSelectableCell.self, forCellWithReuseIdentifier: MenuSelectableCell.className)
        menuCollectionView.register(MenuSwitchableCell.self, forCellWithReuseIdentifier: MenuSwitchableCell.className)
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
    }

    func setupActions_unique() {
        collectionMenuView.cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
    }

    func menuItem(at indexPath: IndexPath) -> CollectionMenuItem? {
        menuItems[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func cancelTapped_unique() {
        delegate?.collectionMenuViewControllerCancelTapped(self)
    }
}

// MARK: - TableView DataSource

extension CollectionMenuViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return menuItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let menuItem = menuItem(at: indexPath) else {
            return .init()
        }

        let cell: UICollectionViewCell?

        switch menuItem {
        case .showTotalPrice:
            let switchableCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuSwitchableCell.className, for: indexPath) as? MenuSwitchableCell
            switchableCell?.setMenuItem(menuItem, selected: isTotalPriceVisible)
//            switchableCell?.setCellPosition(UICollectionView.cellPosition(for: indexPath, basedOn: menuItems))
            switchableCell?.switchValueDidChange = { [weak self] isOn in
                self?.isTotalPriceVisible = isOn
            }

            cell = switchableCell

        default:
            let selectableCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuSelectableCell.className, for: indexPath) as? MenuSelectableCell
            selectableCell?.setMenuItem(menuItem)
//            selectableCell?.setCellPosition(UICollectionView.cellPosition(for: indexPath, basedOn: menuItems))

            cell = selectableCell
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension CollectionMenuViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuItem = menuItem(at: indexPath),
              menuItem != .showTotalPrice
        else { return }

        delegate?.collectionMenuViewControllerDidSelectItem(menuItem, in: self)
    }
}
