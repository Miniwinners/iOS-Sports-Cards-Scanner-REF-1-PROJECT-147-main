import UIKit
import SnapKit

class TitledTextFieldView: UIView {

    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }

    var text: String { textField.text ?? "" }

    var placeholder: String {
        get { textField.attributedPlaceholder?.string ?? "" }
        set { textField.placeholder = newValue }
    }

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 16)
        label.textColor = .logInLabel
        label.numberOfLines = 0
        return label
    }(UILabel())

    lazy var textField: CommonTextField = { textField in
        textField.borderStyle = .none
        textField.font = .font(.ubuntuLight300, size: 16)
        textField.backgroundColor = .skyBlue
        textField.textColor = .logInLabel
        textField.cornerRadius = 16
        textField.tintColor = .logInLabel
        return textField
    }(CommonTextField())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }
}

private extension TitledTextFieldView {
    func setupSubviews_unique() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
        }

        textField.snp.makeConstraints {
            $0.height.equalTo(56)
        }

        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
