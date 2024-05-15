import UIKit
func vicheslitFibonc164(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiPoiskKartiVC: UIViewController {

    weak var delegate: SportivinieKartiPoiskKartiDelegat?

    private var isAppearedOnce = false

    private let maxLengthValidator: SportivinieKartiDlinaValidator = .init(maxLength: 255)

    private let searchCardService: SportivinieKartiKartaPoiskovaya
    private let searchCategory: KategoriiKart
    private var searchResult: [SportivinieKartiKartaPredstavlenie] = []
    private var searchTask: Task<(), Never>?

    // MARK: - Subviews

    lazy var searchCardView: SportivinieKartiPoiskKartiVid = .init()
    lazy var closeButton: CloseButton = { button in
        return button
    }(CloseButton(style: .close, frame: .zero))

    lazy var keyboardToolbar: SportivinieKartiCToolB = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCToolB.createToolbar(in: view))

    init(
        searchCategory: KategoriiKart,
        searchCardService: SportivinieKartiKartaPoiskovaya = SportivinieKartiPoiskKarti()
    ) {
        self.searchCardService = searchCardService
        self.searchCategory = searchCategory

        super.init(nibName: nil, bundle: nil)
        searchCardView.titleLabel.text = L10n.SearchCard.title
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
        view = searchCardView
        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        computeViewsSportivinieKarti()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !isAppearedOnce {
            searchCardView.searchTextField.becomeFirstResponder()
            isAppearedOnce = true
        }
    }

    override func viewDidDisappear(_ animated: Bool) {

        super.viewDidDisappear(animated)
        searchTask?.cancel()
    }

}

private extension SportivinieKartiPoiskKartiVC {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func computeViewsSportivinieKarti() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        searchCardView.searchTextField.delegate = self

        searchCardView.searchCollectionView.register(SportivinieKartiCardCVC.self, forCellWithReuseIdentifier: SportivinieKartiCardCVC.className)
        searchCardView.searchCollectionView.dataSource = self
        searchCardView.searchCollectionView.delegate = self
    }

    func performSearch() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        searchTask?.cancel()
        guard let query = searchCardView.searchTextField.text, !query.isEmpty else {
            return
        }

        guard SportivinieKartiInternetSoedinenieSc.shared.isNetworkAvailable else {
            let alertType: SportivinieKartitipAlerta = .noInternetConnection(okAction: nil)
            SportivinieKartiAlertSc.shared.podgotovitAlertController(type: alertType, in: self)
            return
        }

        searchCardView.postavitZagryzky(true)
        searchTask = Task { @MainActor in
            defer { searchCardView.postavitZagryzky(false) }

            if Task.isCancelled { return }
            do {
                let searchedCards = try await searchCardService.poiskUnicalnii(query: query, category: searchCategory)
                if Task.isCancelled { return }
                searchResult = searchedCards
                print(searchResult)
                searchCardView.searchCollectionView.reloadData()
                searchCardView.setNoResultsView(visible: searchedCards.isEmpty)
            } catch {
                print("\(error.localizedDescription)")
                searchResult = []
                searchCardView.searchCollectionView.reloadData()
                searchCardView.setNoResultsView(visible: true)

            }
        }
    }

    // MARK: - Actions

    @objc func zakritNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.poiskZakritNazhata(self)
    }

    // MARK: - Helpers

    func polychitKarty(at indexPath: IndexPath) -> SportivinieKartiKartaPredstavlenie? {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let card = searchResult[safe: indexPath.row] else { return nil }
        return card
    }
}

// MARK: - TextField Delegate

extension SportivinieKartiPoiskKartiVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        if textField.inputAccessoryView == nil {
            textField.inputAccessoryView = keyboardToolbar
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        guard let text = textField.text,
              let textRange = Range(range, in: text)
        else { return true }

        let updatedText = text.replacingCharacters(in: textRange, with: string)

        return maxLengthValidator.validnaLiStroka(updatedText)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        switch textField {
        case searchCardView.searchTextField:
            textField.resignFirstResponder()
            performSearch()
        default:
            break
        }

        return true
    }

}

// MARK: - TableView DataSource

extension SportivinieKartiPoiskKartiVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        return  searchResult.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SportivinieKartiCardCVC.className,
            for: indexPath
        ) as? SportivinieKartiCardCVC

        if let card = polychitKarty(at: indexPath) {
            cell?.postavitKarty(card)
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiPoiskKartiVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }

        collectionView.deselectItem(at: indexPath, animated: true)

        guard let card = polychitKarty(at: indexPath) else { return }
        delegate?.poiskVkladkaNazhata(card: card, in: self)

    }
}
