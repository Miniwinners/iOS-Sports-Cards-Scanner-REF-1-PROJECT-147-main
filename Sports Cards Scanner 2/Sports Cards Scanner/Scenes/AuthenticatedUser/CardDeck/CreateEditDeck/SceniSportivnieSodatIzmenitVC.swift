import UIKit
import SnapKit
func vicheslitFibonc262(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiSodatIzmeniTableKlrtka: UIViewController {

    weak var delegate: SportivinieKartiSodatIzmenitDelegat?

    private let cardDeck: SportivinieKartiCartaKoloda?

    private let cardDeckManager: SportivinieKartiCardDeckManager

    private let categories: [KategoriiKart] = [.basketball, .baseball, .football, .hockey, .soccer]
    private var deckType: KategoriiKart?

    private let minLengthValidator: SportivinieKartiDlinaValidator = .init(minLength: 1)
    private let nameMaxLengthValidator: SportivinieKartiDlinaValidator = .init(maxLength: 255)
    private let descriptionMaxLengthValidator: SportivinieKartiDlinaValidator = .init(maxLength: 1000)

    // MARK: - Subviews

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }(SportivinieKartiBaseScrolVid())

    lazy var deckView: SportivinieKartiSodatIzmenitVid = .init()

    lazy var closeButton: CloseButton = .init(style: .close)

    lazy var backView: BackView = .init()

    lazy var keyboardToolbar: SportivinieKartiCustomTool = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCustomTool.createToolbar(in: view))

    init(
        cardDeck: SportivinieKartiCartaKoloda? = nil,
        cardDeckManager: SportivinieKartiCardDeckManager = SportivinieKartiKartaPostavitManager.shared
    ) {
        self.cardDeck = cardDeck
        self.cardDeckManager = cardDeckManager
        super.init(nibName: nil, bundle: nil)
        deckView.titleLabel.text = cardDeck.isNil ? L10n.CreateDeck.title : L10n.EditDeck.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitKonstreinti()
        postavitVid()
        postavidDeistviaUnicalno()
        podpisPodYvedomleniya()
    }

}

private extension SportivinieKartiSodatIzmeniTableKlrtka {
    var deckName: String {
        deckView.nameView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    var deckDescription: String {
        deckView.descriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isCreateEnabled: Bool {
        minLengthValidator.validnaLiStroka(deckName) && deckType.isNotNil
    }
    var isUpdateEnabled: Bool {
        minLengthValidator.validnaLiStroka(deckName)
    }

    func postavitKonstreinti() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backView.postavitVid(in: view)
        backView.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 52:32)
        }

        scrollView.addSubview(deckView)
        deckView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
            $0.height.lessThanOrEqualTo(scrollView.safeAreaLayoutGuide).priority(.medium)
        }
        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
    }
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
        view.backgroundColor = .clear

        let nameTextField = deckView.nameView.textField
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(imyaIzmenilos(_:)), for: .editingChanged)
        nameTextField.text = cardDeck?.name

        let descriptionTextView = deckView.descriptionTextView
        descriptionTextView.externalDelegate = self
        descriptionTextView.text = cardDeck?.description

        if cardDeck.isNil {
            deckView.setupForCreation()

            let deckTypeView = deckView.deckTypeView
            deckTypeView.postavitOpcii(categories.map({ $0.title }))
            deckTypeView.didSelectOption = { [weak self] optionIndex in
                self?.tipeKolodiIzmenilos(index: optionIndex)
            }

            obnovitSozdatKnopky()
        } else {
            deckView.setupForEditing()

            obnovitDoneKnopky()
        }
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        if cardDeck.isNil {
            deckView.createButton.addTarget(self, action: #selector(sozdatNazhata), for: .touchUpInside)
            deckView.deckTypeView.discloseButton.addTarget(self, action: #selector(kolodaTipNazhata), for: .touchUpInside)
        } else {
            deckView.cancelButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
            deckView.doneButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)
        }
    }

    func podpisPodYvedomleniya() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func tipeKolodiIzmenilos(index: Int) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let category = kategorii(at: index) else { return }
        deckType = category
        deckView.deckTypeView.zagolovokOpcii(category.title)
        obnovitSozdatKnopky()
    }

    func obnovitSozdatKnopky() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard cardDeck.isNil else { return }
        deckView.createButton.isEnabled = isCreateEnabled
    }

    func obnovitDoneKnopky() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard cardDeck.isNotNil else { return }
        deckView.doneButton.isEnabled = isUpdateEnabled
    }

    func kategorii(at index: Int) -> KategoriiKart? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categories[safe: index]
    }

    // MARK: - Actions

    @objc func zakrit() {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        dismiss(animated: true)
    }

    @objc func zakritNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        view.endEditing(true)
        delegate?.createDeckViewControllerzakrtiNazhata(self)
    }

    @objc func sozdatNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        view.endEditing(true)

        guard let deckType = deckType else { return }

        cardDeckManager.sozdatKolody(named: deckName, description: deckDescription, category: deckType)
        cardDeckManager.sohranitKolodyEsliNado()

        delegate?.createDeckViewControllerDeckBilSozdan(self)
    }

    @objc func otmenaNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.editDeckViewControllerotmenaNazhata(self)
    }

    @objc func gotovoNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardDeckManager.pereimenovatKolodyV(name: deckName, description: deckDescription)
        cardDeckManager.sohranitKolodyEsliNado()

        delegate?.editDeckViewControllerGotovoNazhata(self)
    }

    @objc func imyaIzmenilos(_ sender: UITextField) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        obnovitSozdatKnopky()
        obnovitDoneKnopky()
    }

    @objc func kolodaTipNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        view.endEditing(true)
    }

    @objc func keyboardWillChange(_ notification: Notification) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let info = SportivinieKartiKlaviatyra(from: notification) else { return }

        let bottomInset: CGFloat = {
            if notification.name == UIResponder.keyboardWillHideNotification {
                return .zero
            } else {
                return info.frame.height
            }
        }()

        scrollView.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(bottomInset)
        }

        UIView.animate(withDuration: info.animationDuration) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            let textView = self.deckView.descriptionTextView
            if textView.isFirstResponder {
                self.scrollView.scrollRectToVisible(textView.frame.offsetBy(dx: 0, dy: 20), animated: true)
            }
        }
    }
}

// MARK: - TextField Delegate

extension SportivinieKartiSodatIzmeniTableKlrtka: UITextFieldDelegate {
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
        if cardDeck.isNil {
            deckView.deckTypeView.zakritVidOpcii()
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

        return nameMaxLengthValidator.validnaLiStroka(updatedText)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        textField.text = deckName
    }
}

// MARK: - TextView Delegate

extension SportivinieKartiSodatIzmeniTableKlrtka: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if textView.inputAccessoryView == nil {
            textView.inputAccessoryView = keyboardToolbar
        }
        if cardDeck.isNil {
            deckView.deckTypeView.zakritVidOpcii()
        }
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let currentText = textView.text,
              let textRange = Range(range, in: currentText)
        else { return true }

        let updatedText = currentText.replacingCharacters(in: textRange, with: text)

        return descriptionMaxLengthValidator.validnaLiStroka(updatedText)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        textView.text = deckDescription
    }
}

extension SportivinieKartiSodatIzmeniTableKlrtka: SportivinieKartiSwaipProtocol {
    var isSwipeBackEnabled: Bool { false }
}
