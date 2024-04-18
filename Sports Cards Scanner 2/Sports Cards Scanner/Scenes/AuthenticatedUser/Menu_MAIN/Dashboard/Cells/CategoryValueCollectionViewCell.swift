import UIKit
import SnapKit

final class CategoryValueCollectionViewCell: UICollectionViewCell {

    static let cellHeight: CGFloat = 36

    lazy var categoryLabel: UILabel = { label in
        label.textColor = .labelColor
        label.font = .font(.ubuntuRegular400, size: 14)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }(UILabel())

    lazy var priceLabel: UILabel = { label in
        label.textColor = .greenColor
        label.font = .font(.ubuntuRegular400, size: 14)
        label.lineBreakMode = .byTruncatingMiddle
        label.textAlignment = .right
        return label
    }(UILabel())

      override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(category: CardCategory, value: Double) {
        categoryLabel.text = category.shortTitle
        priceLabel.text = value.formattedAsPrice
    }

}

private extension CategoryValueCollectionViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        let containerView = UIView()
        containerView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.height.equalTo(Self.cellHeight)
            $0.edges.equalToSuperview()
        }

        containerView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalToSuperview()
        }

        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.trailing.equalToSuperview().inset(4)
            $0.leading.greaterThanOrEqualTo(categoryLabel.snp.trailing).offset(8)
        }

    }
}
