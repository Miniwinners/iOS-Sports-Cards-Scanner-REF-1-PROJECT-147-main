import UIKit
import SnapKit
func vicheslitFibonc230(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiEsheVC: UIViewController {

    weak var delegate: SportivinieKartiEsheDelegat?
    private let authService: SportivinieKartiAuthenticationSc

    private lazy var profileItems: [SportivinieKartiProfilShtuka] = {
        SportivinieKartiProfilShtuka.allCases
            .filter { $0 != .pushNotifications }
            .filter { (authService.authProviders.contains(.byPassword)) ? true : ($0 != .updatePassword) }
    }()

    // MARK: - Subviews

    lazy var moreView: SportivinieKartiEsheVid = .init()

    init(authService: SportivinieKartiAuthenticationSc) {
        self.authService = authService

        super.init(nibName: nil, bundle: nil)
        self.title = L10n.More.title
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
        view = moreView

    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()
        postavitVid()
    }
}

private extension SportivinieKartiEsheVC {
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
        moreView.tableView.register(SportivinieKartiProfilSelectTVC.self, forCellReuseIdentifier: SportivinieKartiProfilSelectTVC.className)
        moreView.tableView.register(SportivinieKartiProfilSwitchTVC.self, forCellReuseIdentifier: SportivinieKartiProfilSwitchTVC.className)

        moreView.tableView.delegate = self
        moreView.tableView.dataSource = self

    }
}

// MARK: - TableView Data Source

extension SportivinieKartiEsheVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return profileItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let item = profileItem(for: indexPath) else {
            return .init()
        }

        let cell: UITableViewCell?

        switch item.type {
        case .selectable:
            let selectableCell = tableView.dequeueReusableCell(withIdentifier: SportivinieKartiProfilSelectTVC.className, for: indexPath) as? SportivinieKartiProfilSelectTVC
            selectableCell?.postavitProfileShtuku(item)
            selectableCell?.titleLabel.textColor = item == .deleteAccount ? .destructiveColor : .tableViewTitleLabel
            if indexPath.section == 5 { selectableCell?.titleLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20:16) }
            cell = selectableCell
        case .switchable:
            let switchableCell = tableView.dequeueReusableCell(withIdentifier: SportivinieKartiProfilSwitchTVC.className, for: indexPath) as? SportivinieKartiProfilSwitchTVC
            switchableCell?.postavitProfileShtuku(item, selected: true)
            cell = switchableCell
        }

        return cell ?? .init()
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if profileItems.count == 6 {
            if section == 5 {
                if UIDevice.isIphone { return 130 } else { return 140 }} else { return 3 }
        } else { if section == 4 { if UIDevice.isIphone { return 130 } else { return 140 }} else { return 3 }}

    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let footer = UIView()
        footer.backgroundColor = .clear
        return footer

    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if section == 5 {
            return 20
        } else {
            return 0
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return UIDevice.isIpad ? 80:56
    }

    private func profileItem(for indexPath: IndexPath) -> SportivinieKartiProfilShtuka? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return profileItems[safe: indexPath.section]
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiEsheVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        tableView.deselectRow(at: indexPath, animated: true)

        if let profileItem = profileItem(for: indexPath) {
            delegate?.esheNazhalShtuku(profileItem, in: self)
        }
    }
}
