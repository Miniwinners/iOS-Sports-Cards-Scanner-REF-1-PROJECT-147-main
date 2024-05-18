import UIKit
import SnapKit
func vicheslitFibonc224(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

final class SportivinieKartiUpdateParolController: UIViewController {

    // MARK: - Subviews

    lazy var updatePasswordView: SportivinieKartiUpdateParolVid = .init()
    lazy var closeButton: CloseButton = .init(style: .close)
    lazy var keyboardToolbar: SportivinieKartiCustomTool = { toolbar in
        toolbar.sizeToFit()
        return toolbar
    }(SportivinieKartiCustomTool.createToolbar(in: view))

    // MARK: - Models

    private let authService: SportivinieKartiAuthenticationService
    weak var delegate: SportivinieKartiUpdateParolDelegat?

    private let passwordValidator: SportivinieKartiPSWDValidator = .init()
    private let passwordLengthValidator: SportivinieKartiDlinaValidator = .init(minLength: 8)
    private let minLengthValidator: SportivinieKartiDlinaValidator = .init(minLength: 1)
    private let maxLengthValidator: SportivinieKartiDlinaValidator = .init(maxLength: 255)

    private var newPassword = "" {
        didSet { obnovitKnopkySohranenia() }
    }
    private var confirmNewPassword = "" {
        didSet { obnovitKnopkySohranenia() }
    }

    private var error = "" {
        didSet {
            obnovitLabelOshibki(animated: true)
            if !error.isEmpty {
                updatePasswordView.saveButton.isEnabled = false
            }
        }
    }

    private var isLoading: Bool = false {
        didSet { updatePasswordView.saveButton.isLoading = isLoading }
    }

    private var validationError: String? {
        guard passwordValidator.validnaLiStroka(newPassword)
                && passwordLengthValidator.validnaLiStroka(newPassword)
        else {
            return L10n.UpdatePassword.Error.noPasswordRequirements
        }
        guard newPassword == confirmNewPassword else {
            return L10n.UpdatePassword.Error.passwordsMismatch
        }
        return nil
    }

    init(authService: SportivinieKartiAuthenticationService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        updatePasswordView.titleLabel.text = L10n.UpdatePassword.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        view = updatePasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        postavitVid()
        postavidDeistviaUnicalno()
        obnovitKnopkySohranenia()
        obnovitLabelOshibki(animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)

        closeButton.setCenter(in: view)
        closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
    }
}

private extension SportivinieKartiUpdateParolController {
    func postavitVid() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        [updatePasswordView.passwordView, updatePasswordView.confirmPasswordView]
            .map { $0.textField }
            .forEach { $0.delegate = self }
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        [updatePasswordView.passwordView, updatePasswordView.confirmPasswordView]
            .map { $0.textField }
            .forEach {
                $0.addTarget(self, action: #selector(textPoleDidIzmenilos(_:)), for: .editingChanged)
            }

        updatePasswordView.saveButton.addTarget(self, action: #selector(sohranitNazhata), for: .touchUpInside)
    }

    func obnovitKnopkySohranenia() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let isCredsNotEmpty = minLengthValidator.validnaLiStroka(newPassword)
            && minLengthValidator.validnaLiStroka(confirmNewPassword)
        updatePasswordView.saveButton.isEnabled = isCredsNotEmpty
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func obnovitLabelOshibki(animated: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
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

    func oshibkaPriIzmeneniiParolya(_ error: Error) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        switch error {
        case SportivinieKartiCommonAuthOshibka.needReauthenticate:
            self.error = L10n.UpdatePassword.Error.needReauthenticate
        default:
            self.error = L10n.Common.error
        }
    }

    // MARK: - Actions

    @objc func zakritNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.updatePasswordViewControllerzakrtiNazhata(self)
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
        case updatePasswordView.passwordView.textField:
            newPassword = updatedText
        case updatePasswordView.confirmPasswordView.textField:
            confirmNewPassword = updatedText
        default:
            break
        }
    }

    @objc func sohranitNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
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
                try await authService.poneyatParolUsera(to: newPassword)
            } catch {
                oshibkaPriIzmeneniiParolya(error)
                return
            }

            delegate?.updatePasswordViewControllerPasswordObnovilos(self)
        }
    }
}

// MARK: - TextField Delegate

extension SportivinieKartiUpdateParolController: UITextFieldDelegate {
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
