import UIKit
import SnapKit

final class CreateEditCollectionVC: UIViewController {
    weak var delegate: CreateEditCollectionVCDelegate?

    private let cardCollection: CardCollection?
    private let cardCollectionManager: CardCollectionManager

    private let minLengthValidator: LengthValidator = .init(minLength: 1)
    private let maxLengthValidator: LengthValidator = .init(maxLength: 255)

    // MARK: - Subviews

    lazy var backView: BackView = .init()

    lazy var closeButton: CloseButton = .init(style: .close)

    lazy var titleLabel: TitleLabel = .init()

    lazy var nameTextField: CommonTextField = { textField in
        textField.borderStyle = .none
        textField.font = .font(.interRegular, size: UIDevice.isIpad ? 22:16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = UIDevice.isIpad ? 20:12
        textField.placeholder = L10n.CreateCollection.CollectionName.placeholder
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .sentences
        textField.delegate = self
        return textField
    }(CommonTextField())

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    lazy var createButton: CommonButton = { button in
        button.setButtonTitle(L10n.CreateCollection.Action.create)
        button.setImage(Images.collectionCards.image, for: .normal)
        button.configuration?.imagePadding = 10
        button.isEnabled = false
        return button
    }(CommonButton(style: .default))

    lazy var cancelButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(CommonButton(style: .cancel))

    lazy var doneButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(CommonButton(style: .default))

    init(
        cardCollection: CardCollection? = nil,
        cardCollectionManager: CardCollectionManager = CardSetsManager.shared
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

private extension CreateEditCollectionVC {
    var collectionName: String {
        nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    func setupViews_unique() {
        view.backgroundColor = .clear
        view.addSubview(backView)
        backView.setupView(in: view)

        titleLabel.setupLabel(in: backView)
        titleLabel.text = cardCollection.isNil ? L10n.CreateCollection.title : L10n.EditCollection.title
        backView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ?40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.height.equalTo(UIDevice.isIpad ? 80:46)
        }

        if cardCollection.isNil {
            setupForCreation()
            updateCreateButton_unique()
        } else {
            setupForEditing()
            updateDoneButton_unique()
        }

        nameTextField.text = cardCollection?.name
        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }

    func setupForCreation() {
        backView.addSubview(createButton)
        createButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
            $0.height.equalTo(UIDevice.isIpad ? 80:54)
        }
    }

    func setupForEditing() {
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

    func setupActions_unique() {
        nameTextField.addTarget(self, action: #selector(nameDidChange(_:)), for: .editingChanged)

        if cardCollection.isNil {
            createButton.addTarget(self, action: #selector(createTapped_unique), for: .touchUpInside)
        } else {
            cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
            doneButton.addTarget(self, action: #selector(doneTapped_unique), for: .touchUpInside)
        }
    }

    func updateCreateButton_unique() {
        guard cardCollection.isNil else { return }
        createButton.isEnabled = minLengthValidator.isValueValid(collectionName)
    }

    func updateDoneButton_unique() {
        guard cardCollection.isNotNil else { return }
        doneButton.isEnabled = minLengthValidator.isValueValid(collectionName)
    }

    // MARK: - Actions

    @objc func close() {
        dismiss(animated: true)
    }

    @objc func closeTapped_unique() {
        delegate?.createCollectionVCCloseTapped(self)
    }

    @objc func createTapped_unique() {
        cardCollectionManager.createCollection(named: collectionName)
        cardCollectionManager.saveCollectionIfNeeded()

        delegate?.createCollectionVCCollectionDidCreate(self)
    }

    @objc func cancelTapped_unique() {
        delegate?.editCollectionVCCancelTapped(self)
    }

    @objc func doneTapped_unique() {
        defer { delegate?.editCollectionVCDoneTapped(self) }

        guard let oldCollectionName = cardCollection?.name,
              oldCollectionName != collectionName
        else { return }

        cardCollectionManager.renameCollectionTo(name: collectionName)
        cardCollectionManager.saveCollectionIfNeeded()
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
}

// MARK: - TextField Delegate

extension CreateEditCollectionVC: UITextFieldDelegate {
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

        return maxLengthValidator.isValueValid(updatedText)
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
}

extension CreateEditCollectionVC: SwipableController {
    var isSwipeBackEnabled: Bool { false }
}
