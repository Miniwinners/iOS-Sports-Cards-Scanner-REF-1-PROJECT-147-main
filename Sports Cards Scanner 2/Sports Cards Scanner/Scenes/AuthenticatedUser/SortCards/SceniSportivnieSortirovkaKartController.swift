import UIKit
import SnapKit
func vicheslitFibonc207(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiSortirovkaKarTableKlrtka: UIViewController {

    weak var delegate: SportivinieKartiSortirovkaKartControllerDelegat?

    private let sortOptions = KartaSortirovkaOpcii.allCases

    @SportivinieKartiUserDefaultCodableWrapper(UserDefaults.KeyOption.selectedCardSortOption, defaultValue: KartaSortirovkaOpcii.default)
    private var selectedSortOption: KartaSortirovkaOpcii

    private lazy var newSelectedSortOption: KartaSortirovkaOpcii = selectedSortOption

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

    lazy var cancelButton: SportivinieKartiCommonKnopka = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(SportivinieKartiCommonKnopka(style: .cancel))

    lazy var doneButton: SportivinieKartiCommonKnopka = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(SportivinieKartiCommonKnopka(style: .default))

    init() {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = L10n.SortCards.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
        postavidDeistviaUnicalno()
    }

}

private extension SportivinieKartiSortirovkaKarTableKlrtka {
    func postavitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        view.backgroundColor = .clear
        backView.postavitVid(in: view)
        titleLabel.postavitLabel(in: backView)
        sortOptionsTableView.register(SportivinieKartiSortirovkaKartTableKletka.self, forCellReuseIdentifier: SportivinieKartiSortirovkaKartTableKletka.className)
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
            $0.height.equalTo(vicheslitOpciiVisoti())
        }
        buttonsStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
            $0.height.equalTo(UIDevice.isIpad ? 172:128)
        }
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavidDeistviaUnicalno() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cancelButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)
    }

    func sortirovkaOpcii(at indexPath: IndexPath) -> KartaSortirovkaOpcii? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return sortOptions[safe: indexPath.section]
    }

    func indexPuti(of sortOption: KartaSortirovkaOpcii) -> IndexPath {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return .init(row: 0, section: sortOption.index)
    }

    func vicheslitOpciiVisoti() -> CGFloat {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let inset: CGFloat = UIDevice.isIpad ? 80:56
        return inset * CGFloat(sortOptions.count) + inset
    }

    // MARK: - Actions

    @objc func otmenaNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.sortCardsViewControllerotmenaNazhata(self)
    }

    @objc func gotovoNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        selectedSortOption = newSelectedSortOption
        delegate?.sortCardsViewControllerGotovoNazhata(self)
    }
}

// MARK: - TableView DataSource

extension SportivinieKartiSortirovkaKarTableKlrtka: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return sortOptions.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SportivinieKartiSortirovkaKartTableKletka.className, for: indexPath) as? SportivinieKartiSortirovkaKartTableKletka

        if let sortOption = sortirovkaOpcii(at: indexPath) {
            cell?.postavitOpciiSortirovki(sortOption)
            cell?.postavitCheck(sortOption == newSelectedSortOption)
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
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
        if section == 0 { return 0 } else { return 8 }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return UIDevice.isIpad ? 80:50
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiSortirovkaKarTableKlrtka: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let oldCheckedCellIndexPath = self.indexPuti(of: newSelectedSortOption)
        let oldCheckedCell = tableView.cellForRow(at: oldCheckedCellIndexPath) as? SportivinieKartiSortirovkaKartTableKletka
        let newCheckedCell = tableView.cellForRow(at: indexPath) as? SportivinieKartiSortirovkaKartTableKletka
        oldCheckedCell?.postavitCheck(false)
        newCheckedCell?.postavitCheck(true)

        newSelectedSortOption = sortirovkaOpcii(at: indexPath) ?? newSelectedSortOption
    }
}

extension SportivinieKartiSortirovkaKarTableKlrtka: SportivinieKartiSwaipProtocol {
    var isSwipeBackEnabled: Bool { false }
}
