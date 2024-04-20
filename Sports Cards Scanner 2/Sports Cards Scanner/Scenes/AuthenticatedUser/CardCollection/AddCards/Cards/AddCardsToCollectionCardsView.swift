import UIKit
import SnapKit

final class AddCardsToCollectionCardsView: UIView {

    private var cardsHeightConstraint: Constraint!

    lazy var backView: UIView = { view in
        view.setupBackView()
        return view
    }(UIView())

    lazy var titleLabel: TitleLabel = .init()

    lazy var searchTextField: CommonTextField = { textField in
        textField.borderStyle = .none
        textField.font = .font(.interRegular, size: 16)
        textField.backgroundColor = .skyBlue
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

    lazy var selectedCardsLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 22)
        label.textColor = .black
        return label
    }(UILabel())

    lazy var selectAllButton: UIButton = { button in
        let attributedTitle = NSAttributedString(
            string: L10n.AddCards.Action.selectAll,
            attributes: [.font: UIFont.font(.ubuntuRegular400, size: 14)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var cardsContainerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

//    lazy var backButton: UIButton = { button in
//        button.setImage(Images.backArrow.image, for: .normal)
//        return button
//    }(UIButton(type: .system))

//    lazy var categoryLabel: UILabel = { label in
//        label.font = .font(.interMedium, size: 20)
//        label.textColor = .labelColor
//        return label
//    }(UILabel())

    lazy var cardsCollectionView: UICollectionView = { collectionView in
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .skyBlue
        return collectionView
    }(BaseCollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout()))

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

    func setSelectedCards(number: Int) {
        switch number {
        case 1:
            selectedCardsLabel.text = L10n.AddCards.oneCardSelected
        default:
            selectedCardsLabel.text = L10n.AddCards.numberOfCardsSelected(number)
        }
    }

    func setCategory(_ category: CardCategory) {
//        categoryLabel.text = category.title
//        categoryLabel.setLineHeight(24)
    }

    func setCards(count: Int) {
        let layout = cardsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let cardsWidth = cardsCollectionView.bounds.width
        let horizontalSpacing: CGFloat = (layout?.sectionInset.left ?? 0) + (layout?.sectionInset.right ?? 0)
        let itemsInRow: CGFloat = 3
        let interitemSpacing: CGFloat = layout?.minimumInteritemSpacing ?? 0
        let itemWidth = (cardsWidth - horizontalSpacing - (itemsInRow - 1) * interitemSpacing) / itemsInRow
        let itemHeight = itemWidth * 1.388
        let rowsCount = (CGFloat(count) / itemsInRow).rounded(.up)
        let cardsHeight = itemHeight * rowsCount + interitemSpacing * (rowsCount - 1)
        cardsHeightConstraint.update(offset: max(0, cardsHeight))

//        backButton.snp.remakeConstraints {
//            $0.top.leading.equalToSuperview().inset(6)
//            $0.size.equalTo(44)
//            $0.bottom.equalToSuperview().inset(6).priority(cardsHeight <= 0 ? .required : .low)
//        }
    }

    func setNoResultsView(visible: Bool) {
        noResultsView.isHidden = !visible
    }

}

private extension AddCardsToCollectionCardsView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        titleLabel.setupLabel(in: backView)

        setupSearchTextField()

        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 25

        backView.addSubviews(searchTextField, selectedCardsLabel, selectAllButton, cardsContainerView, noResultsView, buttonsStackView)
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        selectedCardsLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(22)
        }
        selectAllButton.snp.makeConstraints {
            $0.centerY.equalTo(selectedCardsLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        setupCardsContainer()

        cardsContainerView.snp.makeConstraints {
            $0.top.equalTo(selectedCardsLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        noResultsView.snp.makeConstraints {
            $0.top.equalTo(cardsContainerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        buttonsStackView.snp.makeConstraints {
            $0.height.equalTo(112)
            $0.top.greaterThanOrEqualTo(cardsContainerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
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

    func setupCardsContainer() {
        cardsContainerView.addSubview(cardsCollectionView)
        cardsCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectAllButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.high)
            cardsHeightConstraint = $0.height.equalTo(0).priority(.medium).constraint
        }
    }

    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }
}
