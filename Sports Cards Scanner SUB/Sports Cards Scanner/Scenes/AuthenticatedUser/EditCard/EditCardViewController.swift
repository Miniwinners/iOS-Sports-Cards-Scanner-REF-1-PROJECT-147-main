import UIKit

final class EditCardViewController: UIViewController {

    weak var delegate: EditCardViewControllerDelegate?

    private let cardsManager: CardsUpdater

    private let priceValidator: TextValidator = PriceValidator(maxPriceLength: 13)

    let card: CardRepresentable

    private(set) lazy var selectedParallelIndex: Int? = card.selectedParallelIndex
    private var selectedParallel: CardParallel? {
        guard let index = selectedParallelIndex else { return nil }
        return card.parallels[safe: index]
    }

    private(set) lazy var selectedGrader: CardGrader = card.selectedGrader
    private(set) lazy var selectedGrade: CardGrade? = card.selectedGrade
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

    lazy var editCardView: EditCardView = .init()
    lazy var closeButton: CloseButton = .init(style: .back)

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    init(card: CardRepresentable, cardsManager: CardsUpdater = UserCardsManager.shared) {
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
        view = editCardView
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
        reloadData_unique()
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(updateDetailsTapped), for: .touchUpInside)
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

    func updateSelectedParallelIndex(_ index: Int?) {
        selectedParallelIndex = index
        reloadData_unique()
    }

    func updateSelectedGrade(grader: CardGrader, grade: CardGrade?) {
        selectedGrader = grader
        selectedGrade = grade
        reloadData_unique()
    }

}

private extension EditCardViewController {
    func setupViews_unique() {
        editCardView.priceTextField.delegate = self
    }

    func setupActions_unique() {
        editCardView.parallelDetailButton.addTarget(self, action: #selector(parallelTapped), for: .touchUpInside)
        editCardView.gradeDetailButton.addTarget(self, action: #selector(gradeTapped), for: .touchUpInside)
        editCardView.updateDetailsButton.addTarget(self, action: #selector(updateDetailsTapped), for: .touchUpInside)
    }

    func reloadData_unique() {
        editCardView.parallelDetailButton.isHidden = card.parallels.count == 0
        editCardView.parallelDetailView.setDetailDescription(selectedParallel?.name)
        editCardView.gradeDetailView.setDetailDescription(cardGrade)

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
        var pointedPrice = price.replacingOccurrences(of: ",", with: "")

        switch pointedPrice {

        case ".": return "$0."
        case "$.": return "$0."
        case "": return "$"

        default:
            if pointedPrice.first != "$" { pointedPrice = "$\(pointedPrice)" }

            guard priceValidator.isValueValid(pointedPrice) else { return nil }

            let formattedPrice = pointedPrice
                .replacingOccurrences(of: "$", with: "")
                .withGroupingSeparator

            return "$\(formattedPrice)"
        }
    }

    // MARK: - Actions

    @objc func parallelTapped() {
        editCardView.endEditing(true)
        delegate?.editCardViewControllerParallelTapped(self)
    }

    @objc func gradeTapped() {
        editCardView.endEditing(true)
        delegate?.editCardViewControllerGradeTapped(self)
    }

    @objc func updateDetailsTapped() {
        defer { delegate?.editCardViewControllerDetailsDidUpdate(self) }

        let isCardChanged = card.selectedParallelIndex != selectedParallelIndex
        || card.cardGrade != cardGrade
        || card.customPrice != customPrice

        guard isCardChanged else { return }

        cardsManager.updateDetails(
            of: card,
            parallelIndex: selectedParallelIndex,
            grader: selectedGrader,
            grade: selectedGrade,
            price: customPrice
        )
        cardsManager.saveCardsIfNeeded()
    }
}

// MARK: - TextField Delegate

extension EditCardViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.inputAccessoryView == nil {
            textField.inputAccessoryView = keyboardToolbar
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        editCardView.setPriceLabel.isHidden = true
        editCardView.customPriceLabel.isHidden = true
        if customPrice.isNil {
            textField.text = "$"
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
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
