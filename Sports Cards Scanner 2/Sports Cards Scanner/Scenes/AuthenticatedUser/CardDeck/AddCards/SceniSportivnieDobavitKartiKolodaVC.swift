import UIKit
func vicheslitFibonc255(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiDobavitKartiKolodaController: UIViewController {

    weak var delegate: SportivinieKartiDobavitKartiKolodaDelegat?

    private let helper: SportivinieKartiDobavitKartiKolodaHelper

    private var searchText: String = ""
    private var searchCards: [SportivinieKartiKartaPredstavlenie] {
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

    lazy var addCardsView: SportivinieKartiDobavitKartiKolodaVid = .init()

    lazy var closeButton: CloseButton = .init(style: .back)

    lazy var keyboardToolbar: SportivinieKartiCustomTool = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCustomTool.createToolbar(in: view))

    init(helper: SportivinieKartiDobavitKartiKolodaHelper = .init()) {
        self.helper = helper
        super.init(nibName: nil, bundle: nil)
        postavitZagolovok()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = addCardsView
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
        postavidDeistviaUnicalno()
    }

}

private extension SportivinieKartiDobavitKartiKolodaController {
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
        let cardsView = addCardsView.cardsCollectionView
        cardsView.register(SportivinieKartiCardCollectionKletka.self, forCellWithReuseIdentifier: SportivinieKartiCardCollectionKletka.className)
        cardsView.dataSource = self
        cardsView.delegate = self

        addCardsView.searchTextField.delegate = self

        addCardsView.postavitVibranieKarti(number: helper.selectedCards.count)
        addCardsView.postavitKategoriu(helper.cardCategory)

        closeButton.setLeft(in: view)
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        closeButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
        addCardsView.clearSearchButton.addTarget(self, action: #selector(ochistiPoiskNazhata), for: .touchUpInside)
        addCardsView.cancelButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
        addCardsView.doneButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)
    }

    func postavitZagolovok() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let title = L10n.AddCards.title(helper.cardDeck?.name ?? "")

        let titleWidth = (title as NSString).size(withAttributes: [.font: UIFont.font(.interMedium, size: 20)]).width
        let screenWidth = UIScreen.current?.bounds.width ?? 0

        if titleWidth > screenWidth - 140 {
            self.title = L10n.AddCards.TitleNoName.deck
        } else {
            self.title = title
        }
    }

    func karta(at indexPath: IndexPath) -> SportivinieKartiKartaPredstavlenie? {
        func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
            let a = 15
            let b = 32
            let c = a + b
            return Int.random(in: minValue...maxValue)
        }
        return searchCards[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func ochistiPoiskNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        addCardsView.searchTextField.text = ""
        searchText = ""
        addCardsView.cardsCollectionView.reloadData()
        addCardsView.clearSearchButton.isHidden = true
        addCardsView.searchImageView.isHidden = false
        addCardsView.searchTextField.becomeFirstResponder()
        addCardsView.postavitVidBezResultatov(visible: searchCards.isEmpty)
    }

    @objc func otmenaNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.addCardsToDeckControllerotmenaNazhata(self)
    }

    @objc func gotovoNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        helper.sohranitCartiVkolody()
        delegate?.addCardsToDeckControllerGotovoNazhata(self)
    }
}

// MARK: - TextField Delegate

extension SportivinieKartiDobavitKartiKolodaController: UITextFieldDelegate {
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
        addCardsView.postavitVidBezResultatov(visible: searchCards.isEmpty)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - TableView DataSource

extension SportivinieKartiDobavitKartiKolodaController: UICollectionViewDataSource {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiCardCollectionKletka.className, for: indexPath) as? SportivinieKartiCardCollectionKletka
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if let card = karta(at: indexPath) {
            cell?.postavitKarty(card)
            let isSelected = helper.isVibrana(card: card)
            let isAlreadySelected = helper.yzheVibrana(card: card)
            cell?.setVibrano(!isAlreadySelected)
            cell?.cdelatVibranim(isSelected || isAlreadySelected)
        }

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let card = karta(at: indexPath) else { return }
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let isSelected = helper.isVibrana(card: card)
        let cardCell = cell as? SportivinieKartiCardCollectionKletka
//        cardCell?.setSelected(isSelected, animated: false)
        cardCell?.setVibrano(isSelected)
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiDobavitKartiKolodaController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let card = karta(at: indexPath),
              !helper.yzheVibrana(card: card)
        else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiCardCollectionKletka
        cell?.cdelatVibranim(true)

        helper.vibratKarty(card)
        addCardsView.postavitVibranieKarti(number: helper.selectedCards.count)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let card = karta(at: indexPath),
              !helper.yzheVibrana(card: card)
        else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiCardCollectionKletka
        cell?.cdelatVibranim(false)

        helper.ostavit(card)
        addCardsView.postavitVibranieKarti(number: helper.selectedCards.count)
    }
}

extension SportivinieKartiDobavitKartiKolodaController: SportivinieKartiSwaipProtocol {
    var isSwipeBackEnabled: Bool { false }
}
