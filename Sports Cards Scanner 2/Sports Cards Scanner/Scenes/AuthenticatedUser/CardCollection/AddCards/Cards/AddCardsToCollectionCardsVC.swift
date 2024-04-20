import UIKit

final class AddCardsToCollectionCardsVC: UIViewController {
    weak var delegate: AddCardsToCollectionCardsVCDelegate?

    let helper: AddCardToCollectionHelper
    let cardCategory: CardCategory

    private var searchText: String = ""
    private var searchCards: [CardRepresentable] {
        if searchText.isEmpty { return helper.cards(of: cardCategory) }
        let searchString = searchText.lowercased()
        return helper.cards(of: cardCategory).filter {
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

    lazy var addCardsView: AddCardsToCollectionCardsView = .init()

    lazy var closeButton: CloseButton = .init(style: .back)

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    init(
        helper: AddCardToCollectionHelper,
        cardCategory: CardCategory
    ) {
        self.helper = helper
        self.cardCategory = cardCategory
        super.init(nibName: nil, bundle: nil)
        setupVCTitle()
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
//        setupNavigationItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        addCardsView.setCards(count: searchCards.count)
    }

}

private extension AddCardsToCollectionCardsVC {
    func setupViews_unique() {
        addCardsView.cardsCollectionView.register(CardPhotoCollectionViewCell.self, forCellWithReuseIdentifier: CardPhotoCollectionViewCell.className)
        addCardsView.cardsCollectionView.dataSource = self
        addCardsView.cardsCollectionView.delegate = self

        addCardsView.searchTextField.delegate = self

        addCardsView.setSelectedCards(number: helper.allSelectedCards.count)
        addCardsView.setCategory(cardCategory)

        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(backTapped_unique), for: .touchUpInside)
    }

    func setupActions_unique() {
        addCardsView.clearSearchButton.addTarget(self, action: #selector(clearSearchTapped), for: .touchUpInside)
//        addCardsView.backButton.addTarget(self, action: #selector(backTapped_unique), for: .touchUpInside)
        addCardsView.cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
        addCardsView.doneButton.addTarget(self, action: #selector(doneTapped_unique), for: .touchUpInside)
        addCardsView.selectAllButton.addTarget(self, action: #selector(selectAllCardsTapped), for: .touchUpInside)
    }

    func setupVCTitle() {
        let title = L10n.AddCards.title(helper.cardCollection?.name ?? "")

        let titleWidth = (title as NSString).size(withAttributes: [.font: UIFont.font(.interMedium, size: 20)]).width
        let screenWidth = UIScreen.current?.bounds.width ?? 0

        if titleWidth > screenWidth - 140 {
            self.addCardsView.titleLabel.text = L10n.AddCards.TitleNoName.collection
        } else {
            self.addCardsView.titleLabel.text = title
        }
    }

    func setupNavigationItem() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil
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
        addCardsView.setCards(count: searchCards.count)
    }

    @objc func selectAllCardsTapped() {
        if searchText.isEmpty {
            helper.selectCards(of: cardCategory)
        } else {
            helper.selectCards(searchCards)
        }
        addCardsView.cardsCollectionView.reloadData()
        addCardsView.setSelectedCards(number: helper.allSelectedCards.count)
        addCardsView.searchTextField.resignFirstResponder()
    }

    @objc func backTapped_unique() {
        delegate?.addCardsToCollectionCardsVCBackTapped(self)
    }

    @objc func cancelTapped_unique() {
        delegate?.addCardsToCollectionCardsVCCancelTapped(self)
    }

    @objc func doneTapped_unique() {
        helper.saveCardsToCollection()
        delegate?.addCardsToCollectionCardsVCDoneTapped(self)
    }
}

// MARK: - TextField Delegate

extension AddCardsToCollectionCardsVC: UITextFieldDelegate {
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
        addCardsView.setCards(count: searchCards.count)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - CollectionView DataSource

extension AddCardsToCollectionCardsVC: UICollectionViewDataSource {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardPhotoCollectionViewCell.className, for: indexPath) as? CardPhotoCollectionViewCell

        if let card = card(at: indexPath) {
            cell?.setCard(card)

            if helper.isAlreadySelected(card: card) {
                cell?.setCellHighlighted(true)
                cell?.setSelected(true)
            }
            if helper.isSelected(card: card) {
                cell?.setSelected(true)
            }
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - CollectionView FlowLayout Delegate

extension AddCardsToCollectionCardsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let cardsWidth = collectionView.bounds.width
        let horizontalSpacing: CGFloat = (flowLayout?.sectionInset.left ?? 0) + (flowLayout?.sectionInset.right ?? 0)
        let itemsInRow: CGFloat = 3
        let interitemSpacing: CGFloat = flowLayout?.minimumInteritemSpacing ?? 0
        let itemWidth = (cardsWidth - horizontalSpacing - (itemsInRow - 1) * interitemSpacing) / itemsInRow
        let itemHeight = itemWidth * 1.388
        return .init(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let card = card(at: indexPath),
              !helper.isAlreadySelected(card: card)
        else { return }

        let isCardSelected = helper.isSelected(card: card)

        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoCollectionViewCell
        cell?.setSelected(!isCardSelected)

        if isCardSelected {
            helper.deselectCard(card)
        } else {
            helper.selectCard(card)
        }
        addCardsView.setSelectedCards(number: helper.allSelectedCards.count)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let card = card(at: indexPath),
              !helper.isAlreadySelected(card: card)
        else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoCollectionViewCell
        cell?.setCellHighlighted(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let card = card(at: indexPath),
              !helper.isAlreadySelected(card: card)
        else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? CardPhotoCollectionViewCell
        cell?.setCellHighlighted(false)
    }
}
