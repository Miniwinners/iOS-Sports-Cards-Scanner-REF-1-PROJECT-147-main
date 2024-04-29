import UIKit
import SnapKit

final class SignUpView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.SignUp.title
        label.textColor = .labelColor
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 32:26)
        return label
    }(UILabel())

    lazy var fieldsView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }(UIStackView(arrangedSubviews: [errorLabel, emailView, passwordView, confirmPasswordView, passwordRequirementsLabel]))

    lazy var emailView: TitledTextFieldView = { view in
        view.title = L10n.SignUp.Email.title
        view.placeholder = L10n.SignUp.Email.placeholder
        view.textField.keyboardType = .emailAddress
        view.textField.autocorrectionType = .no
        view.textField.autocapitalizationType = .none
        view.textField.returnKeyType = .next
        return view
    }(TitledTextFieldView())

    lazy var passwordView: TitledTextFieldView = { view in
        view.title = L10n.SignUp.Password.title
        view.placeholder = L10n.SignUp.Password.placeholder
        view.textField.isSecureTextEntry = true
        view.textField.autocorrectionType = .no
        view.textField.returnKeyType = .next
        return view
    }(TitledTextFieldView())

    lazy var confirmPasswordView: TitledTextFieldView = { view in
        view.title = L10n.SignUp.ConfirmPassword.title
        view.placeholder = L10n.SignUp.ConfirmPassword.placeholder
        view.textField.isSecureTextEntry = true
        view.textField.autocorrectionType = .no
        view.textField.returnKeyType = .done
        return view
    }(TitledTextFieldView())

    lazy var errorLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 18:14)
        label.textColor = .errorColor
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var passwordRequirementsLabel: UILabel = { label in
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ? 16:12)
        label.textColor = .labelColor
        label.numberOfLines = 0
        label.attributedText = makeTextBlue()
        let attributedText = NSMutableAttributedString(
            string: L10n.SignUp.Password.requirements(8)
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.51
        attributedText.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
        label.attributedText = attributedText
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var signUpButton: CommonButton = { button in
        button.setButtonTitle(L10n.SignUp.Action.signUp)
        return button
    }(CommonButton(style: .default))

    lazy var appleButton: UIButton = { button in
        button.setImage(Images.appleLogo.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var googleButton: UIButton = { button in
        button.setImage(Images.googleLogo.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var signInMethodsLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22: 19.25)
        label.text = L10n.SignUp.signInWith
        label.textColor = .labelColor2
        return label
    }(UILabel())

    lazy var signInMethodsView: UIStackView = { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }(UIStackView(arrangedSubviews: [appleButton, googleButton]))

    lazy var haveAccountLabel: UILabel = { label in
        label.font = .font(.opensansRegular, size: UIDevice.isIpad ? 18:13.47)
        label.text = L10n.SignUp.haveAccount
        label.textColor = .labelColor3
        return label
    }(UILabel())

    lazy var haveAccountView: UIStackView = { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }(UIStackView(arrangedSubviews: [haveAccountLabel, signInButton]))

    lazy var signInButton: UIButton = { button in
        button.setTitleColor(.black, for: .normal)
        let attributedTitle = NSAttributedString(
            string: L10n.SignUp.Action.signIn,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.font(.ubuntuMedium500, size: UIDevice.isIpad ? 18:13.47)
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }(UIButton(type: .system))

    convenience init() {
        self.init(frame: .zero)

        setupSubviews_unique()
    }
}

private extension SignUpView {
    func setupSubviews_unique() {
        addSubviews(
            titleLabel, fieldsView, signUpButton,
            signInMethodsLabel, signInMethodsView, haveAccountView
        )
        setupConstraints_unique()
    }

    func setupConstraints_unique() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(90).priority(.low)
            $0.top.greaterThanOrEqualTo(safeAreaLayoutGuide).inset(60)
            $0.top.lessThanOrEqualTo(safeAreaLayoutGuide).inset(90)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(42)
        }
        fieldsView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60).priority(.medium)
            $0.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(20)
            $0.top.lessThanOrEqualTo(titleLabel.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(fieldsView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
            $0.height.equalTo(54)
        }
        signInMethodsLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.greaterThanOrEqualTo(signUpButton.snp.bottom).offset(40).priority(760)
            $0.centerX.equalToSuperview()
        }
        [appleButton, googleButton]
            .map { $0.snp }
            .forEach { $0.makeConstraints({ $0.size.equalTo(44) }) }
        signInMethodsView.snp.makeConstraints {
            $0.top.equalTo(signInMethodsLabel.snp.bottom).offset(12)
            $0.height.equalTo(44)
            $0.centerX.equalToSuperview()
        }
        haveAccountView.snp.makeConstraints {
            $0.top.equalTo(signInMethodsView.snp.bottom).offset(32)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(60)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(23)
        }
    }
}

private extension SignUpView {
    func makeTextBlue() -> NSMutableAttributedString {
        let fullText = L10n.UpdatePassword.NewPassword.requirements(8)
        let words = [L10n.UpdatePassword.NewPassword.updatePassword_newPassword_cut1,
                     L10n.UpdatePassword.NewPassword.updatePassword_newPassword_cut2,
                     L10n.UpdatePassword.NewPassword.updatePassword_newPassword_cut3,
                     L10n.UpdatePassword.NewPassword.updatePassword_newPassword_cut4,
                     L10n.UpdatePassword.NewPassword.updatePassword_newPassword_cut5
        ]
        let atributeString = NSMutableAttributedString(string: fullText)
        for word in words {
            let range = (fullText as NSString).range(of: word)
            if range.location != NSNotFound {
                atributeString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
            }
        }
        return atributeString
    }
}
