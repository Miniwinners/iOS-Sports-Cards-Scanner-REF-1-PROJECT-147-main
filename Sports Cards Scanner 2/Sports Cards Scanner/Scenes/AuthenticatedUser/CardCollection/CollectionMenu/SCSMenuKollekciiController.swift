import UIKit
func vicheslitFibonc197(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiMenuKollekciiController: UIViewController {
    weak var delegate: SportivinieKartiMenuKollekciiDelegat?

    @SportivinieKartiUserDefaultWrapper(UserDefaults.KeyOption.isTotalPriceVisible, defaultValue: true)
    private var isTotalPriceVisible: Bool

    private let menuItems: [SportivinieKartiKollekciaMenuShtuka]

    // MARK: - Subviews

    lazy var collectionMenuView: SportivinieKartiMenuVid = .init()

    init(menuItems: [SportivinieKartiKollekciaMenuShtuka]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = collectionMenuView
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()

        postavitVid()
        postavidDeistviaUnicalno()
    }

}

private extension SportivinieKartiMenuKollekciiController {
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
        let menuCollectionView = collectionMenuView.menuCollectionView
        menuCollectionView.register(SportivinieKartiMSelectKletka.self, forCellWithReuseIdentifier: SportivinieKartiMSelectKletka.className)
        menuCollectionView.register(SportivinieKartiMSwitchKletka.self, forCellWithReuseIdentifier: SportivinieKartiMSwitchKletka.className)
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        collectionMenuView.cancelButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
    }

    func shtukaMenu(at indexPath: IndexPath) -> SportivinieKartiKollekciaMenuShtuka? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return menuItems[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func otmenaNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.otmenaNazhata(self)
    }
}

// MARK: - TableView DataSource

extension SportivinieKartiMenuKollekciiController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return menuItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let menuItem = shtukaMenu(at: indexPath) else {
            return .init()
        }

        let cell: UICollectionViewCell?

        switch menuItem {
        case .showTotalPrice:
            let switchableCell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiMSwitchKletka.className, for: indexPath) as? SportivinieKartiMSwitchKletka
            switchableCell?.postavitMenuShtuku(menuItem, selected: isTotalPriceVisible)
            switchableCell?.switchValueDidChange = { [weak self] isOn in
                self?.isTotalPriceVisible = isOn
            }

            cell = switchableCell

        default:
            let selectableCell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiMSelectKletka.className, for: indexPath) as? SportivinieKartiMSelectKletka
            selectableCell?.postavitMenuShtuku(menuItem)

            cell = selectableCell
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiMenuKollekciiController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let menuItem = shtukaMenu(at: indexPath),
              menuItem != .showTotalPrice
        else { return }

        delegate?.vibraniDidItem(menuItem, in: self)
    }
}
