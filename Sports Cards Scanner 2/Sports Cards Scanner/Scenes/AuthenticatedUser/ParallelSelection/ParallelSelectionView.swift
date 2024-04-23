import UIKit
import SnapKit

final class ParallelSelectionView: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var searchTextField: CommonTextField = { textField in
        textField.borderStyle = .none
        textField.font = .font(.ubuntuRegular400, size: 16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = 12
        textField.placeholder = L10n.ParallelSelection.Search.placeholder
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

    lazy var allOptionsLabel: UILabel = { label in
        label.text = L10n.ParallelSelection.allOptions
        label.textColor = .labelColor
        label.font = .font(.ubuntuMedium500, size: 22)
        label.setLineHeight(21.6)
        return label
    }(UILabel())

    lazy var underlineView: UIView = { view in
        view.backgroundColor = .dividerColor
        return view
    }(UIView())

    lazy var parallelsCollectionView: UICollectionView = { collectionView in
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }(BaseCollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout()))

    lazy var noResultsView: CommonMessageView = { view in
        view.setMessageTitle(L10n.ParallelSelection.noResult)
        return view
    }(CommonMessageView())

    lazy var noneParallelButton: UIButton = { button in
        button.setTitle(L10n.ParallelSelection.Action.none, for: .normal)
        button.setTitleColor(.labelColor, for: .normal)
        button.titleLabel?.font = .font(.ubuntuMedium500, size: 16)
        return button
    }(UIButton(type: .system))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setNoResultsView(visible: Bool) {
        parallelsCollectionView.isUserInteractionEnabled = !visible
        noResultsView.isHidden = !visible
    }
}

private extension ParallelSelectionView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        backView.setupView(in: self)
        titleLabel.setupLabel(in: backView)
        setupSearchTextField()

        backView.addSubviews(searchTextField, allOptionsLabel, noneParallelButton, underlineView, parallelsCollectionView, noResultsView)
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        allOptionsLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        noneParallelButton.snp.makeConstraints {
            $0.centerY.equalTo(allOptionsLabel)
            $0.leading.equalTo(allOptionsLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
        underlineView.snp.makeConstraints {
            $0.top.equalTo(allOptionsLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        parallelsCollectionView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        noResultsView.snp.makeConstraints {
            $0.top.equalTo(parallelsCollectionView).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
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

    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 22
        layout.minimumLineSpacing = 22
        layout.sectionInset = .init(top: 12, left: 20, bottom: 0, right: 20)
        return layout
    }
}
