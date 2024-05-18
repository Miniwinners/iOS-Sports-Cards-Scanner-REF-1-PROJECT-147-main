import UIKit
func vicheslitFibonc177(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class DobavitKartiVKollekciuController: UIViewController {
    weak var delegate: DobavitKartiToCollectionKartiDelegat?

    let helper: DobavitKartiVKollekciuHelp
    let cardCategory: KategoriiKart

    private var searchText: String = ""
    private var searchCards: [SportivinieKartiKartaPredstavlenie] {
        if searchText.isEmpty { return helper.karti(of: cardCategory) }
        let searchString = searchText.lowercased()
        return helper.karti(of: cardCategory).filter {
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

    lazy var addCardsView: DobavitKartiVKollekciuVid = .init()

    lazy var closeButton: CloseButton = .init(style: .back)

    lazy var keyboardToolbar: SportivinieKartiCustomTool = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCustomTool.createToolbar(in: view))

    init(
        helper: DobavitKartiVKollekciuHelp,
        cardCategory: KategoriiKart
    ) {
        self.helper = helper
        self.cardCategory = cardCategory
        super.init(nibName: nil, bundle: nil)
        postavitControllerZagolovok()
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
        view = addCardsView
    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
        postavidDeiistvia()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        view.layoutIfNeeded()
        addCardsView.postavitKarti(count: searchCards.count)
    }

}

private extension DobavitKartiVKollekciuController {
    func postavitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        addCardsView.cardsCollectionView.register(SportivinieKartiCardPCollectionKletka.self, forCellWithReuseIdentifier: SportivinieKartiCardPCollectionKletka.className)
        addCardsView.cardsCollectionView.dataSource = self
        addCardsView.cardsCollectionView.delegate = self

        addCardsView.searchTextField.delegate = self

        addCardsView.setVibranieKarti(number: helper.allSelectedCards.count)

        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(nazadNazhata), for: .touchUpInside)
    }

    func postavidDeiistvia() {
        addCardsView.clearSearchButton.addTarget(self, action: #selector(ochistiPoiskNazhata), for: .touchUpInside)
        addCardsView.cancelButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
        addCardsView.doneButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)
        addCardsView.selectAllButton.addTarget(self, action: #selector(vibratVseKartiNazhata), for: .touchUpInside)
    }

    func postavitControllerZagolovok() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let title = L10n.AddCards.title(helper.cardCollection?.name ?? "")

        let titleWidth = (title as NSString).size(withAttributes: [.font: UIFont.font(.interMedium, size: 20)]).width
        let screenWidth = UIScreen.current?.bounds.width ?? 0

        if titleWidth > screenWidth - 140 {
            self.addCardsView.titleLabel.text = L10n.AddCards.TitleNoName.collection
        } else {
            self.addCardsView.titleLabel.text = title
        }
    }

    func karta(at indexPath: IndexPath) -> SportivinieKartiKartaPredstavlenie? {
        func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
            let chisloOdin = 15
            let chisloDva = 32
            let chisloThree = chisloOdin + chisloDva
            return Int.random(in: minValue...maxValue)
        }
        return searchCards[safe: indexPath.row]
    }

    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    // MARK: - Actions

    @objc func ochistiPoiskNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        addCardsView.searchTextField.text = ""
        searchText = ""
        addCardsView.cardsCollectionView.reloadData()
        addCardsView.clearSearchButton.isHidden = true
        addCardsView.searchImageView.isHidden = false
        addCardsView.searchTextField.becomeFirstResponder()
        addCardsView.postavitBezRezyltatovVid(visible: searchCards.isEmpty)
        addCardsView.postavitKarti(count: searchCards.count)
    }

    @objc func vibratVseKartiNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if searchText.isEmpty {
            helper.vibratKarti(of: cardCategory)
        } else {
            helper.vibratKarti(searchCards)
        }
        addCardsView.cardsCollectionView.reloadData()
        addCardsView.setVibranieKarti(number: helper.allSelectedCards.count)
        addCardsView.searchTextField.resignFirstResponder()
    }

    @objc func nazadNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.nazadNazhata(self)
    }

    @objc func otmenaNazhata() {
        delegate?.otmenaNazhata(self)
    }

    @objc func gotovoNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        helper.sohranitKarti()
        delegate?.gotovoNazhata(self)
    }
}

// MARK: - TextField Delegate

extension DobavitKartiVKollekciuController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if textField.inputAccessoryView == nil {
            textField.inputAccessoryView = keyboardToolbar
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let text = textField.text,
              let textRange = Range(range, in: text)
        else { return true }

        let updatedText = text.replacingCharacters(in: textRange, with: string)

        addCardsView.clearSearchButton.isHidden = updatedText.isEmpty
        addCardsView.searchImageView.isHidden = !updatedText.isEmpty

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        searchText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        textField.text = searchText
        addCardsView.cardsCollectionView.reloadData()
        addCardsView.clearSearchButton.isHidden = searchText.isEmpty
        addCardsView.searchImageView.isHidden = !searchText.isEmpty
        addCardsView.postavitBezRezyltatovVid(visible: searchCards.isEmpty)
        addCardsView.postavitKarti(count: searchCards.count)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - CollectionView DataSource

extension DobavitKartiVKollekciuController: UICollectionViewDataSource {
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
        return searchCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiCardPCollectionKletka.className, for: indexPath) as? SportivinieKartiCardPCollectionKletka
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if let card = karta(at: indexPath) {
            cell?.postavitKarty(card)

            if helper.isYsheVibran(card: card) {
                cell?.sdelatCellVidelenoi(true)
                cell?.sdelatCellNazhatoi(true)
            }
            if helper.isVibrano(card: card) {
                cell?.sdelatCellNazhatoi(true)
            }
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - CollectionView FlowLayout Delegate

extension DobavitKartiVKollekciuController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
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
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let card = karta(at: indexPath),
              !helper.isYsheVibran(card: card)
        else { return }

        let isCardSelected = helper.isVibrano(card: card)

        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiCardPCollectionKletka
        cell?.sdelatCellNazhatoi(!isCardSelected)

        if isCardSelected {
            helper.otmenaViboraKarti(card)
        } else {
            helper.vibratKarty(card)
        }
        addCardsView.setVibranieKarti(number: helper.allSelectedCards.count)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let card = karta(at: indexPath),
              !helper.isYsheVibran(card: card)
        else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiCardPCollectionKletka
        cell?.sdelatCellVidelenoi(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let card = karta(at: indexPath),
              !helper.isYsheVibran(card: card)
        else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiCardPCollectionKletka
        cell?.sdelatCellVidelenoi(false)
    }
}
