import UIKit
import SnapKit

final class CreateEditDeckVC: UIViewController {

    weak var delegate: CreateEditDeckVCDelegate?

    private let cardDeck: CardDeck?

    private let cardDeckManager: CardDeckManager

    private let categories: [CardCategory] = [.basketball, .magic, .pokemon]
    private var deckType: CardCategory?

    private let minLengthValidator: LengthValidator = .init(minLength: 1)
    private let nameMaxLengthValidator: LengthValidator = .init(maxLength: 255)
    private let descriptionMaxLengthValidator: LengthValidator = .init(maxLength: 1000)

    // MARK: - Subviews

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }(BaseScrollView())

    lazy var deckView: CreateEditDeckView = .init()

    lazy var closeButton: CloseButton = .init(style: .close)

    lazy var backView: BackView = .init()

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    init(
        cardDeck: CardDeck? = nil,
        cardDeckManager: CardDeckManager = CardSetsManager.shared
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
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupViewConstraints_unique()
        setupViews_unique()
        setupActions_unique()
        subscribeToKeyboardNotifications()
    }

}

private extension CreateEditDeckVC {
    var deckName: String {
        deckView.nameView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    var deckDescription: String {
        deckView.descriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isCreateEnabled: Bool {
        minLengthValidator.isValueValid(deckName) && deckType.isNotNil
    }
    var isUpdateEnabled: Bool {
        minLengthValidator.isValueValid(deckName)
    }

    func setupViewConstraints_unique() {
        backView.setupView(in: view)
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
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }

    func setupViews_unique() {
        view.backgroundColor = .clear

        let nameTextField = deckView.nameView.textField
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(nameDidChange(_:)), for: .editingChanged)
        nameTextField.text = cardDeck?.name

        let descriptionTextView = deckView.descriptionTextView
        descriptionTextView.externalDelegate = self
        descriptionTextView.text = cardDeck?.description

        if cardDeck.isNil {
            deckView.setupForCreation()

            let deckTypeView = deckView.deckTypeView
            deckTypeView.setOptions(categories.map({ $0.title }))
            deckTypeView.didSelectOption = { [weak self] optionIndex in
                self?.deckTypeDidUpdate(index: optionIndex)
            }

            updateCreateButton_unique()
        } else {
            deckView.setupForEditing()

            updateDoneButton_unique()
        }
    }

    func setupActions_unique() {
        if cardDeck.isNil {
            deckView.createButton.addTarget(self, action: #selector(createTapped_unique), for: .touchUpInside)
            deckView.deckTypeView.discloseButton.addTarget(self, action: #selector(deckTypeSelectionTapped), for: .touchUpInside)
        } else {
            deckView.cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
            deckView.doneButton.addTarget(self, action: #selector(doneTapped_unique), for: .touchUpInside)
        }
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func deckTypeDidUpdate(index: Int) {
        guard let category = category(at: index) else { return }
        deckType = category
        deckView.deckTypeView.setOptionTitle(category.title)
        updateCreateButton_unique()
    }

    func updateCreateButton_unique() {
        guard cardDeck.isNil else { return }
        deckView.createButton.isEnabled = isCreateEnabled
    }

    func updateDoneButton_unique() {
        guard cardDeck.isNotNil else { return }
        deckView.doneButton.isEnabled = isUpdateEnabled
    }

    func category(at index: Int) -> CardCategory? {
        categories[safe: index]
    }

    // MARK: - Actions

    @objc func close() {
        dismiss(animated: true)
    }

    @objc func closeTapped_unique() {
        view.endEditing(true)
        delegate?.createDeckViewControllerCloseTapped(self)
    }

    @objc func createTapped_unique() {
        view.endEditing(true)

        guard let deckType = deckType else { return }

        cardDeckManager.createDeck(named: deckName, description: deckDescription, category: deckType)
        cardDeckManager.saveDeckIfNeeded()

        delegate?.createDeckViewControllerDeckDidCreate(self)
    }

    @objc func cancelTapped_unique() {
        delegate?.editDeckViewControllerCancelTapped(self)
    }

    @objc func doneTapped_unique() {
        cardDeckManager.renameDeckTo(name: deckName, description: deckDescription)
        cardDeckManager.saveDeckIfNeeded()

        delegate?.editDeckViewControllerDoneTapped(self)
    }

    @objc func nameDidChange(_ sender: UITextField) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        updateCreateButton_unique()
        updateDoneButton_unique()
    }

    @objc func deckTypeSelectionTapped() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        view.endEditing(true)
    }

    @objc func keyboardWillChange(_ notification: Notification) {
        guard let info = KeyboardInfo(from: notification) else { return }

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

extension CreateEditDeckVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.inputAccessoryView == nil {
            textField.inputAccessoryView = keyboardToolbar
        }
        if cardDeck.isNil {
            deckView.deckTypeView.closeOptionsView()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
              let textRange = Range(range, in: text)
        else { return true }

        let updatedText = text.replacingCharacters(in: textRange, with: string)

        return nameMaxLengthValidator.isValueValid(updatedText)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        textField.text = deckName
    }
}

// MARK: - TextView Delegate

extension CreateEditDeckVC: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.inputAccessoryView == nil {
            textView.inputAccessoryView = keyboardToolbar
        }
        if cardDeck.isNil {
            deckView.deckTypeView.closeOptionsView()
        }
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text,
              let textRange = Range(range, in: currentText)
        else { return true }

        let updatedText = currentText.replacingCharacters(in: textRange, with: text)

        return descriptionMaxLengthValidator.isValueValid(updatedText)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        textView.text = deckDescription
    }
}

extension CreateEditDeckVC: SwipableController {
    var isSwipeBackEnabled: Bool { false }
}
