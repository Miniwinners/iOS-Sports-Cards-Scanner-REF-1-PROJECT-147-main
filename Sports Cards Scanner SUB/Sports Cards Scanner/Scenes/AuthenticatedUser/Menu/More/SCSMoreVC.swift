import UIKit

final class SCSMoreVC: UIViewController {

    weak var delegate: MoreViewControllerDelegate?
    private let authService: AuthService

    private lazy var profileItems: [ProfileItem] = {
        ProfileItem.allCases
            .filter { $0 != .pushNotifications }
            .filter { (authService.authProviders.contains(.byPassword)) ? true : ($0 != .updatePassword) }
    }()

    // MARK: - Subviews

    lazy var moreView: SCSMoreView = .init()

    init(authService: AuthService) {
        self.authService = authService

        super.init(nibName: nil, bundle: nil)
        self.title = L10n.More.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = moreView
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
}

private extension SCSMoreVC {
    func setupViews_unique() {
        moreView.tableView.register(ProfileSelectableCell.self, forCellReuseIdentifier: ProfileSelectableCell.className)
        moreView.tableView.register(ProfileSwitchableCell.self, forCellReuseIdentifier: ProfileSwitchableCell.className)

        moreView.tableView.delegate = self
        moreView.tableView.dataSource = self
    }
}

// MARK: - TableView Data Source

extension SCSMoreVC: UITableViewDataSource {
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

        return profileItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = profileItem(for: indexPath) else {
            return .init()
        }

        let cell: UITableViewCell?

        switch item.type {
        case .selectable:
            let selectableCell = tableView.dequeueReusableCell(
                withIdentifier: ProfileSelectableCell.className,
                for: indexPath
            ) as? ProfileSelectableCell

            selectableCell?.setProfileItem(item)
            selectableCell?.titleLabel.textColor = item == .deleteAccount ? .destructiveColor : .labelColor
            cell = selectableCell

        case .switchable:
            let switchableCell = tableView.dequeueReusableCell(
                withIdentifier: ProfileSwitchableCell.className,
                for: indexPath
            ) as? ProfileSwitchableCell

            switchableCell?.setProfileItem(item, selected: true)
            cell = switchableCell
        }

        return cell ?? .init()
    }

    private func profileItem(for indexPath: IndexPath) -> ProfileItem? {
        profileItems[safe: indexPath.row]
    }
}

// MARK: - TableView Delegate

extension SCSMoreVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let profileItem = profileItem(for: indexPath) {
            delegate?.moreViewControllerDidPressItem(profileItem, in: self)
        }
    }
}
