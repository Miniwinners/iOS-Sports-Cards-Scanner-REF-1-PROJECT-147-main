import UIKit
import SnapKit

final class EditCardView: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var parallelDetailView: DetailView = { view in
        view.setDetailName(L10n.EditCard.parallel)
        view.isUserInteractionEnabled = false
        return view
    }(DetailView())

    lazy var gradeDetailView: DetailView = { view in
        view.setDetailName(L10n.EditCard.grade)
        view.isUserInteractionEnabled = false
        return view
    }(DetailView())

    lazy var parallelDetailButton: CommonButton = .init(style: .custom(buttonAppearance))
    lazy var gradeDetailButton: CommonButton = .init(style: .custom(buttonAppearance))

    lazy var updateDetailsButton: CommonButton = { button in
        button.setButtonTitle(L10n.EditCard.Action.updateDetails)
        return button
    }(CommonButton(style: .default))

    lazy var setPriceLabel: UILabel = { label in
        label.text = L10n.EditCard.customPrice
        label.textColor = .black
        label.font = .font(.ubuntuMedium500, size: 16)
        return label
    }(UILabel())

    lazy var priceTextField: CommonTextField = { textField in
        textField.borderStyle = .none
        textField.font = .font(.ubuntuRegular400, size: 16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = 12
        textField.rightViewMode = .always
        textField.trailingPadding = 48
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .decimalPad
        return textField
    }(CommonTextField())

    lazy var customPriceLabel: UILabel = { label in
        label.textColor = .greenColor
        label.font = .font(.ubuntuRegular400, size: 16)
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

}

private extension EditCardView {
    var buttonAppearance: CommonButton.SCSAppearance {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 12
        return .init(configuration: configuration, backgroundColors: .init(primary: .skyBlue, highlighted: .highlightColor2))
    }

    func setupSubviews_unique() {
        backgroundColor = .clear

        backView.setupView(in: self)
        titleLabel.setupLabel(in: backView)
        parallelDetailButton.addSubview(parallelDetailView)
        parallelDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        parallelDetailButton.snp.makeConstraints {
            $0.height.equalTo(64)
        }

        gradeDetailButton.addSubview(gradeDetailView)
        gradeDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        gradeDetailButton.snp.makeConstraints {
            $0.height.equalTo(64)
        }

        priceTextField.snp.makeConstraints {
            $0.height.equalTo(65)
        }
        backView.addSubview(priceTextField)

        let stackView = UIStackView(arrangedSubviews: [gradeDetailButton, parallelDetailButton])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        backView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(130)
        }

        priceTextField.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }

        priceTextField.setRightImage_unique(
            Images.CollectionMenu.renameCollection.image,
            paddings: .init(top: 0, left: 8, bottom: 0, right: 16)
        )

        priceTextField.addSubview(customPriceLabel)
        customPriceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(18)
        }
        priceTextField.addSubview(setPriceLabel)
        setPriceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(18)
        }
        backView.addSubview(updateDetailsButton)
        updateDetailsButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
