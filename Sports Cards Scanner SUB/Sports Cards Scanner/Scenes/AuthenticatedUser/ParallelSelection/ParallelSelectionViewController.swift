import UIKit

final class ParallelSelectionViewController: UIViewController {

    private let parallels: [CardParallel]
    private let selectedParallelIndex: Int?
    private var convertedToSearchedParallelIndex: Int? {
        guard let index = selectedParallelIndex,
              let parallel = parallels[safe: index]
        else { return nil }
        return searchParallels.firstIndex(of: parallel)
    }

    private var searchText: String = ""
    private var searchParallels: [CardParallel] {
        if searchText.isEmpty { return parallels }
        let searchString = searchText.lowercased()
        return parallels.filter { $0.name.lowercased().contains(searchString) }
    }

    var parallelDidSelect: ((Int?) -> Void)?

    // MARK: - Subviews

    lazy var parallelSelectionView: ParallelSelectionView = .init()
    lazy var closeButton: CloseButton = .init(style: .back)

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    init(parallels: [CardParallel], selected: Int?) {
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
        view = parallelSelectionView
    }

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupViews_unique()
        setupActions_unique()
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
    }

}

private extension ParallelSelectionViewController {
    func setupViews_unique() {
        let parallelsView = parallelSelectionView.parallelsCollectionView
        parallelsView.register(ParallelCollectionViewCell.self, forCellWithReuseIdentifier: ParallelCollectionViewCell.className)
        parallelsView.dataSource = self
        parallelsView.delegate = self

        parallelSelectionView.searchTextField.delegate = self
    }

    func setupActions_unique() {
        parallelSelectionView.clearSearchButton.addTarget(self, action: #selector(clearSearchTapped), for: .touchUpInside)
        parallelSelectionView.noneParallelButton.addTarget(self, action: #selector(noneParallelDidSelect), for: .touchUpInside)
    }

    func parallel(at indexPath: IndexPath) -> CardParallel? {
        searchParallels[safe: indexPath.row]
    }

    func indexInAllParallels(of parallel: CardParallel) -> Int? {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return parallels.firstIndex(of: parallel)
    }

    // MARK: - Actions

    @objc func clearSearchTapped() {
        parallelSelectionView.searchTextField.text = ""
        searchText = ""
        parallelSelectionView.parallelsCollectionView.reloadData()
        parallelSelectionView.clearSearchButton.isHidden = true
        parallelSelectionView.searchImageView.isHidden = false
        parallelSelectionView.searchTextField.becomeFirstResponder()
        parallelSelectionView.setNoResultsView(visible: searchParallels.isEmpty)
    }

    @objc func noneParallelDidSelect() {
        if let index = convertedToSearchedParallelIndex,
           let selectedCell = parallelSelectionView.parallelsCollectionView
            .cellForItem(at: .init(row: index, section: 0)) as? ParallelCollectionViewCell {
            selectedCell.setParallelSelected(false)
        }

        parallelDidSelect?(nil)
    }
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CollectionView DataSource

extension ParallelSelectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return searchParallels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParallelCollectionViewCell.className, for: indexPath) as? ParallelCollectionViewCell

        if let parallel = parallel(at: indexPath) {
            cell?.setParallel(parallel)
        }
        cell?.setParallelSelected(indexPath.row == convertedToSearchedParallelIndex)

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - CollectionView Flow Delegate

extension ParallelSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
        let cell = collectionView.cellForItem(at: indexPath) as? ParallelCollectionViewCell
        cell?.setCellHighlighted(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ParallelCollectionViewCell
        cell?.setCellHighlighted(false)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = convertedToSearchedParallelIndex,
           let selectedCell = collectionView.cellForItem(at: .init(row: index, section: 0)) as? ParallelCollectionViewCell {
            selectedCell.setParallelSelected(false)
        }

        let newSelectedCell = collectionView.cellForItem(at: indexPath) as? ParallelCollectionViewCell
        newSelectedCell?.setParallelSelected(true)

        guard let searchedParallel = parallel(at: indexPath),
              let parallelIndex = indexInAllParallels(of: searchedParallel)
        else { return }

        parallelDidSelect?(parallelIndex)
    }
}

extension ParallelSelectionViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.inputAccessoryView == nil {
            textField.inputAccessoryView = keyboardToolbar
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
              let textRange = Range(range, in: text)
        else { return true }

        let updatedText = text.replacingCharacters(in: textRange, with: string)

        parallelSelectionView.clearSearchButton.isHidden = updatedText.isEmpty
        parallelSelectionView.searchImageView.isHidden = !updatedText.isEmpty

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        textField.text = searchText
        parallelSelectionView.parallelsCollectionView.reloadData()
        parallelSelectionView.clearSearchButton.isHidden = searchText.isEmpty
        parallelSelectionView.searchImageView.isHidden = !searchText.isEmpty
        parallelSelectionView.setNoResultsView(visible: searchParallels.isEmpty)
        textField.resignFirstResponder()
        return true
    }
}
