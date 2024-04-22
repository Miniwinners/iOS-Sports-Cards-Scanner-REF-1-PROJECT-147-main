import UIKit
import SnapKit

final class UpdatePasswordView: UIView {

    lazy var backView: BackView = .init()

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.UpdatePassword.title
        label.setLineHeight(24)
        label.font = .font(.ubuntuBold700, size: 22)
        label.textColor = .logInLabel
        label.textAlignment = .center
        return label
    }(UILabel())

    let lockContainer = UIView()
    let unlockContainer = UIView()

    lazy var contentView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = . fill
        stackView.spacing = 10
        return stackView
    }(UIStackView(arrangedSubviews: [errorLabel, lockContainer, passwordView, unlockContainer, confirmPasswordView, passwordRequirementsLabel]))

    lazy var errorLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 14)
        label.textColor = .errorColor
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var lockImageView: UIImageView = { image in
        image.image = Images.lockLogo.image
        return image
    }(UIImageView())

    lazy var unlockImageView: UIImageView = { image in
        image.image = Images.unlockLogo.image
        return image
    }(UIImageView())

    lazy var passwordView: TitledTextFieldView = { view in
        view.title = L10n.UpdatePassword.NewPassword.title
        view.titleLabel.textAlignment = .center
        view.titleLabel.font = .font(.ubuntuLight300, size: 16)
        view.titleLabel.textColor = .logInLabel
        view.placeholder = L10n.UpdatePassword.NewPassword.placeholder
        view.textField.isSecureTextEntry = true
        view.textField.autocorrectionType = .no
        view.textField.returnKeyType = .next
        return view
    }(TitledTextFieldView())

    lazy var confirmPasswordView: TitledTextFieldView = { view in
        view.title = L10n.UpdatePassword.ConfirmNewPassword.title
        view.titleLabel.textAlignment = .center
        view.titleLabel.font = .font(.ubuntuLight300, size: 16)
        view.titleLabel.textColor = .logInLabel
        view.placeholder = L10n.UpdatePassword.ConfirmNewPassword.placeholder
        view.textField.isSecureTextEntry = true
        view.textField.autocorrectionType = .no
        view.textField.returnKeyType = .done
        return view
    }(TitledTextFieldView())

    lazy var passwordRequirementsLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 12)
        label.textColor = .labelColor
        label.numberOfLines = 0
        label.attributedText = makeTextBlue()
        label.setLineHeight(22)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var saveButton: CommonButton = { button in
        button.setButtonTitle(L10n.UpdatePassword.Action.save)
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .clear
        setupSubviews_unique()
    }
}

private extension UpdatePasswordView {
    func setupSubviews_unique() {
        backView.setupView(in: self)
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(65)
            $0.horizontalEdges.equalToSuperview().inset(20)

        }
        backView.addSubviews(contentView, saveButton)

        lockContainer.addSubview(lockImageView)
        unlockContainer.addSubview(unlockImageView)

        lockContainer.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        unlockContainer.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        contentView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        lockImageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.center.equalToSuperview()
        }
        unlockImageView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(56)
            $0.center.equalToSuperview()
        }
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
    }
}

private extension UpdatePasswordView {
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
