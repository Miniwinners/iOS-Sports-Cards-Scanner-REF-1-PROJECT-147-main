import UIKit
import SnapKit

final class AddCardsToDeckView: UIView {

    lazy var selectedCardsLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 18)
        label.textColor = .labelColor
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var searchTextField: CommonTextField = { textField in
        textField.borderStyle = .none
        textField.font = .font(.interRegular, size: 16)
        textField.backgroundColor = .white
        textField.cornerRadius = 12
        textField.placeholder = L10n.AddCards.Search.placeholder
        textField.rightViewMode = .always
        textField.trailingPadding = 48
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }(CommonTextField())

    var searchImageView: UIImageView!

    lazy var clearSearchButton: UIButton = { button in
        button.setImage(Images.clear.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var categoryLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 18)
        label.textColor = .labelColor
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardsTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.allowsMultipleSelection = true
        return tableView
    }(UITableView())

    lazy var noResultsView: CommonMessageView = { view in
        view.setMessageTitle(L10n.AddCards.noResult)
        return view
    }(CommonMessageView())

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

    func setCategory(_ category: CardCategory?) {
        categoryLabel.text = category?.title
        categoryLabel.setLineHeight(22)
    }

    func setSelectedCards(number: Int) {
        switch number {
        case 1:
            selectedCardsLabel.text = L10n.AddCards.oneCardSelected
        default:
            selectedCardsLabel.text = L10n.AddCards.numberOfCardsSelected(number)
        }
        selectedCardsLabel.setLineHeight(22)
    }

    func setNoResultsView(visible: Bool) {
        noResultsView.isHidden = !visible
    }

}

private extension AddCardsToDeckView {
    func setupSubviews_unique() {
        backgroundColor = .backColor

        setupSearchTextField()

        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20

        addSubviews(selectedCardsLabel, searchTextField, categoryLabel, cardsTableView, buttonsStackView, noResultsView)
        selectedCardsLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(20)
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(selectedCardsLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        cardsTableView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
        }
        noResultsView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(cardsTableView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(54)
        }

        setNoResultsView(visible: false)
    }

    func setupSearchTextField() {
        searchImageView = searchTextField.setRightImage_unique(
            Images.search.image,
            paddings: .init(top: 0, left: 8, bottom: 0, right: 16)
        )
        searchTextField.rightView?.addSubview(clearSearchButton)
        clearSearchButton.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.center.equalTo(searchImageView)
        }
        clearSearchButton.isHidden = true
    }
}
