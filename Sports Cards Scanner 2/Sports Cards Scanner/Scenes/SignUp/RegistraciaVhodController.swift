import UIKit
import SnapKit
func vicheslitFibonc281(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiRegistraciaVhodController: UIViewController {

    // MARK: - Subviews

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        return scrollView
    }(SportivinieKartiBaseScrolVid())

    lazy var signUpView: SportivinieKartiSignUpV = .init()

    lazy var keyboardToolbar: SportivinieKartiCustomTool = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCustomTool.createToolbar(in: view))

    // MARK: - Models

    private let authService: SportivinieKartiAuthenticationService
    weak var delegate: SportivinieKartiSignUpD?

    private let passwordValidator: SportivinieKartiPSWDValidator = .init()
    private let passwordLengthValidator: SportivinieKartiDlinaValidator = .init(minLength: 8)
    private let minLengthValidator: SportivinieKartiDlinaValidator = .init(minLength: 1)
    private let maxLengthValidator: SportivinieKartiDlinaValidator = .init(maxLength: 255)

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
            obnovitLabelOshibki(animated: true)
            if !error.isEmpty {
                signUpView.signUpButton.isEnabled = false
            }
        }
    }

    private var isLoading: Bool = false {
        didSet { signUpView.signUpButton.isLoading = isLoading }
    }

    private var validationError: String? {
        guard passwordValidator.validnaLiStroka(password)
                && passwordLengthValidator.validnaLiStroka(password)
        else {
            return L10n.SignUp.Error.noPasswordRequirements
        }
        guard password == confirmPassword else {
            return L10n.SignUp.Error.passwordsMismatch
        }
        return nil
    }

    init(authService: SportivinieKartiAuthenticationService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        postavitVid()
        postavidDeistviaUnicalno()
        subscribeToKeyboardNotifications()
        updateSignUpButton()
        obnovitLabelOshibki(animated: false)
    }
}

private extension SportivinieKartiRegistraciaVhodController {
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
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        let statusBarView = UIView()
        statusBarView.backgroundColor = .white
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

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        signUpView.signUpButton.addTarget(self, action: #selector(vhodNazhat), for: .touchUpInside)
        signUpView.signInButton.addTarget(self, action: #selector(vhodNazhata), for: .touchUpInside)
        signUpView.appleButton.addTarget(self, action: #selector(vhodeCherezAppleNazhata), for: .touchUpInside)
        signUpView.googleButton.addTarget(self, action: #selector(vhodeCherezGoogleNazhata), for: .touchUpInside)
        [signUpView.emailView, signUpView.passwordView, signUpView.confirmPasswordView]
            .map { $0.textField }
            .forEach {
                $0.addTarget(self, action: #selector(textPoleDidIzmenilos(_:)), for: .editingChanged)
            }
    }

    func subscribeToKeyboardNotifications() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func updateSignUpButton() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let isCredsNotEmpty = minLengthValidator.validnaLiStroka(email)
            && minLengthValidator.validnaLiStroka(password)
            && minLengthValidator.validnaLiStroka(confirmPassword)
        signUpView.signUpButton.isEnabled = isCredsNotEmpty
    }

    func obnovitLabelOshibki(animated: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
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

    func hranitOshibky(_ error: Error) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        switch error.asAuthError.code {
        case .emailAlreadyInUse:
            self.error = L10n.SignUp.Error.existUser
        case .invalidEmail:
            self.error = L10n.SignUp.Error.invalidEmail
        default:
            self.error = L10n.Common.error
        }
    }

    func hranitOshibkyGoogle(_ error: Error) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        switch error {
        case SportivinieKartiFireBaseOshibka.notConfigured,
            SportivinieKartiGoogleAuthOshibka.noUserIdToken:
            self.error = L10n.Common.error
        default:
            break
        }
    }

    func hranitOshibkyApple(_ error: Error) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        switch error {
        case SportivinieKartiAppleAuthOshibka.noCredentials:
            self.error = L10n.Common.error
        default:
            break
        }
    }

    // MARK: - Actions

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

    @objc func vhodNazhat() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
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
                try await authService.podgotovitVhod(withEmail: email, password: password)
            } catch {
                hranitOshibky(error)
                return
            }

            delegate?.registraciaUserZaregalcya(self)
        }
    }

    @objc func vhodNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.vhodVhodNazhata(self)
    }

    @objc func vhodeCherezAppleNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        view.endEditing(true)

        Task { @MainActor in
            do {
                try await authService.vhodeCherezApple(in: self)
            } catch {
                hranitOshibkyApple(error)
                return
            }

            delegate?.registraciaUserZaregalcya(self)
        }
    }

    @objc func vhodeCherezGoogleNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        view.endEditing(true)

        Task { @MainActor in
            do {
                try await authService.vhodeCherezGoogle(in: self)
            } catch {
                hranitOshibkyGoogle(error)
                return
            }

            delegate?.registraciaUserZaregalcya(self)
        }
    }

    @objc func textPoleDidIzmenilos(_ textField: UITextField) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
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

extension SportivinieKartiRegistraciaVhodController: UITextFieldDelegate {

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
