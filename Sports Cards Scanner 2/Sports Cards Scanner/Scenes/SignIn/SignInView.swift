import UIKit
import SnapKit

final class SignInView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.SignIn.title
        label.textColor = .singINLabel
        label.font = .font(.ubuntuRegular400, size: 20)
        return label
    }(UILabel())

    lazy var welcomeLabel: UILabel = { label in
        label.text = "Welcome Back!"
        label.textColor = .black
        label.font = .font(.ubuntuBold700, size: 28)
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var enterDetails: UILabel = { label in
        label.text = "Please enter yout login details"
        label.textColor = .singINLabel
        label.textAlignment = .center
        label.font = .font(.ubuntuRegular400, size: 16)
        return label
    }(UILabel())

    lazy var logInWith: UILabel = { label in
        label.text = "Log in with."
        label.textAlignment = .center
        label.font = .font(.ubuntuMedium500, size: 16)
        label.textColor = .logInLabel
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

    lazy var facebookButton: UIButton = { button in
        button.setImage(Images.facebookLogo.image, for: .normal)
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        return button
    }(UIButton())

    lazy var appleButton: UIButton = { button in
        button.setImage(Images.appleLogo.image, for: .normal)
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        return button
    }(UIButton(type: .system))

    lazy var googleButton: UIButton = { button in
        button.setImage(Images.googleLogo.image, for: .normal)
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        return button
    }(UIButton(type: .system))

    lazy var forgotPasswordButton: UIButton = { button in
        let attributedTitle = NSAttributedString(
            string: L10n.SignIn.Password.forgot,
            attributes: [.font: UIFont.font(.ubuntuRegular400, size: 16)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var otherSignInMethodsView: UIStackView = { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }(UIStackView(arrangedSubviews: [appleButton, facebookButton, googleButton]))

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
            titleLabel, welcomeLabel, enterDetails, logInWith, fieldsView, signInButton,
            forgotPasswordButton, otherSignInMethodsView, noAccountView
        )
        setupConstraints_unique()
    }

    func setupConstraints_unique() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20).priority(.low)
            $0.top.greaterThanOrEqualTo(safeAreaLayoutGuide).inset(30)
            $0.top.lessThanOrEqualTo(safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(22)
            $0.width.equalTo(61)
        }
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.equalTo(324)
        }
        enterDetails.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(324)
            $0.height.equalTo(22)
        }
        logInWith.snp.makeConstraints {
            $0.top.equalTo(otherSignInMethodsView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(324)
        }
        fieldsView.snp.makeConstraints {
            $0.top.equalTo(logInWith.snp.bottom).offset(20).priority(.medium)
            $0.top.greaterThanOrEqualTo(logInWith.snp.bottom).offset(20)
            $0.top.lessThanOrEqualTo(logInWith.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        signInButton.snp.makeConstraints {
            $0.top.equalTo(fieldsView.snp.bottom).offset(80)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(58)
        }
        forgotPasswordButton.snp.makeConstraints {
            $0.top.equalTo(fieldsView.snp.bottom).offset(10)
            $0.right.equalTo(fieldsView)
            $0.width.equalTo(130)
            $0.height.equalTo(22)
        }
        [appleButton, facebookButton, googleButton]
            .map { $0.snp }
            .forEach { $0.makeConstraints({
                $0.height.equalTo(58)
                $0.width.equalTo(99)
            }) }
        otherSignInMethodsView.snp.makeConstraints {
            $0.top.equalTo(enterDetails.snp.bottom).offset(30)
            $0.height.equalTo(58)
            $0.centerX.equalToSuperview()
        }
        noAccountView.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.lessThanOrEqualTo(200)
        }
    }
}
