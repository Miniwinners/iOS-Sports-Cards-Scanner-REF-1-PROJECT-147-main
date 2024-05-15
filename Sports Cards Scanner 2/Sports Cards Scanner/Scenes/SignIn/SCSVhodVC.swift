import UIKit
import SnapKit

func vicheslitFibonc334(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
// import FacebookLogin
final class SportivinieKartiVhodVC: UIViewController {

    // MARK: - Subviews

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        return scrollView
    }(SportivinieKartiBSV())

    lazy var signInView: SportivinieKartiSignInV = .init()

    lazy var keyboardToolbar: SportivinieKartiCToolB = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCToolB.createToolbar(in: view))

    // MARK: - Models

    private let authService: SportivinieKartiAuthenticationSc
    weak var delegate: SportivinieKartiSignInD?

    private let minLengthValidator: SportivinieKartiDlinaValidator = .init(minLength: 1)
    private let maxLengthValidator: SportivinieKartiDlinaValidator = .init(maxLength: 255)
    private let emailValidator: SportivinieKartiPochtaValidator = .init()
    private var validationTimer: Timer?
    private var email = "" {
        didSet { obnovitKnopkyVhoda() }
    }
    private var password = "" {
        didSet { obnovitKnopkyVhoda() }
    }

    private var error = "" {
        didSet {
            obnovitLabelOshibki(animated: true)
            if !error.isEmpty {
                signInView.signInButton.isEnabled = false
            }
        }
    }

    private var isLoading: Bool = false {
        didSet { signInView.signInButton.isLoading = isLoading }
    }

    init(authService: SportivinieKartiAuthenticationSc) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

//        let token = AccessToken.current,if !token.isExpired {
//        // User is logged in, do work such as go to next view controller.
//        } 

        postavitVid()
        postavidDeistviaUnicalno()
        podpisPodYvedomlenia()
        obnovitKnopkyVhoda()
        obnovitLabelOshibki(animated: false)
    }
}

private extension SportivinieKartiVhodVC {
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

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        signInView.signInButton.addTarget(self, action: #selector(vhodNazhat), for: .touchUpInside)
        signInView.signUpButton.addTarget(self, action: #selector(regNazhata), for: .touchUpInside)
        signInView.appleButton.addTarget(self, action: #selector(vhodeCherezAppleNazhata), for: .touchUpInside)
        signInView.googleButton.addTarget(self, action: #selector(vhodeCherezAppleNazhata), for: .touchUpInside)
        signInView.forgotPasswordButton.addTarget(self, action: #selector(zabilParolNazhata), for: .touchUpInside)
        [signInView.emailView, signInView.passwordView]
            .map { $0.textField }
            .forEach {
                $0.addTarget(self, action: #selector(textPoleDidIzmenilos(_:)), for: .editingChanged)
            }
        [signInView.appleButton, signInView.facebookButton, signInView.googleButton].forEach { button in
            button.addTarget(self, action: #selector(nazhatie), for: .touchDown)
            button.addTarget(self, action: #selector(nazhatieZakonchilos), for: .touchUpInside)
            button.addTarget(self, action: #selector(nazhatieZakonchilos), for: .touchUpOutside)

        }
    }

    func podpisPodYvedomlenia() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func obnovitKnopkyVhoda() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let isCredsNotEmpty = minLengthValidator.validnaLiStroka(email)
            && minLengthValidator.validnaLiStroka(password)
        signInView.signInButton.isEnabled = isCredsNotEmpty
    }

    func obnovitLabelOshibki(animated: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
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

    func validirovatPochty(_ email: String?) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let email = email else { return }
        signInView.emailView.validImage.isHidden = !emailValidator.validnaLiStroka(email)
    }

    func hranitOshibky(_ error: Error) {

        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
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

    func hranitOshibkyGoogle(_ error: Error) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        switch error {
        case SportivinieKartiFireBaseOshibka.notConfigured,
            SportivinieKartiGoogleAuthOshibka.noUserIdToken:
            self.error = L10n.Common.error
        default:
            break
        }
    }

    func hranitOshibkyApple(_ error: Error) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        switch error {
        case SportivinieKartiFireBaseOshibka.notConfigured,
         SportivinieKartiAppleAuthOshibka.noCredentials:
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
        UIView.animate(withDuration: info.animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func vhodNazhat() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard !isLoading else { return }

        view.endEditing(true)
        isLoading = true

        let (email, password) = (self.email, self.password)

        Task { @MainActor in
            defer { isLoading = false }

            do {
                try await authService.podgotovitRegistraciu(withEmail: email, password: password)
            } catch {
                hranitOshibky(error)
                return
            }

            delegate?.vhodUserVoshel(self)
        }
    }

    @objc func regNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.vhodNazhataKnopkaRegistracii(self)
    }

    @objc func vhodeCherezAppleNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        view.endEditing(true)

        Task { @MainActor in
            do {
                try await authService.vhodeCherezApple(in: self)
            } catch {
                hranitOshibkyApple(error)
                return
            }

            delegate?.vhodUserVoshel(self)
        }
    }

    @objc func vhodeCherezGoggleNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        view.endEditing(true)

        Task { @MainActor in
            do {
                try await authService.vhodeCherezGoogle(in: self)
            } catch {
                hranitOshibkyGoogle(error)
                return
            }

            delegate?.vhodUserVoshel(self)
        }
    }

    @objc func zabilParolNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.vhodNazhataZabilParol(self)
    }

    @objc func nazhatie(_ sender: UIButton) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        sender.backgroundColor = .blue
    }
    @objc func nazhatieZakonchilos(_ sender: UIButton) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        sender.backgroundColor = .clear
    }

    @objc func textPoleDidIzmenilos(_ textField: UITextField) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        error = ""
        let updatedText = textField.text ?? ""

        switch textField {
        case signInView.emailView.textField:
            email = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
            self.validirovatPochty(self.email)

        case signInView.passwordView.textField:
            password = updatedText
        default:
            break
        }
    }

}

// MARK: - TextField Delegate

extension SportivinieKartiVhodVC: UITextFieldDelegate {
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
