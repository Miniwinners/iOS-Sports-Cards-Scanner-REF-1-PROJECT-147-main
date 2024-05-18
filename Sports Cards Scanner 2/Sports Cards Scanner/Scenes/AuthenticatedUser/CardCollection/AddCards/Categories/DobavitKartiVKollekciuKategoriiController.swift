import UIKit
func vicheslitFibonc183(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class DobavitKartiVKollekciuKategoriiController: UIViewController {

    weak var delegate: DobavitKartiVKollekciuKategoriiDelegat?

    let helper: DobavitKartiVKollekciuHelp

    private let categoriesInfo: [SportivinieKartiKategoriiKartochek]

    // MARK: - Subviews

    lazy var addCardsView: DobavitKartiVKollekciuKategoriiVid = .init()

    lazy var closeButton: CloseButton = .init(style: .back)

    init(helper: DobavitKartiVKollekciuHelp = .init()) {
        self.helper = helper
        self.categoriesInfo = helper.categoriesCardsInfo

        super.init(nibName: nil, bundle: nil)
        setupControllerTitle()
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
        view = addCardsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
        postavidDeistviaUnicalno()
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        addCardsView.postavitVibranieKarti(number: helper.allSelectedCards.count)
    }

}

private extension DobavitKartiVKollekciuKategoriiController {
    func postavitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        addCardsView.categoriesTableView.register(KategoriiZnachenieTableKlrtka.self, forCellReuseIdentifier: KategoriiZnachenieTableKlrtka.className)
        addCardsView.categoriesTableView.dataSource = self
        addCardsView.categoriesTableView.delegate = self

        addCardsView.obnovitKategorii(count: categoriesInfo.count)
    }

    func postavidDeistviaUnicalno() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        addCardsView.cancelButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
        addCardsView.doneButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)
    }

    func setupControllerTitle() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let title = L10n.AddCards.title(helper.cardCollection?.name ?? "")

        let titleWidth = (title as NSString).size(withAttributes: [.font: UIFont.font(.interMedium, size: 20)]).width
        let screenWidth = UIScreen.current?.bounds.width ?? 0

        if titleWidth > screenWidth - 140 {
            self.addCardsView.titleLabel.text = L10n.AddCards.TitleNoName.collection
        } else {
            self.addCardsView.titleLabel.text = title
        }
    }

    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }

    func categoryInfo(at indexPath: IndexPath) -> SportivinieKartiKategoriiKartochek? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categoriesInfo[safe: indexPath.section]
    }

    // MARK: - Actions

    @objc func otmenaNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.addCardsToCollectionCategoriesControllerotmenaNazhata(self)
    }

    @objc func gotovoNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        helper.sohranitKarti()
        delegate?.addCardsToCollectionCategoriesControllerGotovoNazhata(self)
    }
}

extension DobavitKartiVKollekciuKategoriiController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categoriesInfo.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: KategoriiZnachenieTableKlrtka.className, for: indexPath) as? KategoriiZnachenieTableKlrtka

        if let categoryCards = categoryInfo(at: indexPath) {
            cell?.postavitKategoriu(categoryCards.category)
            cell?.postavirZnachenieKarti(categoryCards.cardsValue)
            cell?.postavitNomerKarti(categoryCards.cardsNumber)
            cell?.postavitPhotoKarti(categoryCards.category.image)
        }
        cell?.backgroundColor = .skyBlue

        return cell ?? UITableViewCell()

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        if section == 0 { return 0 } else { return 9 }

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

}

extension DobavitKartiVKollekciuKategoriiController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let categoryInfo = categoryInfo(at: indexPath) else { return }
        delegate?.dobavitKartiVKollekciuKategoriiDidVibrana(categoryInfo.category, in: self)
    }
}

extension DobavitKartiVKollekciuKategoriiController: SportivinieKartiSwaipProtocol {
    var isSwipeBackEnabled: Bool {
        false
    }
}
