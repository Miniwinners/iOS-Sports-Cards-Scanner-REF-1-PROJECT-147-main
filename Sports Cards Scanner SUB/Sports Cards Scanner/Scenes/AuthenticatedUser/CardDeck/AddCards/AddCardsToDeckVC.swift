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

    lazy var closeButton: CloseButton = .init(style: .back)

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
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupViews_unique()
        setupActions_unique()
    }

}

private extension AddCardsToDeckVC {
    func setupViews_unique() {
//        setupNavigationItem()

        let cardsView = addCardsView.cardsCollectionView
        cardsView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.className)
        cardsView.dataSource = self
        cardsView.delegate = self

        addCardsView.searchTextField.delegate = self

        addCardsView.setSelectedCards(number: helper.selectedCards.count)
        addCardsView.setCategory(helper.cardCategory)

        closeButton.setLeft(in: view)
    }

    func setupActions_unique() {
        closeButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
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
        addCardsView.cardsCollectionView.reloadData()
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
        addCardsView.cardsCollectionView.reloadData()
        addCardsView.clearSearchButton.isHidden = searchText.isEmpty
        addCardsView.searchImageView.isHidden = !searchText.isEmpty
        addCardsView.setNoResultsView(visible: searchCards.isEmpty)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - TableView DataSource

extension AddCardsToDeckVC: UICollectionViewDataSource {
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

        return searchCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.className, for: indexPath) as? CardCollectionViewCell

        if let card = card(at: indexPath) {
            cell?.setupCard(card)
            let isSelected = helper.isSelected(card: card)
            let isAlreadySelected = helper.isAlreadySelected(card: card)
            cell?.setSelectable(!isAlreadySelected)
            cell?.setChecked(isSelected || isAlreadySelected)
        }
//        cell?.setCellPosition(UICollectionViewCell.cellPosition(for: indexPath, basedOn: searchCards))

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let card = card(at: indexPath) else { return }

        let isSelected = helper.isSelected(card: card)
        let cardCell = cell as? CardCollectionViewCell
//        cardCell?.setSelected(isSelected, animated: false)
        cardCell?.setSelectable(isSelected)
    }
}

// MARK: - TableView Delegate

extension AddCardsToDeckVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let card = card(at: indexPath),
              !helper.isAlreadySelected(card: card)
        else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        cell?.setChecked(true)

        helper.selectCard(card)
        addCardsView.setSelectedCards(number: helper.selectedCards.count)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let card = card(at: indexPath),
              !helper.isAlreadySelected(card: card)
        else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        cell?.setChecked(false)

        helper.deselectCard(card)
        addCardsView.setSelectedCards(number: helper.selectedCards.count)
    }
}

extension AddCardsToDeckVC: SwipableController {
    var isSwipeBackEnabled: Bool { false }
}
