import UIKit
import SnapKit
func vicheslitFibonc170(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCurrentValueDetaliVC: UIViewController {

    private let cardsManager: SportivinieKartiUserKartManager

    weak var delegate: SportivinieKartiCurrentValueDetaliDelegat?

    // MARK: - Subviews
    lazy var backView: BackView = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.contentInset.bottom = 20
        return scrollView
    }(SportivinieKartiBSV())

    lazy var currentValueDetailsView: SportivinieKartiCurrentValueDetaliVid = .init()

    init(cardsManager: SportivinieKartiUserKartManager = .shared) {
        self.cardsManager = cardsManager
        super.init(nibName: nil, bundle: nil)
        currentValueDetailsView.titleLabel.text = L10n.CurrentValue.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {

        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        postavitVid()
        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
    }

}

private extension SportivinieKartiCurrentValueDetaliVC {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    var categoryValues: [(KategoriiKart, Double)] {
        KategoriiKart.allCases
            .map { ($0, cardsManager.kartaZnachenie(of: $0)) }
            .filter { $0.1 != 0 }
    }

    func postavitVid() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        view.backgroundColor = .clear
        backView.postavitVid(in: view)

        currentValueDetailsView.categoryValuesTable.delegate = self
        currentValueDetailsView.categoryValuesTable.dataSource = self

        backView.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        scrollView.addSubview(currentValueDetailsView)
        currentValueDetailsView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.high)
        }

        currentValueDetailsView.postavitZnachenitCategorii(current: cardsManager.currentCardsValue, categories: categoryValues)
    }

    func znachenieKategorii(at indexPath: IndexPath) -> (KategoriiKart, Double)? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categoryValues[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func zakritNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.tekusheeZakritNashata(self)
    }
}

// MARK: - UITableViewDataSource

extension SportivinieKartiCurrentValueDetaliVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return cardsManager.enabledCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SCDCurrentValueDetaliCl.cellIdentifier, for: indexPath) as? SCDCurrentValueDetaliCl else { fatalError() }

        if let categoryValue = znachenieKategorii(at: indexPath) {
            cell.postavit(category: categoryValue.0, value: categoryValue.1)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        let headerView = UILabel.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.sectionHeaderHeight))

        lazy var categoryValueLabel: UILabel = { label in
            label.text = L10n.CurrentValue.valueByCategory
            label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 27:21)
            label.textColor = .labelColor
            label.setVisotaLabla(32)
            label.setContentHuggingPriority(.required, for: .vertical)
            return label
        }(UILabel())

        headerView.text = categoryValueLabel.text
        headerView.addSubview(categoryValueLabel)
        headerView.textAlignment = .center
        headerView.font = categoryValueLabel.font
        if UIDevice.isIpad {
            headerView.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 30:24)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        if UIDevice.isIphone {
            return 50
        } else {
            return 70
        }
    }
}

// MARK: - UITableViewDelegate

extension SportivinieKartiCurrentValueDetaliVC: UITableViewDelegate {

}
