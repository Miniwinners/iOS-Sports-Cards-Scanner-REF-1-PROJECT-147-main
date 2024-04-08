import UIKit
import SnapKit

final class CurrentCardsValueView: UIView {

    private var categoryValues: [(CardCategory, Double)] = []

    private var categoriesViewHeightConstraint: Constraint?

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Dashboard.currentValue
        label.textColor = .labelColor
        label.font = .font(.interMedium, size: 20)
        label.setLineHeight(22)
        return label
    }(UILabel())

    lazy var priceLabel: UILabel = { label in
        label.textColor = .greenColor
        label.font = .font(.interMedium, size: 20)
        return label
    }(UILabel())

    lazy var discloseButton: UIButton = { button in
        button.setImage(Images.disclose.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var underlineView: UIView = { view in
        view.backgroundColor = .dividerColor
        return view
    }(UIView())

    lazy var categoriesCollectionView: UICollectionView = { collectionView in
        collectionView.register(CategoryValueCollectionViewCell.self, forCellWithReuseIdentifier: CategoryValueCollectionViewCell.className)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }(UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout()))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCurrentCardsValue(_ value: Double) {
        priceLabel.text = value.formattedAsPrice
        priceLabel.setLineHeight(22)
        priceLabel.lineBreakMode = .byTruncatingMiddle
    }

    func setCategoryValues(_ values: [(CardCategory, Double)]) {
        self.categoryValues = values
        categoriesCollectionView.reloadData()
        updateCategoriesViewHeight()
    }

}

private extension CurrentCardsValueView {
    func setupSubviews_unique() {
        backgroundColor = .white
        cornerRadius = 12

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }

        addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(12)
        }

        addSubview(discloseButton)
        discloseButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.top.trailing.equalToSuperview().inset(6)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
        }

        addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview().inset(16)
            categoriesViewHeightConstraint = $0.height.equalTo(0).constraint
        }
    }

    func updateCategoriesViewHeight() {
        let categoriesCountInColumn = CGFloat(categoryValues.count) / 2
        let categoriesViewHeight = categoriesCountInColumn.rounded(.up) * CategoryValueCollectionViewCell.cellHeight
        categoriesViewHeightConstraint?.update(offset: categoriesViewHeight)
    }

    func categoryValue(at indexPath: IndexPath) -> (CardCategory, Double)? {
        categoryValues[safe: indexPath.row]
    }

    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 0
        return layout
    }
}

// MARK: - CollectionView DataSource

extension CurrentCardsValueView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return categoryValues.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryValueCollectionViewCell.className, for: indexPath) as? CategoryValueCollectionViewCell

        if let categoryValue = categoryValue(at: indexPath) {
            cell?.set(category: categoryValue.0, value: categoryValue.1)
        }

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - 20) / 2
        let itemHeight = CategoryValueCollectionViewCell.cellHeight
        return .init(width: itemWidth, height: itemHeight)
    }
}
