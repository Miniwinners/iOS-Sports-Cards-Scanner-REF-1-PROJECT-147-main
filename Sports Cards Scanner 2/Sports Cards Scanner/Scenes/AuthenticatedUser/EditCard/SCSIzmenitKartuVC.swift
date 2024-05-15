import UIKit
func vicheslitFibonc266(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiIzmenitKartuVC: UIViewController {

    weak var delegate: SportivinieKartiIzmenitKartuDelegat?

    private let cardsManager: SportivinieKartiKartUpdater

    private let priceValidator: SportivinieKartiTextValidator = SportivinieKartiCenaValidator(maxPriceLength: 13)

    let card: SportivinieKartiKartaPredstavlenie

    private(set) lazy var selectedParallelIndex: Int? = card.selectedParallelIndex
    private var selectedParallel: SportivinieKartiKartaParallel? {
        guard let index = selectedParallelIndex else { return nil }
        return card.parallels[safe: index]
    }

    private(set) lazy var selectedGrader: SportivinieKartiKartaGrader = card.selectedGrader
    private(set) lazy var selectedGrade: SportivinieKartiKartaGrade? = card.selectedGrade
    private var cardGrade: String {
        if selectedGrader == .RAW { return L10n.CardDetail.ungraded }

        let grader = selectedGrader.rawValue
        if let grade = selectedGrade?.name {
            return "\(grader) \(grade)"
        } else {
            return grader
        }
    }

    private var priceRange: String? {
        let parallel = selectedParallel ?? card.baseParallel
        let gradersInfo = parallel?.gradersInfo ?? card.gradersInfo
        let graderInfo = gradersInfo[selectedGrader]
        let prices = graderInfo?.prices?.formattedPriceRange

        return prices
    }

    private lazy var customPrice: Double? = card.customPrice

    // MARK: - Subviews

    lazy var editCardView: SportivinieKartiIzmenitKartuVid = .init()
    lazy var closeButton: CloseButton = .init(style: .back)

    lazy var keyboardToolbar: SportivinieKartiCToolB = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCToolB.createToolbar(in: view))

    init(card: SportivinieKartiKartaPredstavlenie, cardsManager: SportivinieKartiKartUpdater = SportivinieKartiUserKartManager.shared) {
        self.card = card
        self.cardsManager = cardsManager
        super.init(nibName: nil, bundle: nil)
        editCardView.titleLabel.text = L10n.EditCard.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        view = editCardView
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

        postavitVid()
        postavidDeistviaUnicalno()
        perezagryzitDaty()
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(obnovitDetaliNazhata), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func obnovitVibraniyIndex(_ index: Int?) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        selectedParallelIndex = index
        perezagryzitDaty()
    }

    func obnovitVibraniiGrade(grader: SportivinieKartiKartaGrader, grade: SportivinieKartiKartaGrade?) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        selectedGrader = grader
        selectedGrade = grade
        perezagryzitDaty()
    }

}

private extension SportivinieKartiIzmenitKartuVC {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVid() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        editCardView.priceTextField.delegate = self
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        editCardView.parallelDetailButton.addTarget(self, action: #selector(parallelNazhata), for: .touchUpInside)
        editCardView.gradeDetailButton.addTarget(self, action: #selector(gradeNazhata), for: .touchUpInside)
        editCardView.updateDetailsButton.addTarget(self, action: #selector(obnovitDetaliNazhata), for: .touchUpInside)
    }

    func perezagryzitDaty() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        editCardView.parallelDetailButton.isHidden = card.parallels.count == 0
        editCardView.parallelDetailView.postavitDetaliOpisanie(selectedParallel?.name)
        editCardView.gradeDetailView.postavitDetaliOpisanie(cardGrade)

        editCardView.customPriceLabel.isHidden = customPrice.isNotNil
        editCardView.setPriceLabel.isHidden = customPrice.isNotNil
        if let price = customPrice {
            editCardView.priceTextField.text = price.formattedAsPrice
        }

        if let priceRange = priceRange {
            editCardView.customPriceLabel.text = priceRange
        } else {
            editCardView.customPriceLabel.text = L10n.EditCard.valueEstimating
        }
    }

    func validatePrice(_ price: String) -> String? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        var pointedPrice = price.replacingOccurrences(of: ",", with: "")

        switch pointedPrice {

        case ".": return "$0."
        case "$.": return "$0."
        case "": return "$"

        default:
            if pointedPrice.first != "$" { pointedPrice = "$\(pointedPrice)" }

            guard priceValidator.validnaLiStroka(pointedPrice) else { return nil }

            let formattedPrice = pointedPrice
                .replacingOccurrences(of: "$", with: "")
                .withGroupingSeparator

            return "$\(formattedPrice)"
        }
    }

    // MARK: - Actions

    @objc func parallelNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        editCardView.endEditing(true)
        delegate?.editCardViewParallelNazhata(self)
    }

    @objc func gradeNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        editCardView.endEditing(true)
        delegate?.editCardViewGradeNazhata(self)
    }

    @objc func obnovitDetaliNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        defer { delegate?.editCardViewControllerDetaliObnovleni(self) }

        let isCardChanged = card.selectedParallelIndex != selectedParallelIndex
        || card.cardGrade != cardGrade
        || card.customPrice != customPrice

        guard isCardChanged else { return }

        cardsManager.obnovitDetali(
            of: card,
            parallelIndex: selectedParallelIndex,
            grader: selectedGrader,
            grade: selectedGrade,
            price: customPrice
        )
        cardsManager.sohranitKartiEsliNado()
    }
}

// MARK: - TextField Delegate

extension SportivinieKartiIzmenitKartuVC: UITextFieldDelegate {
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

    func textFieldDidBeginEditing(_ textField: UITextField) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        editCardView.setPriceLabel.isHidden = true
        editCardView.customPriceLabel.isHidden = true
        if customPrice.isNil {
            textField.text = "$"
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let priceSubstring = textField.text?.dropFirst() ?? ""
        let formattedPrice = String(priceSubstring)

        if let price = formattedPrice.asDoublePrice, price != 0 {
            customPrice = price
        } else {
            customPrice = nil
        }

        editCardView.priceTextField.text = customPrice?.formattedAsPrice
        editCardView.customPriceLabel.isHidden = customPrice.isNotNil
        editCardView.setPriceLabel.isHidden = customPrice.isNotNil
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

        let userInput = string.replacingOccurrences(of: ",", with: ".")
        let updatedText = text.replacingCharacters(in: textRange, with: userInput)

        if let validatedPrice = validatePrice(updatedText) {
            textField.text = validatedPrice
        }

        return false
    }
}
