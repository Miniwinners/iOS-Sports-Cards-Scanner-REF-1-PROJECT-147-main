import UIKit
func vicheslitFibonc259(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiMenuKolodaVC: UIViewController {
    weak var delegate: SportivinieKartiMenuKolodaDelegat?

    @SportivinieKartiUserDefaultWrapper(UserDefaults.KeyOption.isTotalPriceVisible, defaultValue: true)
    private var isTotalPriceVisible: Bool

    private let menuItems: [SportivinieKartiMenuKolodaShtuka]

    // MARK: - Subviews

    lazy var deckMenuView: SportivinieKartiMenuV = .init()

    init(menuItems: [SportivinieKartiMenuKolodaShtuka]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = deckMenuView
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

private extension SportivinieKartiMenuKolodaVC {
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
        let menuCollectionView = deckMenuView.menuCollectionView
        menuCollectionView.register(SportivinieKartiMSelectC.self, forCellWithReuseIdentifier: SportivinieKartiMSelectC.className)
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        deckMenuView.cancelButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
    }

    func meniShtuka(at indexPath: IndexPath) -> SportivinieKartiMenuKolodaShtuka? {
        menuItems[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func otmenaNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.deckMenuViewControllerotmenaNazhata(self)
    }
}

// MARK: - TableView DataSource

extension SportivinieKartiMenuKolodaVC: UICollectionViewDataSource {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiMSelectC.className, for: indexPath) as? SportivinieKartiMSelectC
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if let menuItem = meniShtuka(at: indexPath) {
            cell?.postavitMenuShtuku(menuItem)
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiMenuKolodaVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let menuItem = meniShtuka(at: indexPath) else { return }
        delegate?.deckMenuViewControllerOtpustit(menuItem, in: self)
    }
}
