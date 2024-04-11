import UIKit
import SnapKit
final class UpdatePasswordVC: UIViewController {

    // MARK: - Subviews

    lazy var updatePasswordView: UpdatePasswordView = .init()

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    // MARK: - Models

    private let authService: AuthService
    weak var delegate: UpdatePasswordViewControllerDelegate?

    private let passwordValidator: PasswordValidator = .init()
    private let passwordLengthValidator: LengthValidator = .init(minLength: 8)
    private let minLengthValidator: LengthValidator = .init(minLength: 1)
    private let maxLengthValidator: LengthValidator = .init(maxLength: 255)

    private var newPassword = "" {
        didSet { updateSaveButton() }
    }
    private var confirmNewPassword = "" {
        didSet { updateSaveButton() }
    }

    private var error = "" {
        didSet {
            updateErrorLabel(animated: true)
            if !error.isEmpty {
                updatePasswordView.saveButton.isEnabled = false
            }
        }
    }

    private var isLoading: Bool = false {
        didSet { updatePasswordView.saveButton.isLoading = isLoading }
    }

    private var validationError: String? {
        guard passwordValidator.isValueValid(newPassword)
                && passwordLengthValidator.isValueValid(newPassword)
        else {
            return L10n.UpdatePassword.Error.noPasswordRequirements
        }
        guard newPassword == confirmNewPassword else {
            return L10n.UpdatePassword.Error.passwordsMismatch
        }
        return nil
    }

    init(authService: AuthService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        title = L10n.UpdatePassword.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = updatePasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews_unique()
        setupActions_unique()
        updateSaveButton()
        updateErrorLabel(animated: false)

    }
}

private extension UpdatePasswordVC {
    func setupViews_unique() {

        [updatePasswordView.passwordView, updatePasswordView.confirmPasswordView]
            .map { $0.textField }
            .forEach { $0.delegate = self }
    }

    func setupActions_unique() {
        [updatePasswordView.passwordView, updatePasswordView.confirmPasswordView]
            .map { $0.textField }
            .forEach {
                $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            }

        updatePasswordView.saveButton.addTarget(self, action: #selector(saveTapped_unique), for: .touchUpInside)
    }

    func updateSaveButton() {
        let isCredsNotEmpty = minLengthValidator.isValueValid(newPassword)
            && minLengthValidator.isValueValid(confirmNewPassword)
        updatePasswordView.saveButton.isEnabled = isCredsNotEmpty
    }

    func updateErrorLabel(animated: Bool) {
        updatePasswordView.errorLabel.text = error
        updatePasswordView.errorLabel.isHidden = error.isEmpty

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            view.layoutIfNeeded()
        }
    }

    func handlePasswordChangingError(_ error: Error) {
        switch error {
        case CommonAuthError.needReauthenticate:
            self.error = L10n.UpdatePassword.Error.needReauthenticate
        default:
            self.error = L10n.Common.error
        }
    }

    // MARK: - Actions

    @objc func closeTapped_unique() {
        delegate?.updatePasswordViewControllerCloseTapped(self)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        error = ""

        let updatedText = textField.text ?? ""

        switch textField {
        case updatePasswordView.passwordView.textField:
            newPassword = updatedText
        case updatePasswordView.confirmPasswordView.textField:
            confirmNewPassword = updatedText
        default:
            break
        }
    }

    @objc func saveTapped_unique() {
        guard !isLoading else { return }

        view.endEditing(true)

        if let error = validationError {
            self.error = error
            return
        }

        isLoading = true
        let newPassword = self.newPassword

        Task { @MainActor in
            defer { isLoading = false }

            do {
                try await authService.changeUserPassword(to: newPassword)
            } catch {
                handlePasswordChangingError(error)
                return
            }

            delegate?.updatePasswordViewControllerPasswordDidUpdate(self)
        }
    }
}

// MARK: - TextField Delegate

extension UpdatePasswordVC: UITextFieldDelegate {
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
        switch textField {
        case updatePasswordView.passwordView.textField:
            updatePasswordView.confirmPasswordView.textField.becomeFirstResponder()
        case updatePasswordView.confirmPasswordView.textField:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
