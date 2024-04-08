import UIKit
import SnapKit

final class ForgotPasswordView: UIView {

    lazy var descriptionView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var descriptionLabel: UILabel = { label in
        label.text = L10n.ForgotPassword.description
        label.textColor = .labelColor
        label.font = .font(.interRegular, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var contentView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }(UIStackView(arrangedSubviews: [errorLabel, emailView]))

    lazy var emailView: TitledTextFieldView = { view in
        view.title = L10n.ForgotPassword.Email.title
        view.placeholder = L10n.ForgotPassword.Email.placeholder
        view.textField.keyboardType = .emailAddress
        view.textField.autocorrectionType = .no
        view.textField.autocapitalizationType = .none
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

    lazy var sendButton: CommonButton = { button in
        button.setButtonTitle(L10n.ForgotPassword.Action.send)
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

}

private extension ForgotPasswordView {
    func setupSubviews_unique() {
        backgroundColor = .backColor

        addSubview(descriptionView)
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        addSubview(sendButton)
        sendButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
    }
}
