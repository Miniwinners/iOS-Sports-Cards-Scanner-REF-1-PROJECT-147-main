import UIKit
import SnapKit

final class CreateEditDeckView: UIView {

    lazy var nameView: TitledTextFieldView = { view in
        view.title = L10n.CreateDeck.DeckName.title
        view.placeholder = L10n.CreateDeck.DeckName.placeholder
        view.textField.autocorrectionType = .no
        view.textField.returnKeyType = .done
        view.textField.autocapitalizationType = .sentences
        return view
    }(TitledTextFieldView())

    lazy var deckTypeLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 16)
        label.text = L10n.CreateDeck.DeckType.title
        label.textColor = .labelColor
        label.setLineHeight(22)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var deckTypeView: OptionsView = { view in
        view.setOptionTitle(L10n.CreateDeck.DeckType.select)
        view.showsShadow = true
        return view
    }(OptionsView(minHeight: 48, maxHeight: 129))

    lazy var descriptionLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 16)
        label.text = L10n.CreateDeck.Description.title
        label.textColor = .labelColor
        label.setLineHeight(22)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var descriptionTextView: BaseTextView = { textView in
        textView.placeholder = L10n.CreateDeck.Description.placeholder
        textView.autocorrectionType = .no
        return textView
    }(BaseTextView())

    lazy var createButton: CommonButton = { button in
        button.setButtonTitle(L10n.CreateDeck.Action.create)
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
        addSubviews(deckTypeLabel, deckTypeView, createButton)
        deckTypeLabel.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
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
        addSubviews(nameView, descriptionLabel, descriptionTextView)
        nameView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(20).priority(.high)
            $0.leading.equalToSuperview().inset(20)
        }
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(214).priority(.high)
        }
    }
}
