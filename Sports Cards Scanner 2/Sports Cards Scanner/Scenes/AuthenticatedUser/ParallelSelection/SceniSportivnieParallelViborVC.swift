import UIKit
func vicheslitFibonc211(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiParallelViborController: UIViewController {

    private let parallels: [SportivinieKartiKartaParallel]
    private let selectedParallelIndex: Int?
    private var convertedToSearchedParallelIndex: Int? {
        guard let index = selectedParallelIndex,
              let parallel = parallels[safe: index]
        else { return nil }
        return searchParallels.firstIndex(of: parallel)
    }

    private var searchText: String = ""
    private var searchParallels: [SportivinieKartiKartaParallel] {
        if searchText.isEmpty { return parallels }
        let searchString = searchText.lowercased()
        return parallels.filter { $0.name.lowercased().contains(searchString) }
    }

    var parallelDidSelect: ((Int?) -> Void)?

    // MARK: - Subviews

    lazy var parallelSelectionView: SportivinieKartiParallelViborVid = .init()
    lazy var closeButton: CloseButton = .init(style: .back)

    lazy var keyboardToolbar: SportivinieKartiCustomTool = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCustomTool.createToolbar(in: view))

    init(parallels: [SportivinieKartiKartaParallel], selected: Int?) {
        self.parallels = parallels
        self.selectedParallelIndex = selected
        super.init(nibName: nil, bundle: nil)
        parallelSelectionView.titleLabel.text = L10n.ParallelSelection.title
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
        view = parallelSelectionView
    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
        postavidDeistviaUnicalno()
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
    }

}

private extension SportivinieKartiParallelViborController {
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
        let parallelsView = parallelSelectionView.parallelsCollectionView
        parallelsView.register(SportivinieKartiParallelCollectionKletka.self, forCellWithReuseIdentifier: SportivinieKartiParallelCollectionKletka.className)
        parallelsView.dataSource = self
        parallelsView.delegate = self

        parallelSelectionView.searchTextField.delegate = self
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        parallelSelectionView.clearSearchButton.addTarget(self, action: #selector(ochistiPoiskNazhata), for: .touchUpInside)
        parallelSelectionView.noneParallelButton.addTarget(self, action: #selector(noneParallelDidSelect), for: .touchUpInside)
    }

    func postavitParallel(at indexPath: IndexPath) -> SportivinieKartiKartaParallel? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return searchParallels[safe: indexPath.row]
    }

    func indexVsehParallel(of parallel: SportivinieKartiKartaParallel) -> Int? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return parallels.firstIndex(of: parallel)
    }

    // MARK: - Actions

    @objc func ochistiPoiskNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        parallelSelectionView.searchTextField.text = ""
        searchText = ""
        parallelSelectionView.parallelsCollectionView.reloadData()
        parallelSelectionView.clearSearchButton.isHidden = true
        parallelSelectionView.searchImageView.isHidden = false
        parallelSelectionView.searchTextField.becomeFirstResponder()
        parallelSelectionView.postavitVidBezResultatov(visible: searchParallels.isEmpty)
    }

    @objc func noneParallelDidSelect() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if let index = convertedToSearchedParallelIndex,
           let selectedCell = parallelSelectionView.parallelsCollectionView
            .cellForItem(at: .init(row: index, section: 0)) as? SportivinieKartiParallelCollectionKletka {
            selectedCell.postavitParallelVibrano(false)
        }

        parallelDidSelect?(nil)
    }
    @objc func pop() {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CollectionView DataSource

extension SportivinieKartiParallelViborController: UICollectionViewDataSource {
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
        return searchParallels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiParallelCollectionKletka.className, for: indexPath) as? SportivinieKartiParallelCollectionKletka

        if let parallel = postavitParallel(at: indexPath) {
            cell?.postavitParallel(parallel)
        }
        cell?.postavitParallelVibrano(indexPath.row == convertedToSearchedParallelIndex)

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - CollectionView Flow Delegate

extension SportivinieKartiParallelViborController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let inRowItems: CGFloat = 3
        let interitemSpace = flowLayout?.minimumInteritemSpacing ?? 0
        let interitemSpaces = interitemSpace * (inRowItems - 1)
        let horizontalSpaces = (flowLayout?.sectionInset.left ?? 0) + (flowLayout?.sectionInset.right ?? 0)
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = (collectionViewWidth - interitemSpaces - horizontalSpaces) / inRowItems
        let itemHeight = itemWidth + 23
        return .init(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiParallelCollectionKletka
        cell?.videlitCell(true)

    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiParallelCollectionKletka
        cell?.videlitCell(false)
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        if let index = convertedToSearchedParallelIndex,
           let selectedCell = collectionView.cellForItem(at: .init(row: index, section: 0)) as? SportivinieKartiParallelCollectionKletka {
            selectedCell.postavitParallelVibrano(false)
        }

        let newSelectedCell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiParallelCollectionKletka
        newSelectedCell?.postavitParallelVibrano(true)

        guard let searchedParallel = postavitParallel(at: indexPath),
              let parallelIndex = indexVsehParallel(of: searchedParallel)
        else { return }

        parallelDidSelect?(parallelIndex)
    }
}

extension SportivinieKartiParallelViborController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        if textField.inputAccessoryView == nil {
            textField.inputAccessoryView = keyboardToolbar
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        guard let text = textField.text,
              let textRange = Range(range, in: text)
        else { return true }

        let updatedText = text.replacingCharacters(in: textRange, with: string)

        parallelSelectionView.clearSearchButton.isHidden = updatedText.isEmpty
        parallelSelectionView.searchImageView.isHidden = !updatedText.isEmpty

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        searchText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        textField.text = searchText
        parallelSelectionView.parallelsCollectionView.reloadData()
        parallelSelectionView.clearSearchButton.isHidden = searchText.isEmpty
        parallelSelectionView.searchImageView.isHidden = !searchText.isEmpty
        parallelSelectionView.postavitVidBezResultatov(visible: searchParallels.isEmpty)
        textField.resignFirstResponder()
        return true
    }
}
