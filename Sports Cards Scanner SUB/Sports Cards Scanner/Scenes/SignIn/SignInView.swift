import UIKit
import SnapKit

final class SignInView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.SignIn.title
        label.textColor = .labelColor
        label.font = .font(.interSemibold, size: 32)
        return label
    }(UILabel())

    lazy var fieldsView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }(UIStackView(arrangedSubviews: [errorLabel, emailView, passwordView]))

    lazy var emailView: TitledTextFieldView = { view in
        view.title = L10n.SignIn.Email.title
        view.placeholder = L10n.SignIn.Email.placeholder
        view.textField.keyboardType = .emailAddress
        view.textField.autocorrectionType = .no
        view.textField.autocapitalizationType = .none
        view.textField.returnKeyType = .next
        return view
    }(TitledTextFieldView())

    lazy var passwordView: TitledTextFieldView = { view in
        view.title = L10n.SignIn.Password.title
        view.placeholder = L10n.SignIn.Password.placeholder
        view.textField.isSecureTextEntry = true
        view.textField.autocorrectionType = .no
        view.textField.returnKeyType = .done
        return view
    }(TitledTextFieldView())

    lazy var errorLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 14)
        label.textColor = .errorColor
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var signInButton: CommonButton = { button in
        button.setButtonTitle(L10n.SignIn.Action.signIn)
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

    lazy var forgotPasswordButton: UIButton = { button in
        let attributedTitle = NSAttributedString(
            string: L10n.SignIn.Password.forgot,
            attributes: [.font: UIFont.font(.interRegular, size: 16)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.labelColor, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var otherSignInMethodsLabel: UILabel = { label in
        label.font = .font(.poppinsMedium, size: 19.25)
        label.text = L10n.SignIn.signInWith
        label.textColor = .labelColor2
        return label
    }(UILabel())

    lazy var otherSignInMethodsView: UIStackView = { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }(UIStackView(arrangedSubviews: [appleButton, googleButton]))

    lazy var noAccountLabel: UILabel = { label in
        label.font = .font(.opensansRegular, size: 13.47)
        label.text = L10n.SignIn.noAccount
        label.textColor = .labelColor3
        return label
    }(UILabel())

    lazy var noAccountView: UIStackView = { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }(UIStackView(arrangedSubviews: [noAccountLabel, signUpButton]))

    lazy var signUpButton: UIButton = { button in
        button.setTitleColor(.black, for: .normal)
        let attributedTitle = NSAttributedString(
            string: L10n.SignIn.Action.signUp,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.font(.poppinsMedium, size: 13.47)
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

private extension SignInView {
    func setupSubviews_unique() {
        addSubviews(
            titleLabel, fieldsView, signInButton,
            forgotPasswordButton, otherSignInMethodsLabel,
            otherSignInMethodsView, noAccountView
        )
        setupConstraints_unique()
    }

    func setupConstraints_unique() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(70).priority(.low)
            $0.top.greaterThanOrEqualTo(safeAreaLayoutGuide).inset(30)
            $0.top.lessThanOrEqualTo(safeAreaLayoutGuide).inset(70)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(42)
        }
        fieldsView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60).priority(.medium)
            $0.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(30)
            $0.top.lessThanOrEqualTo(titleLabel.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        signInButton.snp.makeConstraints {
            $0.top.equalTo(fieldsView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
        forgotPasswordButton.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(22)
        }
        otherSignInMethodsLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.greaterThanOrEqualTo(forgotPasswordButton.snp.bottom).offset(40).priority(760)
            $0.centerX.equalToSuperview()
        }
        [appleButton, googleButton]
            .map { $0.snp }
            .forEach { $0.makeConstraints({ $0.size.equalTo(44) }) }
        otherSignInMethodsView.snp.makeConstraints {
            $0.top.equalTo(otherSignInMethodsLabel.snp.bottom).offset(12)
            $0.height.equalTo(44)
            $0.centerX.equalToSuperview()
        }
        noAccountView.snp.makeConstraints {
            $0.top.equalTo(otherSignInMethodsView.snp.bottom).offset(32)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(23)
        }
    }
}
