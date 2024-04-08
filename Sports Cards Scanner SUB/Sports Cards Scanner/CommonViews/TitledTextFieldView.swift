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
        label.font = .font(.interRegular, size: 16)
        label.textColor = .labelColor
        label.numberOfLines = 0
        return label
    }(UILabel())

    lazy var textField: CommonTextField = { textField in
        textField.borderStyle = .none
        textField.font = .font(.interRegular, size: 16)
        textField.backgroundColor = .white
        textField.cornerRadius = 12
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
            $0.height.equalTo(22)
        }

        textField.snp.makeConstraints {
            $0.height.equalTo(48)
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
