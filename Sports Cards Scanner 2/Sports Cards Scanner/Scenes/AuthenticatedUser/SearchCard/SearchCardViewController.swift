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
        title = L10n.SearchCard.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = searchCardView
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
        navigationController?.setNavigationBarHidden(false, animated: animated)
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

        searchCardView.searchTableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.className)
        searchCardView.searchTableView.dataSource = self
        searchCardView.searchTableView.delegate = self
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
                searchCardView.searchTableView.reloadData()
                searchCardView.setNoResultsView(visible: searchedCards.isEmpty)
            } catch {
                searchResult = []
                searchCardView.searchTableView.reloadData()
                searchCardView.setNoResultsView(visible: true)
            }
        }
    }

    // MARK: - Actions

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

extension SearchCardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CardTableViewCell.className,
            for: indexPath
        ) as? CardTableViewCell

        if let card = getCard(at: indexPath) {
            cell?.setupCard(card)
        }
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: searchResult))

        return cell ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension SearchCardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let card = getCard(at: indexPath) else { return }
        delegate?.searchCardViewControllerDidSelect(card: card, in: self)
//        present(CardDetailsViewController(card: card), animated: true)
    }
}
