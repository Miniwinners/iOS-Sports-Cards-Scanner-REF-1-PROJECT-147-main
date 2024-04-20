import UIKit
import SnapKit

final class CreateEditDeckView: UIView {

    lazy var titleLabel: TitleLabel = .init()

    lazy var titleImage: UIImageView = .init(image: Images.cardNocards.image)
    lazy var deckImage: UIImageView = .init(image: Images.deckSign.image)
    lazy var descriptionImage: UIImageView = .init(image: Images.CollectionMenu.renameCollection.image)

    lazy var containerView: UIView = .init()

    lazy var nameView: TitledTextFieldView = { view in
        view.title = L10n.CreateDeck.DeckName.title
        view.titleLabel.textAlignment = .center
        view.titleLabel.font = .font(.ubuntuLight300, size: 16)
        view.placeholder = L10n.CreateDeck.DeckName.placeholder
        view.textField.autocorrectionType = .no
        view.textField.returnKeyType = .done
        view.textField.autocapitalizationType = .sentences
        view.backgroundColor = .red
        return view
    }(TitledTextFieldView())

    lazy var deckTypeLabel: UILabel = { label in
        label.font = .font(.ubuntuLight300, size: 16)
        label.text = L10n.CreateDeck.DeckType.title
        label.textColor = .black
        label.textAlignment = .center
        label.setLineHeight(22)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var deckTypeView: OptionsView = { view in
        view.containerView.backgroundColor = .clear
         view.setOptionTitle(L10n.CreateDeck.DeckType.select)
        view.showsShadow = false
        return view
    }(OptionsView(minHeight: 48, maxHeight: 129))

    lazy var descriptionLabel: UILabel = { label in
        label.font = .font(.ubuntuLight300, size: 16)
        label.text = L10n.CreateDeck.Description.title
        label.textColor = .black
        label.textAlignment = .center
        label.setLineHeight(22)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var descriptionTextView: BaseTextView = { textView in
        textView.placeholder = L10n.CreateDeck.Description.placeholder
        textView.autocorrectionType = .no
        textView.backgroundColor = .skyBlue
        return textView
    }(BaseTextView())

    lazy var createButton: CommonButton = { button in
        button.setButtonTitle(L10n.CreateDeck.Action.create)
        button.setImage(Images.collectionCards.image, for: .normal)
        return button
    }(CommonButton(style: .default))

    lazy var cancelButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(CommonButton(style: .cancel))

    lazy var doneButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setupForCreation() {

        addSubviews(deckImage, deckTypeLabel, deckTypeView, createButton)
        deckImage.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(33)
            $0.width.equalTo(48)
        }
        deckTypeLabel.snp.makeConstraints {
            $0.top.equalTo(deckImage.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(descriptionLabel.snp.top).inset(-76)
        }
        deckTypeView.snp.makeConstraints {
            $0.top.equalTo(deckTypeLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        createButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(descriptionTextView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(54)
        }

        bringSubviewToFront(deckTypeView)
    }

    func setupForEditing() {
        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20

        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(descriptionTextView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(54)
        }
    }

}

private extension CreateEditDeckView {
    func setupSubviews_unique() {
        titleLabel.setupLabel(in: self)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
        }
        addSubview(titleImage)
        titleImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(32)
        }
        addSubviews(nameView, descriptionImage, descriptionLabel, descriptionTextView)
        nameView.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        descriptionImage.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(nameView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(32)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionImage.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(214).priority(.high)
        }
    }
}
