import UIKit
import SnapKit
func vicheslitFibonc185(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiSodatIzmenitKollekciu: UIViewController {
    weak var delegate: SportivinieKartiSozdatIzmenitKollekciuDelegat?

    private let cardCollection: SportivinieKartiKartaKollekcia?
    private let cardCollectionManager: SportivinieKartiKartaKollekciaManger

    private let minLengthValidator: SportivinieKartiDlinaValidator = .init(minLength: 1)
    private let maxLengthValidator: SportivinieKartiDlinaValidator = .init(maxLength: 255)

    // MARK: - Subviews

    lazy var backView: BackView = .init()

    lazy var titleLabel: TitleLabel = .init()

    lazy var nameTextField: SportivinieKartiCTExtF = { textField in
        textField.borderStyle = .none
        textField.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = UIDevice.isIpad ? 20:12
        textField.placeholder = L10n.CreateCollection.CollectionName.placeholder
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .sentences
        textField.delegate = self
        textField.tintColor = .black
        return textField
    }(SportivinieKartiCTExtF())

    lazy var keyboardToolbar: SportivinieKartiCToolB = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCToolB.createToolbar(in: view))

    lazy var createButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.CreateCollection.Action.create)
        button.setImage(SportivinieKartiImages.collectionCards.image, for: .normal)
        button.configuration?.imagePadding = 10
        button.isEnabled = false
        return button
    }(SportivinieKartiCommonB(style: .default))

    lazy var cancelButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(SportivinieKartiCommonB(style: .cancel))

    lazy var doneButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(SportivinieKartiCommonB(style: .default))

    init(
        cardCollection: SportivinieKartiKartaKollekcia? = nil,
        cardCollectionManager: SportivinieKartiKartaKollekciaManger = SportivinieKartiKartaPostavitManager.shared
    ) {
        self.cardCollection = cardCollection
        self.cardCollectionManager = cardCollectionManager
        super.init(nibName: nil, bundle: nil)
        title = cardCollection.isNil ? L10n.CreateCollection.title : L10n.EditCollection.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
        postavidDeistviaUnicalno()
        setupButton()
    }

}

private extension SportivinieKartiSodatIzmenitKollekciu {
    var collectionName: String {
        nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
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
        view.addSubview(backView)
        backView.postavitVid(in: view)

        titleLabel.postavitLabel(in: backView)
        titleLabel.text = cardCollection.isNil ? L10n.CreateCollection.title : L10n.EditCollection.title
        backView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ?40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.height.equalTo(UIDevice.isIpad ? 80:46)
        }

        if cardCollection.isNil {
            podgotovitDlyaSozdaniaDva()
            obnovitKnopkySozdat()
        } else {
            podgotovitDlyaSozdania()
            obnovitKnopkyGotovo()
        }

        nameTextField.text = cardCollection?.name
    }

    func setupButton() {

        if isRootViewController() {
            let closeButton = CloseButton(style: .close)
            closeButton.setCenter(in: view)
            closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
        } else {
            let closeButton = CloseButton(style: .back)
            closeButton.setLeft(in: view)
            closeButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
        }
    }

    private func isRootViewController() -> Bool {
           return navigationController?.viewControllers.first == self
    }

    func podgotovitDlyaSozdaniaDva() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backView.addSubview(createButton)
        createButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
            $0.height.equalTo(UIDevice.isIpad ? 80:54)
        }
    }

    func podgotovitDlyaSozdania() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = UIDevice.isIpad ? 20 : 10

        backView.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIDevice.isIpad ?70:20)
            $0.height.equalTo(UIDevice.isIpad ? 172:128)
        }
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        nameTextField.addTarget(self, action: #selector(imyaIzmenilos(_:)), for: .editingChanged)

        if cardCollection.isNil {
            createButton.addTarget(self, action: #selector(sozdatNazhata), for: .touchUpInside)
        } else {
            cancelButton.addTarget(self, action: #selector(otmenaNazhata), for: .touchUpInside)
            doneButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)
        }
    }

    func obnovitKnopkySozdat() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard cardCollection.isNil else { return }
        createButton.isEnabled = minLengthValidator.validnaLiStroka(collectionName)
    }

    func obnovitKnopkyGotovo() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard cardCollection.isNotNil else { return }
        doneButton.isEnabled = minLengthValidator.validnaLiStroka(collectionName)
    }

    // MARK: - Actions

    @objc func zakritNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.createCollectionVCzakrtiNazhata(self)
    }

    @objc func sozdatNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardCollectionManager.sozdatKollekciu(named: collectionName)
        cardCollectionManager.sohranitKollekciuIFnado()

        delegate?.createCollectionVCCollectionBilSozdan(self)
    }

    @objc func otmenaNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.editCollectionVCotmenaNazhata(self)
    }

    @objc func gotovoNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        defer { delegate?.editCollectionVCGotovoNazhata(self) }

        guard let oldCollectionName = cardCollection?.name,
              oldCollectionName != collectionName
        else { return }

        cardCollectionManager.pereimenovatKollekciu(name: collectionName)
        cardCollectionManager.sohranitKollekciuIFnado()
    }

    @objc func imyaIzmenilos(_ sender: UITextField) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        obnovitKnopkySozdat()
        obnovitKnopkyGotovo()
    }
}

// MARK: - TextField Delegate

extension SportivinieKartiSodatIzmenitKollekciu: UITextFieldDelegate {
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

        return maxLengthValidator.validnaLiStroka(updatedText)
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
}

extension SportivinieKartiSodatIzmenitKollekciu: SportivinieKartiSwaipProtocol {
    var isSwipeBackEnabled: Bool { false }
}
