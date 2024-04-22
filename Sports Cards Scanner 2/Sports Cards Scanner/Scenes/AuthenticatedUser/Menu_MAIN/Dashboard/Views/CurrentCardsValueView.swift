import UIKit
import SnapKit

final class CurrentCardsValueView: UIView {

    private var categoryValues: [(CardCategory, Double)] = []

    private var categoriesViewHeightConstraint: Constraint?
    private var spacing: CGFloat?
    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Dashboard.currentValue
        label.textColor = .logInLabel
        label.font = .font(.ubuntuMedium500, size: 24)
        return label
    }(UILabel())

    lazy var customViewOne: UIView = .init()
    lazy var customViewTwo: UIView = .init()

    lazy var priceLabel: UILabel = { label in
        label.textColor = .greenColor
        label.textAlignment = .left
        label.font = .font(.ubuntuBold700, size: 24)
        return label
    }(UILabel())

    lazy var discloseButton: UIButton = { button in
        button.setImage(Images.disclose.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var coverButton: UIImageView = { image in
        image.layer.cornerRadius = 14
        image.image = Images.disclose.image
        return image
    }(UIImageView())

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
        backgroundColor = .clear
        customViewOne.backgroundColor = .skyBlue
        customViewTwo.backgroundColor = .skyBlue
        customViewOne.layer.cornerRadius = 16
        customViewTwo.layer.cornerRadius = 16

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.equalTo(160)
            $0.height.equalTo(30)
        }

        addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
            $0.height.equalTo(30)
        }

        addSubview(discloseButton)
        discloseButton.snp.makeConstraints {
            $0.size.equalTo(28)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
        }

        discloseButton.addSubview(coverButton)
        coverButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let stackView = UIStackView(arrangedSubviews: [customViewOne, customViewTwo])

        addSubview(stackView)

        addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview().inset(24)
            categoriesViewHeightConstraint = $0.height.equalTo(0).constraint
        }
        stackView.spacing = self.spacing ?? 10
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { make in
            make.size.equalTo(categoriesCollectionView).offset(24)
            make.center.equalTo(categoriesCollectionView)
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
        spacing = collectionView.bounds.width - 2 * itemWidth
        let itemHeight = CategoryValueCollectionViewCell.cellHeight
        return .init(width: itemWidth, height: itemHeight)
    }
}
