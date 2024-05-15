import UIKit
func vicheslitFibonc277(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiFPVC: UIViewController {

    // MARK: - Subviews

    lazy var forgotPasswordView: SportivinieKartiFPV = .init()

    lazy var keyboardToolbar: SportivinieKartiCToolB = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCToolB.createToolbar(in: view))

    lazy var closeButton: CloseButton = .init(style: .close)

    private let authService: SportivinieKartiAuthenticationSc
    weak var delegate: SportivinieKartiFPVD?

    private let minLengthValidator: SportivinieKartiDlinaValidator = .init(minLength: 1)
    private let maxLengthValidator: SportivinieKartiDlinaValidator = .init(maxLength: 255)

    private var email = "" {
        didSet { obnovitKnopkyOtpravki() }
    }

    private var error = "" {
        didSet {
            obnovitLabelOshibki(animated: true)
            if !error.isEmpty {
                forgotPasswordView.sendButton.isEnabled = false
            }
        }
    }

    private var isLoading: Bool = false {
        didSet { forgotPasswordView.sendButton.isLoading = isLoading }
    }

    init(authService: SportivinieKartiAuthenticationSc) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        forgotPasswordView.titleLabel.text = L10n.ForgotPassword.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = forgotPasswordView
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
        postavidDeistviaUnicalno()
        obnovitKnopkyOtpravki()
        obnovitLabelOshibki(animated: false)
    }
}

private extension SportivinieKartiFPVC {
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
        forgotPasswordView.emailView.textField.delegate = self
        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
    }

    func postavidDeistviaUnicalno() {
        forgotPasswordView.sendButton.addTarget(self, action: #selector(otpravitNazhata), for: .touchUpInside)
        forgotPasswordView.emailView.textField.addTarget(self, action: #selector(textPoleDidIzmenilos(_:)), for: .editingChanged)
    }

    func obnovitKnopkyOtpravki() {
        let isCredsNotEmpty = minLengthValidator.validnaLiStroka(email)
        forgotPasswordView.sendButton.isEnabled = isCredsNotEmpty
    }

    func obnovitLabelOshibki(animated: Bool) {
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

    func hranitOshibkyOtpravki(_ error: Error) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
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

    @objc func otpravitNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        view.endEditing(true)
        isLoading = true

        let email = self.email

        Task { @MainActor in
            defer { isLoading = false }

            do {
                try await authService.poslatResetPochti(to: email)
            } catch {
                hranitOshibkyOtpravki(error)
                return
            }

            delegate?.zabilParol(emailSentTo: email, from: self)
        }
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
        case forgotPasswordView.emailView.textField:
            email = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
        default:
            break
        }
    }

    @objc func zakritNazhata() {
        delegate?.forgotPasswordViewControllerzakrtiNazhata(self)
    }
}

// MARK: - TextField Delegate

extension SportivinieKartiFPVC: UITextFieldDelegate {
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
        case forgotPasswordView.emailView.textField:
            textField.resignFirstResponder()
        default:
            break
        }

        return true
    }
}
