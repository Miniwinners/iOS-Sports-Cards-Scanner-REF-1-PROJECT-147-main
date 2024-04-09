import UIKit
import SnapKit

final class SCSSignUpVC: UIViewController {

    // MARK: - Subviews

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        return scrollView
    }(BaseScrollView())

    lazy var signUpView: SignUpView = .init()

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    // MARK: - Models

    private let authService: AuthService
    weak var delegate: SignUpViewControllerDelegate?

    private let passwordValidator: PasswordValidator = .init()
    private let passwordLengthValidator: LengthValidator = .init(minLength: 8)
    private let minLengthValidator: LengthValidator = .init(minLength: 1)
    private let maxLengthValidator: LengthValidator = .init(maxLength: 255)

    private var email = "" {
        didSet { updateSignUpButton() }
    }
    private var password = "" {
        didSet { updateSignUpButton() }
    }
    private var confirmPassword = "" {
        didSet { updateSignUpButton() }
    }

    private var error = "" {
        didSet {
            updateErrorLabel(animated: true)
            if !error.isEmpty {
                signUpView.signUpButton.isEnabled = false
            }
        }
    }

    private var isLoading: Bool = false {
        didSet { signUpView.signUpButton.isLoading = isLoading }
    }

    private var validationError: String? {
        guard passwordValidator.isValueValid(password)
                && passwordLengthValidator.isValueValid(password)
        else {
            return L10n.SignUp.Error.noPasswordRequirements
        }
        guard password == confirmPassword else {
            return L10n.SignUp.Error.passwordsMismatch
        }
        return nil
    }

    init(authService: AuthService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews_unique()
        setupActions_unique()
        subscribeToKeyboardNotifications()
        updateSignUpButton()
        updateErrorLabel(animated: false)
    }
}

private extension SCSSignUpVC {
    func setupViews_unique() {
        view.backgroundColor = .backColor

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        let statusBarView = UIView()
        statusBarView.backgroundColor = .backColor
        view.addSubview(statusBarView)
        statusBarView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        scrollView.addSubview(signUpView)
        signUpView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.high)
        }

        [signUpView.emailView, signUpView.passwordView, signUpView.confirmPasswordView]
            .map { $0.textField }
            .forEach { $0.delegate = self }
    }

    func setupActions_unique() {
        signUpView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        signUpView.signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signUpView.appleButton.addTarget(self, action: #selector(signInWithAppleTapped), for: .touchUpInside)
        signUpView.googleButton.addTarget(self, action: #selector(signInWithGoogleTapped), for: .touchUpInside)
        [signUpView.emailView, signUpView.passwordView, signUpView.confirmPasswordView]
            .map { $0.textField }
            .forEach {
                $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            }
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func updateSignUpButton() {
        let isCredsNotEmpty = minLengthValidator.isValueValid(email)
            && minLengthValidator.isValueValid(password)
            && minLengthValidator.isValueValid(confirmPassword)
        signUpView.signUpButton.isEnabled = isCredsNotEmpty
    }

    func updateErrorLabel(animated: Bool) {
        signUpView.errorLabel.text = error
        signUpView.errorLabel.isHidden = error.isEmpty

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            view.layoutIfNeeded()
        }
    }

    func handleSignUpError(_ error: Error) {
        switch error.asAuthError.code {
        case .emailAlreadyInUse:
            self.error = L10n.SignUp.Error.existUser
        case .invalidEmail:
            self.error = L10n.SignUp.Error.invalidEmail
        default:
            self.error = L10n.Common.error
        }
    }

    func handleSignInWithGoogleError(_ error: Error) {
        switch error {
        case FirebaseError.notConfigured,
            GoogleAuthError.noUserIdToken:
            self.error = L10n.Common.error
        default:
            break
        }
    }

    func handleSignInWithAppleError(_ error: Error) {
        switch error {
        case AppleAuthError.noCredentials:
            self.error = L10n.Common.error
        default:
            break
        }
    }

    // MARK: - Actions

    @objc func keyboardWillChange(_ notification: Notification) {
        guard let info = KeyboardInfo(from: notification) else { return }

        let bottomInset: CGFloat = {
            if notification.name == UIResponder.keyboardWillHideNotification {
                return .zero
            } else {
                return info.frame.height - view.safeAreaInsets.bottom
            }
        }()

        scrollView.snp.updateConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(bottomInset)
        }

        UIView.animate(withDuration: info.animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func signUpTapped() {
        guard !isLoading else { return }

        view.endEditing(true)

        if let error = validationError {
            self.error = error
            return
        }

        isLoading = true
        let (email, password) = (self.email, self.password)

        Task { @MainActor in
            defer { isLoading = false }

            do {
                try await authService.performSignUp(withEmail: email, password: password)
            } catch {
                handleSignUpError(error)
                return
            }

            delegate?.signUpViewControllerUserSignedUp(self)
        }
    }

    @objc func signInTapped() {
        delegate?.signUpViewControllerDidPressSignIn(self)
    }

    @objc func signInWithAppleTapped() {
        view.endEditing(true)

        Task { @MainActor in
            do {
                try await authService.signInWithApple(in: self)
            } catch {
                handleSignInWithAppleError(error)
                return
            }

            delegate?.signUpViewControllerUserSignedUp(self)
        }
    }

    @objc func signInWithGoogleTapped() {
        view.endEditing(true)

        Task { @MainActor in
            do {
                try await authService.signInWithGoogle(in: self)
            } catch {
                handleSignInWithGoogleError(error)
                return
            }

            delegate?.signUpViewControllerUserSignedUp(self)
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        error = ""
        let updatedText = textField.text ?? ""
        switch textField {
        case signUpView.emailView.textField:
            email = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
        case signUpView.passwordView.textField:
            password = updatedText
        case signUpView.confirmPasswordView.textField:
            confirmPassword = updatedText
        default:
            break
        }
    }
}

// MARK: - TextField Delegate

extension SCSSignUpVC: UITextFieldDelegate {
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
        case signUpView.emailView.textField:
            signUpView.passwordView.textField.becomeFirstResponder()
        case signUpView.passwordView.textField:
            signUpView.confirmPasswordView.textField.becomeFirstResponder()
        case signUpView.confirmPasswordView.textField:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
