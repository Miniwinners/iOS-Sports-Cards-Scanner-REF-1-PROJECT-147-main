import UIKit

final class SearchCardViewController: UIViewController {

    weak var delegate: SearchCardViewControllerDelegate?

    private var isAppearedOnce = false

    private let maxLengthValidator: LengthValidator = .init(maxLength: 255)

    private let searchCardService: CardSearchable
    private let searchCategory: CardCategory
    private var searchResult: [CardRepresentable] = []
    private var searchTask: Task<(), Never>?

    // MARK: - Subviews

    lazy var searchCardView: SearchCardView = .init()
    lazy var closeButton: CloseButton = { button in
        return button
    }(CloseButton(style: .close, frame: .zero))

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    init(
        searchCategory: CardCategory,
        searchCardService: CardSearchable = SearchCardService()
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
        view = searchCardView
        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
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

    override func viewWillAppear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

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
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidDisappear(animated)
        searchTask?.cancel()
    }

}

private extension SearchCardViewController {
    func setupViews_unique() {

        searchCardView.searchTextField.delegate = self

        searchCardView.searchCollectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.className)
        searchCardView.searchCollectionView.dataSource = self
        searchCardView.searchCollectionView.delegate = self
    }

    func performSearch() {
        searchTask?.cancel()
        guard let query = searchCardView.searchTextField.text, !query.isEmpty else {
            return
        }

        guard NetworkMonitoringService.shared.isNetworkAvailable else {
            let alertType: SCSAlertType = .noInternetConnection(okAction: nil)
            AlertService.shared.presentAC(type: alertType, in: self)
            return
        }

        searchCardView.setLoading(true)
        searchTask = Task { @MainActor in
            defer { searchCardView.setLoading(false) }

            if Task.isCancelled { return }
            do {
                let searchedCards = try await searchCardService.searchUnique(query: query, category: searchCategory)
                if Task.isCancelled { return }
                searchResult = searchedCards
                searchCardView.searchCollectionView.reloadData()
                searchCardView.setNoResultsView(visible: searchedCards.isEmpty)
            } catch {
                searchResult = []
                searchCardView.searchCollectionView.reloadData()
                searchCardView.setNoResultsView(visible: true)
            }
        }
    }

    // MARK: - Actions

    @objc func close() {
        dismiss(animated: true)
    }

    @objc func closeTapped_unique() {
        delegate?.searchCardViewControllerCloseTapped(self)
    }

    // MARK: - Helpers

    func getCard(at indexPath: IndexPath) -> CardRepresentable? {
        guard let card = searchResult[safe: indexPath.row] else { return nil }
        return card
    }
}

// MARK: - TextField Delegate

extension SearchCardViewController: UITextFieldDelegate {
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

        return maxLengthValidator.isValueValid(updatedText)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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

extension SearchCardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  searchResult.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell.className,
            for: indexPath
        ) as? CardCollectionViewCell

        if let card = getCard(at: indexPath) {
            cell?.setupCard(card)
        }
//        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: searchResult))

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension SearchCardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        guard let card = getCard(at: indexPath) else { return }
        delegate?.searchCardViewControllerDidSelect(card: card, in: self)
    }
}
