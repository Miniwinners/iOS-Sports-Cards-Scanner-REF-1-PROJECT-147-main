import UIKit
import SnapKit

final class SearchCardView: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()
    lazy var searchTextField: CommonTextField = { textField in
        textField.borderStyle = .none
        textField.font = .font(.interRegular, size: UIDevice.isIpad ? 24: 16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = UIDevice.isIpad ? 30:12
        textField.placeholder = L10n.SearchCard.Search.placeholder
        textField.rightViewMode = .always
        textField.trailingPadding = 48
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.tintColor = .black
        return textField
    }(CommonTextField())

    var searchImageView: UIImageView?

    lazy var loadingIndicatorView: UIActivityIndicatorView = { indicator in
        indicator.tintColor = .labelColor
        indicator.hidesWhenStopped = true
        return indicator
    }(UIActivityIndicatorView(style: .medium))

    lazy var noResultsView: CommonMessageView = { view in
        view.setMessageTitle(L10n.SearchCard.Error.tryAgain)
        return view
    }(CommonMessageView())

    lazy var searchCollectionView: UICollectionView = { collectionView in
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }(UICollectionView(frame: .zero, collectionViewLayout: filterLayout()))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setNoResultsView(visible: Bool) {
        searchCollectionView.isUserInteractionEnabled = !visible
        noResultsView.isHidden = !visible
    }

    func setLoading(_ isLoading: Bool) {
        searchImageView?.isHidden = isLoading
        if isLoading {
            loadingIndicatorView.startAnimating()
        } else {
            loadingIndicatorView.stopAnimating()
        }
    }

}

private extension SearchCardView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        backView.setupView(in: self)
        titleLabel.setupLabel(in: backView)

        backView.addSubviews(searchTextField, searchCollectionView, noResultsView)
        setupSearchTextField()
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 100 : 48)
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40 : 30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        noResultsView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        setNoResultsView(visible: false)

        searchCollectionView.isUserInteractionEnabled = false
    }

    func setupSearchTextField() {
        let imageView = searchTextField.setRightImage_unique(
            Images.search.image,
            paddings: .init(top: 0, left: 8, bottom: 0, right: 16)
        )
        searchTextField.rightView?.addSubview(loadingIndicatorView)
        loadingIndicatorView.snp.makeConstraints {
            $0.center.equalTo(imageView)
        }

        searchImageView = imageView
    }
}

private extension SearchCardView {
    func filterLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(UIDevice.isIpad ? 253:162),
            heightDimension: .absolute(UIDevice.isIpad ? 464:317)
        )

        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(UIDevice.isIpad ? 464:317))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: UIDevice.isIpad ? 3:2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )

        return UICollectionViewCompositionalLayout(section: section)
    }
}
