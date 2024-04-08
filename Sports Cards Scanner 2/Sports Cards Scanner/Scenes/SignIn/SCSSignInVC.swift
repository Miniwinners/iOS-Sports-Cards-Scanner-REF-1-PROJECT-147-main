import UIKit
import SnapKit

final class SCSSignInVC: UIViewController {

    // MARK: - Subviews

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        return scrollView
    }(BaseScrollView())

    lazy var signInView: SignInView = .init()

    lazy var keyboardToolbar: CommonToolbar = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(CommonToolbar.createToolbar(in: view))

    // MARK: - Models

    private let authService: AuthService
    weak var delegate: SignInViewControllerDelegate?

    private let minLengthValidator: LengthValidator = .init(minLength: 1)
    private let maxLengthValidator: LengthValidator = .init(maxLength: 255)

    private var email = "" {
        didSet { updateSignInButton() }
    }
    private var password = "" {
        didSet { updateSignInButton() }
    }

    private var error = "" {
        didSet {
            updateErrorLabel(animated: true)
            if !error.isEmpty {
                signInView.signInButton.isEnabled = false
            }
        }
    }

    private var isLoading: Bool = false {
        didSet { signInView.signInButton.isLoading = isLoading }
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
        updateSignInButton()
        updateErrorLabel(animated: false)
    }
}

private extension SCSSignInVC {
    func setupViews_unique() {
        view.backgroundColor = .white
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

        scrollView.addSubview(signInView)
        signInView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.high)
        }

        [signInView.emailView, signInView.passwordView]
            .map { $0.textField }
            .forEach { $0.delegate = self }
    }

    func setupActions_unique() {
        signInView.signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signInView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        signInView.appleButton.addTarget(self, action: #selector(signInWithAppleTapped), for: .touchUpInside)
        signInView.googleButton.addTarget(self, action: #selector(signInWithGoogleTapped), for: .touchUpInside)
        signInView.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        [signInView.emailView, signInView.passwordView]
            .map { $0.textField }
            .forEach {
                $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            }
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func updateSignInButton() {
        let isCredsNotEmpty = minLengthValidator.isValueValid(email)
            && minLengthValidator.isValueValid(password)
        signInView.signInButton.isEnabled = isCredsNotEmpty
    }

    func updateErrorLabel(animated: Bool) {
        signInView.errorLabel.text = error
        signInView.errorLabel.isHidden = error.isEmpty

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            view.layoutIfNeeded()
        }
    }

    func handleSignInError(_ error: Error) {
        switch error.asAuthError.code {
        case .userNotFound:
            self.error = L10n.SignIn.Error.userNotFound
        case .invalidEmail:
            self.error = L10n.SignIn.Error.invalidEmail
        case .wrongPassword:
            self.error = L10n.SignIn.Error.wrongPassword
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

    @objc func signInTapped() {
        guard !isLoading else { return }

        view.endEditing(true)
        isLoading = true

        let (email, password) = (self.email, self.password)

        Task { @MainActor in
            defer { isLoading = false }

            do {
                try await authService.performSignIn(withEmail: email, password: password)
            } catch {
                handleSignInError(error)
                return
            }

            delegate?.signInViewControllerUserSignedIn(self)
        }
    }

    @objc func signUpTapped() {
        delegate?.signInViewControllerDidPressSignUp(self)
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

            delegate?.signInViewControllerUserSignedIn(self)
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

            delegate?.signInViewControllerUserSignedIn(self)
        }
    }

    @objc func forgotPasswordTapped() {
        delegate?.signInViewControllerDidPressForgotPassword(self)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        error = ""

        let updatedText = textField.text ?? ""

        switch textField {
        case signInView.emailView.textField:
            email = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
        case signInView.passwordView.textField:
            password = updatedText
        default:
            break
        }
    }
}

// MARK: - TextField Delegate

extension SCSSignInVC: UITextFieldDelegate {
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
        case signInView.emailView.textField:
            signInView.passwordView.textField.becomeFirstResponder()
        case signInView.passwordView.textField:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
