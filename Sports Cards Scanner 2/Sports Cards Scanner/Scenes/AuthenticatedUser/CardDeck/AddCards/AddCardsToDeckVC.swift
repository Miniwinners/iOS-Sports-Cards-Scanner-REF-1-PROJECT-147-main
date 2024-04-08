import UIKit

final class AddCardsToDeckVC: UIViewController {

    weak var delegate: AddCardsToDeckVCDelegate?

    private let helper: AddCardsToDeckHelper

    private var searchText: String = ""
    private var searchCards: [CardRepresentable] {
        if searchText.isEmpty { return helper.cards }
        let searchString = searchText.lowercased()
        return helper.cards.filter {
            var cardInfo = "\($0.series) \($0.year) \($0.name)"
            if let cardNumber = $0.cardNumber {
                cardInfo += " #\(cardNumber)"
            }
            return cardInfo
                .lowercased()
                .contains(searchString)
        }
    }

    // MARK: - Subviews

    lazy var addCardsView: AddCardsToDeckView = .init()

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    init(helper: AddCardsToDeckHelper = .init()) {
        self.helper = helper
        super.init(nibName: nil, bundle: nil)
        setupTitle_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = addCardsView
    }

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()

        setupViews_unique()
        setupActions_unique()
    }

}

private extension AddCardsToDeckVC {
    func setupViews_unique() {
        setupNavigationItem()

        let cardsView = addCardsView.cardsTableView
        cardsView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.className)
        cardsView.dataSource = self
        cardsView.delegate = self

        addCardsView.searchTextField.delegate = self

        addCardsView.setSelectedCards(number: helper.selectedCards.count)
        addCardsView.setCategory(helper.cardCategory)
    }

    func setupActions_unique() {
        addCardsView.clearSearchButton.addTarget(self, action: #selector(clearSearchTapped), for: .touchUpInside)
        addCardsView.cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
        addCardsView.doneButton.addTarget(self, action: #selector(doneTapped_unique), for: .touchUpInside)
    }

    func setupNavigationItem() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil
    }

    func setupTitle_unique() {
        let title = L10n.AddCards.title(helper.cardDeck?.name ?? "")

        let titleWidth = (title as NSString).size(withAttributes: [.font: UIFont.font(.interMedium, size: 20)]).width
        let screenWidth = UIScreen.current?.bounds.width ?? 0

        if titleWidth > screenWidth - 140 {
            self.title = L10n.AddCards.TitleNoName.deck
        } else {
            self.title = title
        }
    }

    func card(at indexPath: IndexPath) -> CardRepresentable? {
        searchCards[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func clearSearchTapped() {
        addCardsView.searchTextField.text = ""
        searchText = ""
        addCardsView.cardsTableView.reloadData()
        addCardsView.clearSearchButton.isHidden = true
        addCardsView.searchImageView.isHidden = false
        addCardsView.searchTextField.becomeFirstResponder()
        addCardsView.setNoResultsView(visible: searchCards.isEmpty)
    }

    @objc func cancelTapped_unique() {
        delegate?.addCardsToDeckVCCancelTapped(self)
    }

    @objc func doneTapped_unique() {
        helper.saveCardsToDeck()
        delegate?.addCardsToDeckVCDoneTapped(self)
    }
}

// MARK: - TextField Delegate

extension AddCardsToDeckVC: UITextFieldDelegate {
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

        addCardsView.clearSearchButton.isHidden = updatedText.isEmpty
        addCardsView.searchImageView.isHidden = !updatedText.isEmpty

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        textField.text = searchText
        addCardsView.cardsTableView.reloadData()
        addCardsView.clearSearchButton.isHidden = searchText.isEmpty
        addCardsView.searchImageView.isHidden = !searchText.isEmpty
        addCardsView.setNoResultsView(visible: searchCards.isEmpty)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - TableView DataSource

extension AddCardsToDeckVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return searchCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.className, for: indexPath) as? CardTableViewCell

        if let card = card(at: indexPath) {
            cell?.setupCard(card)
            let isSelected = helper.isSelected(card: card)
            let isAlreadySelected = helper.isAlreadySelected(card: card)
            cell?.setSelectable(!isAlreadySelected)
            cell?.setChecked(isSelected || isAlreadySelected)
        }
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: searchCards))

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let card = card(at: indexPath) else { return }

        let isSelected = helper.isSelected(card: card)
        let cardCell = cell as? CardTableViewCell
        cardCell?.setSelected(isSelected, animated: false)
    }
}

// MARK: - TableView Delegate

extension AddCardsToDeckVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let card = card(at: indexPath),
              !helper.isAlreadySelected(card: card)
        else { return }

        let cell = tableView.cellForRow(at: indexPath) as? CardTableViewCell
        cell?.setChecked(true)

        helper.selectCard(card)
        addCardsView.setSelectedCards(number: helper.selectedCards.count)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let card = card(at: indexPath),
              !helper.isAlreadySelected(card: card)
        else { return }

        let cell = tableView.cellForRow(at: indexPath) as? CardTableViewCell
        cell?.setChecked(false)

        helper.deselectCard(card)
        addCardsView.setSelectedCards(number: helper.selectedCards.count)
    }
}

extension AddCardsToDeckVC: SwipableController {
    var isSwipeBackEnabled: Bool { false }
}
