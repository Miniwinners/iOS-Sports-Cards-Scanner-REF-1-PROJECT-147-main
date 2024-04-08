import UIKit

final class SCSForgotPasswordVC: UIViewController {

    // MARK: - Subviews

    lazy var forgotPasswordView: ForgotPasswordView = .init()

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    private let authService: AuthService
    weak var delegate: ForgotPasswordViewControllerDelegate?

    private let minLengthValidator: LengthValidator = .init(minLength: 1)
    private let maxLengthValidator: LengthValidator = .init(maxLength: 255)

    private var email = "" {
        didSet { updateSendButton() }
    }

    private var error = "" {
        didSet {
            updateErrorLabel(animated: true)
            if !error.isEmpty {
                forgotPasswordView.sendButton.isEnabled = false
            }
        }
    }

    private var isLoading: Bool = false {
        didSet { forgotPasswordView.sendButton.isLoading = isLoading }
    }

    init(authService: AuthService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        title = L10n.ForgotPassword.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = forgotPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews_unique()
        setupActions_unique()
        updateSendButton()
        updateErrorLabel(animated: false)
    }
}

private extension SCSForgotPasswordVC {
    func setupViews_unique() {
        navigationItem.rightBarButtonItem = .init(
            image: Images.close.image,
            style: .plain,
            target: self,
            action: #selector(closeTapped_unique)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black

        forgotPasswordView.emailView.textField.delegate = self
    }

    func setupActions_unique() {
        forgotPasswordView.sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        forgotPasswordView.emailView.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    func updateSendButton() {
        let isCredsNotEmpty = minLengthValidator.isValueValid(email)
        forgotPasswordView.sendButton.isEnabled = isCredsNotEmpty
    }

    func updateErrorLabel(animated: Bool) {
        forgotPasswordView.errorLabel.text = error
        forgotPasswordView.errorLabel.isHidden = error.isEmpty

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            view.layoutIfNeeded()
        }
    }

    func handleSendEmailError(_ error: Error) {
        switch error.asAuthError.code {
        case .invalidEmail:
            self.error = L10n.ForgotPassword.Error.invalidEmail
        case .userNotFound:
            self.error = L10n.ForgotPassword.Error.userNotFound
        default:
            self.error = L10n.Common.error
        }
    }

    // MARK: - Actions

    @objc func sendTapped() {
        view.endEditing(true)
        isLoading = true

        let email = self.email

        Task { @MainActor in
            defer { isLoading = false }

            do {
                try await authService.sendResetPasswordEmail(to: email)
            } catch {
                handleSendEmailError(error)
                return
            }

            delegate?.forgotPasswordViewController(emailSentTo: email, from: self)
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        error = ""

        let updatedText = textField.text ?? ""

        switch textField {
        case forgotPasswordView.emailView.textField:
            email = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
        default:
            break
        }
    }

    @objc func closeTapped_unique() {
        delegate?.forgotPasswordViewControllerCloseTapped(self)
    }
}

// MARK: - TextField Delegate

extension SCSForgotPasswordVC: UITextFieldDelegate {
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
        case forgotPasswordView.emailView.textField:
            textField.resignFirstResponder()
        default:
            break
        }

        return true
    }
}
