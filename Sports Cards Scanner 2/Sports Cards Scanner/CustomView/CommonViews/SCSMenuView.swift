import UIKit
import SnapKit

final class MenuView: UIView {

    lazy var menuCollectionView: UICollectionView = { collectionView in
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = false
        return collectionView
    }(UICollectionView(frame: .zero, collectionViewLayout: filterLayout()))

    lazy var cancelButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(CommonButton(style: .cancel))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }
}

private extension MenuView {
    func setupSubviews_unique() {
        backgroundColor = .white

        addSubviews(menuCollectionView, cancelButton)
        menuCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(menuCollectionView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20).priority(.high)
            $0.height.equalTo(56)
        }
    }
}

private extension MenuView {
    func filterLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .absolute(145),
            heightDimension: .absolute(124)
        )

        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(124))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(
            top: 10,
            leading: 10,
            bottom: 0,
            trailing: 10
        )

        return UICollectionViewCompositionalLayout(section: section)
    }
}
