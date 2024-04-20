import UIKit

final class DeckMenuViewController: UIViewController {
    weak var delegate: DeckMenuViewControllerDelegate?

    @UserDefault(UserDefaults.KeyOption.isTotalPriceVisible, defaultValue: true)
    private var isTotalPriceVisible: Bool

    private let menuItems: [DeckMenuItem]

    // MARK: - Subviews

    lazy var deckMenuView: MenuView = .init()

    init(menuItems: [DeckMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = deckMenuView
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
//            let height: CGFloat = (deckMenuView.menuCollectionView.estimatedRowHeight * CGFloat(menuItems.count)) - edgesButtonsHeightDiff + menuBottomSpace
//            view.layoutIfNeeded()
//            return .init(width: view.frame.width, height: height)
//        }
//        set {
//            super.preferredContentSize = newValue
//        }
//    }
}

private extension DeckMenuViewController {
    func setupViews_unique() {
        let menuCollectionView = deckMenuView.menuCollectionView
        menuCollectionView.register(MenuSelectableCell.self, forCellWithReuseIdentifier: MenuSelectableCell.className)
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
    }

    func setupActions_unique() {
        deckMenuView.cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
    }

    func menuItem(at indexPath: IndexPath) -> DeckMenuItem? {
        menuItems[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func cancelTapped_unique() {
        delegate?.deckMenuViewControllerCancelTapped(self)
    }
}

// MARK: - TableView DataSource

extension DeckMenuViewController: UICollectionViewDataSource {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuSelectableCell.className, for: indexPath) as? MenuSelectableCell

        if let menuItem = menuItem(at: indexPath) {
            cell?.setMenuItem(menuItem)
        }
//        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: menuItems))

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension DeckMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        guard let menuItem = menuItem(at: indexPath) else { return }
        delegate?.deckMenuViewControllerDidSelectItem(menuItem, in: self)
    }
}
