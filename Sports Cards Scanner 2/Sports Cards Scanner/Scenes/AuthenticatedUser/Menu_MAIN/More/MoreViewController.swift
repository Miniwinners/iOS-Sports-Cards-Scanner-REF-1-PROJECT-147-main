import UIKit
import SnapKit
final class MoreViewController: UIViewController {

    weak var delegate: MoreViewControllerDelegate?
    private let authService: AuthService

    private lazy var profileItems: [ProfileItem] = {
        ProfileItem.allCases
            .filter { $0 != .pushNotifications }
            .filter { (authService.authProviders.contains(.byPassword)) ? true : ($0 != .updatePassword) }
    }()

    // MARK: - Subviews

    lazy var moreView: MoreView = .init()

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

private extension MoreViewController {
    func setupViews_unique() {
        moreView.tableView.register(ProfileSelectableCell.self, forCellReuseIdentifier: ProfileSelectableCell.className)
        moreView.tableView.register(ProfileSwitchableCell.self, forCellReuseIdentifier: ProfileSwitchableCell.className)

        moreView.tableView.delegate = self
        moreView.tableView.dataSource = self

    }
}

// MARK: - TableView Data Source

extension MoreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        return profileItems.count
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
        guard let item = profileItem(for: indexPath) else {
            return .init()
        }

        let cell: UITableViewCell?

        switch item.type {
        case .selectable:
            let selectableCell = tableView.dequeueReusableCell(withIdentifier: ProfileSelectableCell.className, for: indexPath) as? ProfileSelectableCell
            selectableCell?.setProfileItem(item)
            selectableCell?.titleLabel.textColor = item == .deleteAccount ? .destructiveColor : .tableViewTitleLabel
            if indexPath.section == 5 { selectableCell?.titleLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20:16) }
            cell = selectableCell
        case .switchable:
            let switchableCell = tableView.dequeueReusableCell(withIdentifier: ProfileSwitchableCell.className, for: indexPath) as? ProfileSwitchableCell
            switchableCell?.setProfileItem(item, selected: true)
            cell = switchableCell
        }

        return cell ?? .init()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 5 {
            if UIDevice.isIphone { return 100 } else { return 250 }} else { return 3 }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .clear
        return footer

    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5 {
            return 20
        } else {
            return 0
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.isIpad ? 100:56
    }

    private func profileItem(for indexPath: IndexPath) -> ProfileItem? {
        profileItems[safe: indexPath.section]
    }
}

// MARK: - TableView Delegate

extension MoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let profileItem = profileItem(for: indexPath) {
            delegate?.moreViewControllerDidPressItem(profileItem, in: self)
        }
    }
}
