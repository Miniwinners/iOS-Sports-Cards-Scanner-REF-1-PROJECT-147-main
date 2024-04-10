import UIKit
import SnapKit

final class UpdatePasswordView: UIView {

    lazy var contentView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }(UIStackView(arrangedSubviews: [errorLabel, passwordView, confirmPasswordView, passwordRequirementsLabel]))

    lazy var errorLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 14)
        label.textColor = .errorColor
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var passwordView: TitledTextFieldView = { view in
        view.title = L10n.UpdatePassword.NewPassword.title
        view.placeholder = L10n.UpdatePassword.NewPassword.placeholder
        view.textField.isSecureTextEntry = true
        view.textField.autocorrectionType = .no
        view.textField.returnKeyType = .next
        return view
    }(TitledTextFieldView())

    lazy var confirmPasswordView: TitledTextFieldView = { view in
        view.title = L10n.UpdatePassword.ConfirmNewPassword.title
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
        label.text = L10n.UpdatePassword.NewPassword.requirements(8)
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

        backgroundColor = .backColor
        setupSubviews_unique()
    }
}

private extension UpdatePasswordView {
    func setupSubviews_unique() {
        addSubviews(contentView, saveButton)

        contentView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
    }
}
